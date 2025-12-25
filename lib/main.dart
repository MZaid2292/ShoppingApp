import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

Future<void> main() async {

  /// Widgets flutter Binding
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  ///Flutter Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  ///Show for just 2 or 3 seconds for that I will use
  // FlutterNativeSplash.remove();


  ///Get Storage Initialization
  await GetStorage.init();


  ///Firebase Initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform).then((value) {
      ///Means when first time Firebase connected successfully then what happened.
      Get.put(AuthenticationRepository());

    },);

///Portrait Up The device
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}




