


import 'package:e_commerce/data/repositories/brands/brand_repository.dart';
import 'package:e_commerce/data/repositories/products/product_repository.dart';
import 'package:e_commerce/features/shop/models/brands_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:get/get.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();



  /// Variables
  final _repository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  /// Get all Brands and Featured Brands
  Future<void> getBrands() async{

    try{

      // Start Loading
      isLoading.value = true;

      List<BrandModel> allBrands = await _repository.fetchBrands();
      this.allBrands.assignAll(allBrands); //This means class wala variable
      
      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).toList());


    }catch(e){
      ZSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }


  /// Get Brands Specific Products
  Future<List<ProductModel>> getBrandProducts(String brandId , {int limit = -1}) async{

    try{

      List<ProductModel> products = await ProductRepository.instance.getProductsForBrand(brandId: brandId , limit: limit);
      return products;

    }catch(e){
      ZSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
      return [];
    }
  }



  /// Get brand for specific Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId)async{

    try{

      final brands = await _repository.fetchBrandsForCategory(categoryId);
      return brands;

    }catch(e){
      ZSnackBarHelpers.errorSnackBar(title: "Failed!",message: e.toString());
      return [];
    }

  }

}