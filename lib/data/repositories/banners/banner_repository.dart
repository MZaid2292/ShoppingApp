import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/services/cloudinary_services.dart';
import 'package:e_commerce/features/shop/models/banners_model.dart';
import 'package:e_commerce/utils/constant/keys.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  /// [UploadBanners] - Function to upload list of banners
  Future<void> uploadBanners(List<BannerModel> banners) async {
    try {
      for (final banner in banners) {
        // Convert asset path to file
        File image = await ZHelperFunctions.assetToFile(banner.imageUrl);

        // Upload Banner to cloudinary
        dio.Response response = await _cloudinaryServices.uploadImage(
          image,
          ZKeys.bannersFolder,
        );
        if (response.statusCode == 200) {
          banner.imageUrl = response.data["url"];
        }

        await _db
            .collection(ZKeys.bannersCollection)
            .doc()
            .set(banner.toJson());
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

  /// [FetchBanners] -
  Future<List<BannerModel>> fetchActiveBanners() async {
    try {
      final query = await _db
          .collection(ZKeys.bannersCollection)
          .where("active", isEqualTo: true)
          .get();
      if (query.docs.isNotEmpty) {
        List<BannerModel> banners = query.docs
            .map((document) => BannerModel.fromDocument(document))
            .toList();
        return banners;
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
