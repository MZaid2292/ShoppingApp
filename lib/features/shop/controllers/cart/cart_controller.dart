

import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/features/shop/controllers/products/variation_controller.dart';
import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/models/product_variation_model.dart';
import 'package:e_commerce/features/shop/screen/checkout/checkout.dart';
import 'package:e_commerce/utils/constant/enums.dart';
import 'package:e_commerce/utils/constant/keys.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController{
  static CartController get instance => Get.find();


  /// Variables
  final _storage = GetStorage(AuthenticationRepository.instance.currentUser!.uid);
  RxInt noOfCartItem = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  final variationController = VariationController.instance;


 CartController(){
   loadCartItems();
 }

  /// Load all cart items from the local storage
  void loadCartItems(){
    List<dynamic>? storedCartItems = _storage.read(ZKeys.cartItemsKey);
    if(storedCartItems != null){
      cartItems.assignAll(storedCartItems.map((item) => CartItemModel.fromJson(item as Map<String , dynamic>)));
      updateCartTotals();

    }
  }


  /// Add Items in the cart
  void addToCart(ProductModel product){
    // Check quantity of the product
    if(productQuantityInCart < 1){
      ZSnackBarHelpers.customToast(message: "Select Quantity");
      return;
    }

    // Check Variation of product if it is variable product
    if(product.productType == ProductType.variable.toString() && variationController.selectedVariation.value.id.isEmpty){
      ZSnackBarHelpers.customToast(message: "Select Variation");
      return;
    }

    // Out of stock Status
    if(product.productType == ProductType.variable.toString()){
      if(variationController.selectedVariation.value.stock < 1){
        ZSnackBarHelpers.warningSnackBar(title: "Out of Stock",message: "This variation is out of stock");
        return;
      }
    }else{
      if(product.stock < 1){
        ZSnackBarHelpers.warningSnackBar(title: "Out of Stock",message: "This product is out of stock");
        return;
      }
    }

    // Convert the ProductModel to CartItemModel with given quantity.
    CartItemModel selectedCartItem = convertToCartItem(product, productQuantityInCart.value);

    //Check if already added in the cart
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == selectedCartItem.productId && selectedCartItem.variationId == cartItem.variationId);
    if(index >= 0){
      // This quantity is already added or updated/removed from the cart
      cartItems[index].quantity = selectedCartItem.quantity;
    }else{
      cartItems.add(selectedCartItem);
    }

    // Update Cart
    updateCart();

    // Show Message
    ZSnackBarHelpers.customToast(message: "Your product has been added to the cart");
  }

  /// Direct Checkout single product
  Future<void> checkout(ProductModel product) async{

   // Clear the cart
    cartItems.clear();

    // set quantity to 1 by default
    productQuantityInCart.value = 1;

    // Check Variation of product if it is variable product
    if(product.productType == ProductType.variable.toString() && variationController.selectedVariation.value.id.isEmpty){
      ZSnackBarHelpers.customToast(message: "Select Variation");
      return;
    }

    // Out of stock status
    if(product.productType == ProductType.variable.toString()){
      if(variationController.selectedVariation.value.stock < 1){
        ZSnackBarHelpers.warningSnackBar(title: "Out of Stock",message: "This variation is out of stock");
        return;
      }
    }
    else{
      if(product.stock < 1){
        ZSnackBarHelpers.warningSnackBar(title: "Out of stock",message: "This product is out of stock");
      }
    }

    // Convert the ProductModel to CartItemModel with given quantity
    CartItemModel selectedCartItem = convertToCartItem(product, productQuantityInCart.value);

    // Add item to cart
    cartItems.add(selectedCartItem);

    // update cart totals
    updateCartTotals();

    // redirect to checkout screen
    await Get.to(() => CheckoutScreen());

    // Load Previous cart items
    loadCartItems();
  }


  /// Add One Item to Cart
  void addOneToCart(CartItemModel item){
    int index = cartItems.indexWhere((cartItem) => item.productId == cartItem.productId && item.variationId == cartItem.variationId);
    if(index >= 0){
      cartItems[index].quantity +=1;
    }else{
      cartItems.add(item);
    }
    updateCart();
  }

  /// Remove one item from the cart
  void removeOneFromCart(CartItemModel item){
    int index = cartItems.indexWhere((cartItem) => item.productId == cartItem.productId && item.variationId == cartItem.variationId);
    if(index >= 0){
      if(cartItems[index].quantity > 1){
        cartItems[index].quantity -=1;
      }else{
        cartItems[index].quantity == 1 ? removeFromCartDialog(index) : cartItems.removeAt(index);
      }
    }

    updateCart();

  }

  /// Show dialog to remove item from the cart
  void removeFromCartDialog(int index){
    Get.defaultDialog(
      title: "Remove Product",
      middleText: "Are you sure you want to remove this product?",
      onConfirm: (){
        cartItems.removeAt(index);
        updateCart();
        ZSnackBarHelpers.customToast(message: "Product removed from the cart");
        Get.back();
      },
      onCancel: () {}
    );
  }

  /// Get total quantity of same specific product
  int getProductQuantityInCart(String productId){
    final itemQuantity = cartItems.where((cartItem) => cartItem.productId == productId).fold(
        0, (previousValue, cartItem) => previousValue + cartItem.quantity,
    );

    return itemQuantity;
  }

  /// Get Variation's quantity of the specific product
  int getVariationQuantityInCart(String productId , String variationId){
    CartItemModel cartItemModel = cartItems.firstWhere((item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty()
    );

    return cartItemModel.quantity;
  }

  /// Update Cart
  void updateCart(){
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  /// Save Cart Items into local storage
  void saveCartItems(){
    List<Map<String, dynamic>> cartItemsList = cartItems.map((item) => item.toJson()).toList();
    _storage.write(ZKeys.cartItemsKey, cartItemsList);
  }

  /// Update the total price & no of Items of the cart
  void updateCartTotals(){
    double calculateTotalPrice = 0.0;
    int calculateNoOfItems = 0;

    for(final items in cartItems){
      calculateTotalPrice += (items.price) * items.quantity.toDouble();
      calculateNoOfItems += items.quantity;
    }

    totalCartPrice.value = calculateTotalPrice;
    noOfCartItem.value = calculateNoOfItems;
  }

  /// Convert ProductModel to CartItemModel
   CartItemModel convertToCartItem(ProductModel product, int quantity){
    if(product.productType == ProductType.single.toString()){
      // Reset variation in case of single product type
      variationController.resetSelectedAttributes();
    }

    ProductVariationModel variation = variationController.selectedVariation.value;
    bool isVariation = variation.id.isNotEmpty;
    String image = isVariation ? variation.image : product.thumbnail;
    double price = isVariation ? variation.salePrice > 0.0 ? variation.salePrice : variation.price
     : product.salePrice > 0.0 ? product.salePrice : product.price;
    
    return CartItemModel(
        productId: product.id,
        quantity: quantity,
      title: product.title,
      brandName: product.brand != null ? product.brand!.name : "",
      image: image,
      price: price,
      selectedVariation: isVariation ? variation.attributeValues : null,
      variationId: variation.id
    );




  }

  /// Initialize already added items count in the cart
  void updateAlreadyAddedProductCount(ProductModel product){
    if(product.productType == ProductType.single.toString()){
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    }else{
      String variationId = variationController.selectedVariation.value.id;
      if(variationId.isNotEmpty){
        productQuantityInCart.value = getVariationQuantityInCart(product.id, variationId);
      }else{
        productQuantityInCart.value = 0;
      }
    }
  }

  /// Clear the Cart
  void clearCart(){
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

}