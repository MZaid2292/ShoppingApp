import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/utils/constant/keys.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{

  static LoginController get instance => Get.find();

  ///Variables



  final email = TextEditingController();
  final password = TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool rememberMe = false.obs;

  final loginFormKey = GlobalKey<FormState>();

  final localStorage = GetStorage();


  @override
  void onInit() {
    email.text = localStorage.read(ZKeys.rememberMeEmail) ?? " ";
    password.text = localStorage.read(ZKeys.rememberMePassword) ?? " ";
    super.onInit();
  }

  ///Function to Login the User with Email and Password
  Future<void> loginWithEmailAndPassword()async{
    try{

      //Start Loading
      ZFullScreenLoader.openLoadingDialog("Logging you in...");


      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        ZFullScreenLoader.stopLoading();
        ZSnackBarHelpers.warningSnackBar(title: "No Internet Connection");
        return;
      }


      //Form Validation
      if(!loginFormKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      //Save Data if remember me is checked
      if(rememberMe.value){
        localStorage.write(ZKeys.rememberMeEmail, email.text.trim());
        localStorage.write(ZKeys.rememberMePassword, password.text.trim());
      }

      //Login User with Email and Password
     await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      ZFullScreenLoader.stopLoading();


      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    }
    catch(e){
     ZFullScreenLoader.stopLoading();
     ZSnackBarHelpers.errorSnackBar(title: "Login Failed",message: e.toString());
    }
  }


  ///Google Sign In Authentication
  Future<void> googleSignIn()async{
    try{

      //Start Loading
      ZFullScreenLoader.openLoadingDialog("Logging you in....");

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        ZFullScreenLoader.stopLoading();
        ZSnackBarHelpers.warningSnackBar(title: "No Internet Connection");
        return;
      }

      //Google Authentication
     UserCredential userCredential =  await AuthenticationRepository.instance.signInWithGoogle();


      //Save User Record
      await Get.put(UserController()).saveUserRecord(userCredential);



      //Stop Loading
      ZFullScreenLoader.stopLoading();


      //Redirect
      AuthenticationRepository.instance.screenRedirect();


    }catch(e){
      //Stop loading
      ZFullScreenLoader.stopLoading();

      //Error SnackBar
      ZSnackBarHelpers.errorSnackBar(title: "Login Failed",message: e.toString());
    }
  }
}