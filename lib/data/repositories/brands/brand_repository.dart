import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/services/cloudinary_services.dart';
import 'package:e_commerce/features/shop/models/brand_category_model.dart';
import 'package:e_commerce/features/shop/models/brands_model.dart';
import 'package:e_commerce/utils/constant/keys.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  /// [Upload] - Function to upload all brands
  Future<void> uploadBrands(List<BrandModel> brands) async {
    try {
      for (BrandModel brand in brands) {
        // Convert asset path to file
        File brandImage = await ZHelperFunctions.assetToFile(brand.image);

        // Upload brand image to cloudinary
        dio.Response response = await _cloudinaryServices.uploadImage(
          brandImage,
          ZKeys.brandFolder,
        );
        if (response.statusCode == 200) {
          brand.image = response.data["url"];
        }

        // Store data to Firebase firestore
        await _db
            .collection(ZKeys.brandCollection)
            .doc(brand.id)
            .set(brand.toJson());
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

  /// [Fetch] - Function to get all brands
  Future<List<BrandModel>> fetchBrands() async {
    try {
      final query = await _db.collection(ZKeys.brandCollection).get();
      if (query.docs.isNotEmpty) {
        List<BrandModel> brands = query.docs
            .map((document) => BrandModel.fromSnapshot(document))
            .toList();
        return brands;
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

  /// [Fetch] - Function to get category specific brands
  Future<List<BrandModel>> fetchBrandsForCategory(String categoryId) async {
    try {
      // Query to get all documents where categoryId matches the provided categoryId
      final brandCategoryQuery = await _db
          .collection(ZKeys.brandCategoryCollection)
          .where("categoryId", isEqualTo: categoryId)
          .get();

      // Convert document to model
      List<BrandCategoryModel> brandCategories = brandCategoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();

      // Extract the brandIds from BrandCategoryModel
      List<String> brandIds = brandCategories
          .map((brandCategory) => brandCategory.brandId)
          .toList();

      // Query to get brand based on brandIds
      final brandQuery = await _db
          .collection(ZKeys.brandCollection)
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      // Convert document to model
      List<BrandModel> brands = brandQuery.docs
          .map((doc) => BrandModel.fromSnapshot(doc))
          .toList();

      return brands;
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
