

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../../utils/constant/apis.dart';
import '../../utils/constant/keys.dart';

class CloudinaryServices extends GetxController{

  static CloudinaryServices get instance => Get.find();


  /// Variables
  final _dio = dio.Dio();


  /// [UploadImage] - Function to upload user Image
  Future<dio.Response> uploadImage(File image , String folderName) async{

    try{

      String api = ZApiUrls.uploadApi(ZKeys.cloudName);
      final formData = dio.FormData.fromMap({
        "upload_preset":ZKeys.uploadPreset,
        "folder": folderName,
        "file": await dio.MultipartFile.fromFile(image.path , filename: image.path.split("/").last),

      });


      dio.Response response = await _dio.post(api , data: formData);
      return response;

    }catch(e){
      throw "Failed to upload profile picture. Please try again";
    }
  }


  /// [DeleteImage] - Function to delete Image
  Future<dio.Response> deleteImage(String publicId) async {
    try {


      String api = ZApiUrls.deleteApi(ZKeys.cloudName);

      int timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();

      String signatureBase = "public_id=$publicId&timestamp=$timestamp${ZKeys.apiSecret}";
      String signature = sha1.convert(utf8.encode(signatureBase)).toString();

      final formData = dio.FormData.fromMap({
        "public_id":publicId,
        "api_key": ZKeys.apiKey,
        "timestamp": timestamp,
        "signature":signature,

      });

      dio.Response response = await _dio.post(api, data:formData);

      return response;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}