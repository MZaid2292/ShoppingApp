

import 'dart:convert';

import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/data/repositories/products/product_repository.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/product_model.dart';

class FavouriteController extends GetxController{
  static FavouriteController instance = Get.find();


  /// Variables
  RxMap<String , bool> favourites = <String, bool> {}.obs;
  final _storage = GetStorage(AuthenticationRepository.instance.currentUser!.uid);


  @override
  void onInit() {
    initFavourites();
    super.onInit();
  }

  /// Load Favourites from local storage
  Future<void> initFavourites() async{
    String? encodedFavourites =  _storage.read("favourites");
    if(encodedFavourites == null) return;
    Map<String , dynamic> storedFavourites = jsonDecode(encodedFavourites) as Map<String , dynamic>;
    favourites.assignAll(storedFavourites.map((key, value) => MapEntry(key, value as bool)));
  }

  /// Function to add or remove product from wishlist
  void toggleFavouriteProduct(String productId){
    if(favourites.containsKey(productId)){
      favourites.remove(productId);
      saveFavouritesToStorage();
      ZSnackBarHelpers.customToast(message: "Product has been removed from the Wishlist");
      
    }else{
      favourites[productId] = true;
      saveFavouritesToStorage();
      ZSnackBarHelpers.customToast(message: "Product has been added to the Wishlist");
    }
  }


  /// Function to save favourites into the local storage
  void saveFavouritesToStorage(){

    String encodedFavourites = jsonEncode(favourites);
    _storage.write("favourites", encodedFavourites);
  }


  /// Check is product available in favourites
  bool isFavourite(String productId){
    return favourites[productId] ?? false;
  }


  /// Function to get all favourites products only
  Future<List<ProductModel>> getFavouriteProduct()async{

    final productsIds = favourites.keys.toList();
    return await ProductRepository.instance.getFavouriteProduct(productsIds);
  }
  
}