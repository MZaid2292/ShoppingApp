

import 'package:e_commerce/data/repositories/category/category_repository.dart';
import 'package:e_commerce/data/repositories/products/product_repository.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{

  static CategoryController get instance => Get.find();


  /// Variables
  final _repository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  RxBool isCategoriesLoading = false.obs;


  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// Function to fetch all categories & featured categories from firebase
  Future<void> fetchCategories() async{

    try{

      //start loading
      isCategoriesLoading.value = true;

      // fetch Categories
      List<CategoryModel> categories = await _repository.getAllCategories();
      allCategories.assignAll(categories);

      // Get featured categories
      featuredCategories.assignAll(categories.where((category) => category.isFeatured && category.parentId.isEmpty));

    }catch(e){
      ZSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());

    }finally{
      isCategoriesLoading.value = false;
    }
  }


  /// Get Category Products
  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4})async{

    try{

      final products = ProductRepository.instance.getProductsForCategory(categoryId: categoryId , limit: limit);

      return products;

    }catch(e){
      ZSnackBarHelpers.errorSnackBar(title: "Failed!",message: e.toString());
      return [];
    }
  }



  /// Get Sub categories of selected Categories.
  Future<List<CategoryModel>> getSubCategories(String categoryId) async{

    try{

      final subCategories = await _repository.getSubCategories(categoryId);
      return subCategories;


    }catch(e){
      ZSnackBarHelpers.errorSnackBar(title: "Failed!",message: e.toString());
      return [];
    }

  }


}