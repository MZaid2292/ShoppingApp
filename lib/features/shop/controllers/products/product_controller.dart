


import 'package:e_commerce/data/repositories/products/product_repository.dart';
import 'package:e_commerce/utils/constant/enums.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';


class ProductController extends GetxController{
 static  ProductController get instance => Get.find();


  /// Variables
  final _repository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxBool isLoading = false.obs;



  @override
  void onInit() {
    getFeaturedProduct();
    super.onInit();
  }

  /// Function to get all products
  Future<List<ProductModel>> getAllProducts() async{

    try{
      List<ProductModel> products = await _repository.fetchAllProducts();
      return products;

    }catch(e){
      ZSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
      return [];
    }
  }

  /// Function to get only 4 featured products
  Future<void> getFeaturedProduct() async{

    try{

      // Start Loading
      isLoading.value = true;

      // Fetch Featured Products
      List<ProductModel> featuredProducts = await _repository.fetchFeaturedProducts();
      // Assign Featured Products
      this.featuredProducts.assignAll(featuredProducts);

    }catch(e){
      ZSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    }finally{
      isLoading.value = false;
  }
  }


 /// Function to get all featured products
 Future<List<ProductModel>> getAllFeaturedProduct() async{

   try{

     // Fetch Featured Products
     List<ProductModel> featuredProducts = await _repository.fetchAllFeaturedProducts();
     return featuredProducts;


   }catch(e){
     ZSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
     return [];
   }
 }


  /// Calculate sale Percentage
  String? calculateSalePercentage(double originalPrice , double? salePrice){

    if(salePrice == null || salePrice<= 0.0) return null;

    if(originalPrice <= 0.0) return null;

    double percentage = originalPrice - salePrice / originalPrice * 100;
    return percentage.toStringAsFixed(1);

  }


  /// Get Product price or Price range for variable product
  String getProductPrice(ProductModel product){
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;


    /// Single Product If no variation exist, return the single price or sale price
    if(product.productType == ProductType.single.toString()){
      return product.salePrice > 0 ? product.salePrice.toString() : product.price.toString();
    }


    else{

      /// Calculate smallest and largest price among variations
      for(final variation in product.productVariations!){
        double variationPrice = variation.salePrice > 0 ? variation.salePrice : variation.price;

        if(variationPrice > largestPrice){
          largestPrice = variationPrice;
        }

        if(variationPrice < smallestPrice){
          smallestPrice = variationPrice;
        }
      }


      if(smallestPrice.isEqual(largestPrice)){
        return largestPrice.toStringAsFixed(0);
      }else{
        return "${largestPrice.toStringAsFixed(0)} - ${ZTexts.currency}${smallestPrice.toStringAsFixed(0)}";
      }
    }
  }


  String getProductStockStatus(int stock){
    return stock > 0 ? "In Stock" : "Out Of Stock";
  }

}