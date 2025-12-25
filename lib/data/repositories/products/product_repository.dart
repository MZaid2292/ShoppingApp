import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/services/cloudinary_services.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../utils/constant/keys.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  /// [UploadProducts] - Function to upload list of categories
  Future<void> uploadProducts(List<ProductModel> products) async {
    try {
      for (ProductModel product in products) {
        final Map<String, String> uploadedImageMap = {};

        // Upload thumbnail to cloudinary
        File thumbnailFile = await ZHelperFunctions.assetToFile(
          product.thumbnail,
        );
        dio.Response response = await _cloudinaryServices.uploadImage(
          thumbnailFile,
          ZKeys.productFolder,
        );
        if (response.statusCode == 200) {
          String url = response.data["url"];
          uploadedImageMap[product.thumbnail] = url;
          product.thumbnail = url;
        }

        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrls = [];

          // Upload Images one by one
          for (String image in product.images!) {
            File imageFile = await ZHelperFunctions.assetToFile(image);
            dio.Response response = await _cloudinaryServices.uploadImage(
              imageFile,
              ZKeys.productFolder,
            );
            if (response.statusCode == 200) {
              imageUrls.add(response.data["url"]);
            }
          }

          // Upload product variation images
          if (product.productVariations != null &&
              product.productVariations!.isNotEmpty) {
            for (int i = 0; i < product.images!.length; i++) {
              uploadedImageMap[product.images![i]] = imageUrls[i];
            }

            for (final variation in product.productVariations!) {
              final match = uploadedImageMap.entries.firstWhere(
                (entry) => entry.key == variation.image,
                orElse: () => MapEntry("", ""),
              );

              if (match.key.isNotEmpty) {
                variation.image = match.value;
              }
            }
          }

          // Assign image urls to product
          product.images!.clear();
          product.images!.assignAll(imageUrls);
        }

        // Upload Product to Firestore
        await _db
            .collection(ZKeys.productsCollection)
            .doc(product.id)
            .set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [Fetch] - Function to fetch list of products from firebase
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final query = await _db.collection(ZKeys.productsCollection).get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [FetchProducts] - Function to fetch list of products from Firebase
  Future<List<ProductModel>> fetchFeaturedProducts() async {
    try {
      final query = await _db
          .collection(ZKeys.productsCollection)
          .where("isFeatured", isEqualTo: true)
          .limit(4)
          .get();
      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [FetchProducts] - Function to fetch all list of products from Firebase
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final query = await _db
          .collection(ZKeys.productsCollection)
          .where("isFeatured", isEqualTo: true)
          .get();
      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [FetchProducts] - Function to fetch all list of products from Query
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty) {
        List<ProductModel> products = querySnapshot.docs
            .map((document) => ProductModel.fromQuerySnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [FetchProducts] - Function to fetch all list of brand specific products
  Future<List<ProductModel>> getProductsForBrand({required String brandId, int limit = -1,}) async  {
    try {
      final query = limit == -1
          ? await _db
                .collection(ZKeys.productsCollection)
                .where("brand.id", isEqualTo: brandId)
                .get()
          : await _db
                .collection(ZKeys.productsCollection)
                .where("brand.id", isEqualTo: brandId)
                .limit(limit)
                .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [FetchProducts] - Function to fetch all list of brand specific products
  Future<List<ProductModel>> getProductsForCategory({
    required String categoryId,
    int limit = 4,
  }) async {
    try {
      final productCategoryQuery = limit == -1
          ? await _db
                .collection(ZKeys.productCategoryCollection)
                .where("categoryId", isEqualTo: categoryId)
                .get()
          : await _db
                .collection(ZKeys.productCategoryCollection)
                .where("categoryId", isEqualTo: categoryId)
                .limit(limit)
                .get();

      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc["productId"] as String)
          .toList();

      final productQuery = await _db
          .collection(ZKeys.productsCollection)
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductModel> products = productQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }

  /// [FetchProducts] - Function to fetch list of products from Firebase
  Future<List<ProductModel>> getFavouriteProduct(
    List<String> productsIds,
  ) async {
    try {
      final query = await _db
          .collection(ZKeys.productsCollection)
          .where(FieldPath.documentId, whereIn: productsIds)
          .get();
      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException {
      throw ZFormatExceptions();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong Please try again";
    }
  }
}
