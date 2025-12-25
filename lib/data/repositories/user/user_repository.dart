import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/data/services/cloudinary_services.dart';
import 'package:e_commerce/features/models/user_model.dart';
import 'package:e_commerce/utils/constant/keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  ///Function to store User Data
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db
          .collection(ZKeys.userCollection)
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
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

  /// [Read] - Function to fetch users details based on current user
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection(ZKeys.userCollection)
          .doc(AuthenticationRepository.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        UserModel user = UserModel.fromSnapshot(documentSnapshot);
        return user;
      }

      return UserModel.empty();
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
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

  /// [Update] - Function to update users details
  Future<void> updateSingleField(Map<String, dynamic> map) async {
    try {
      await _db
          .collection(ZKeys.userCollection)
          .doc(AuthenticationRepository.instance.currentUser!.uid)
          .update(map);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
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

  ///[Delete] - Function to Delete users details
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection(ZKeys.userCollection).doc(userId).delete();
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
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

  /// [UploadImage] - Function to upload user profile picture
  Future<dio.Response> uploadImage(File image) async {
    try {
      dio.Response response = await _cloudinaryServices.uploadImage(
        image,
        ZKeys.profileFolder,
      );
      return response;
    } catch (e) {
      throw "Failed to upload profile picture. Please try again";
    }
  }

  /// [DeleteImage] - Function to delete profile picture
  Future<dio.Response> deleteProfilePicture(String publicId) async {
    try {
      dio.Response response = await _cloudinaryServices.deleteImage(publicId);

      return response;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}
