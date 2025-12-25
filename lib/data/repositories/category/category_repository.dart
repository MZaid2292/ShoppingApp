import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/services/cloudinary_services.dart';
import 'package:e_commerce/features/shop/models/brand_category_model.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/models/product_category_model.dart';
import 'package:e_commerce/utils/constant/keys.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  ///[Upload] - Function upload list of brand categories
  Future<void> uploadBrandCategories(List<BrandCategoryModel> brandCategories,) async {
    try {
      for (final brandCategory in brandCategories) {
        await _db
            .collection(ZKeys.brandCategoryCollection)
            .doc()
            .set(brandCategory.toJson());
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

  ///[Upload] - Function upload list of product categories
  Future<void> uploadProductCategories(List<ProductCategoryModel> productCategories,) async {
    try {
      for (final productCategory in productCategories) {
        await _db
            .collection(ZKeys.productCategoryCollection)
            .doc()
            .set(productCategory.toJson());
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

  /// [UploadCategory] - Function to upload list of categories
  Future<void> uploadCategories(List<CategoryModel> categories) async {
    try {
      for (final category in categories) {
        File image = await ZHelperFunctions.assetToFile(category.image);
        dio.Response response = await _cloudinaryServices.uploadImage(
          image,
          ZKeys.categoryFolder,
        );
        if (response.statusCode == 200) {
          category.image = response.data["url"];
        }

        _db
            .collection(ZKeys.categoriesCollection)
            .doc(category.id)
            .set(category.toJson());
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

  /// [FetchCategories] - Function to Fetch list of categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final query = await _db.collection(ZKeys.categoriesCollection).get();
      if (query.docs.isNotEmpty) {
        List<CategoryModel> categories = query.docs
            .map((document) => CategoryModel.fromSnapshot(document))
            .toList();
        return categories;
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

  /// [FetchSubCategories] - Function to Fetch list of subCategories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final query = await _db
          .collection(ZKeys.categoriesCollection)
          .where("parentId", isEqualTo: categoryId)
          .get();
      if (query.docs.isNotEmpty) {
        List<CategoryModel> categories = query.docs
            .map((document) => CategoryModel.fromSnapshot(document))
            .toList();
        return categories;
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
