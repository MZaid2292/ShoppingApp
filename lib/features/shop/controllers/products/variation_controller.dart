import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/controllers/products/image_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variables
  RxMap selectedAttributes = {}.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;
  RxString variationStockStatus = "".obs;

  /// Select Attribute and Variation
  void onAttributeSelected(ProductModel product, attributeName, attributeValue) {
    Map<String, dynamic> selectedAttributes = Map<String, dynamic>.from(
      this.selectedAttributes,
    );
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    ProductVariationModel selectedVariation = product.productVariations!
        .firstWhere(
          (variation) => isSameAttributeValue(
            variation.attributeValues,
            selectedAttributes),orElse: () => ProductVariationModel.empty()
        );

    // Show the selected variation image as main image
    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    if(selectedVariation.id.isNotEmpty){
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(product.id, selectedVariation.id);

    }

    // Assign selected variation to Rx Variable
    this.selectedVariation(
      selectedVariation,
    ); // this.selectedVariation.value = selectedVariation
    getProductVariationStockStatus();
  }

  /// Check if selected attributes matches any variation attributes
  bool isSameAttributeValue(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) {
    // If selected attribute contains 3 attributes and current variation contains 2 then return
    if (variationAttributes.length != selectedAttributes.length) return false;

    // if any of the attribute is different then return ["Green" , "Large"] != ["Green", "Small"]
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }



  Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName) {
    // Pass the variation to check which attributes are available and stock is not 0
    final availableAttributesValues = variations.where(
      (variation) =>
          variation.attributeValues[attributeName]!.isNotEmpty &&
          variation.attributeValues[attributeName] != null &&
          variation.stock > 0
    ).map((variation) => variation.attributeValues[attributeName]).toSet();

    return availableAttributesValues;
  }



  /// Get Product variation price
  String getVarionPrice(){
    return (selectedVariation.value.salePrice > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toStringAsFixed(0);
  }


  /// Check product variation stock status
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0
        ? "In Stock"
        : "Out Of Stock";
  }

  /// Reset Selected Attributes when switching products
  void resetSelectedAttributes(){
    selectedAttributes.clear();
    variationStockStatus.value = "";
    selectedVariation.value = ProductVariationModel.empty();
  }
}
