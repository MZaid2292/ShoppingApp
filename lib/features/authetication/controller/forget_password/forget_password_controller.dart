import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/features/authetication/screens/forget_password/reset_password.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{

  static ForgetPasswordController get instance => Get.find();

  ///Variables
  final email = TextEditingController();
  final forgetPasswordFormKey = GlobalKey<FormState>();

  //Send Email to Forget Password
  Future<void> sendPasswordResetEmail() async{
    try{

      //Start Loading
      ZFullScreenLoader.openLoadingDialog("Processing your request....");

      // Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        ZFullScreenLoader.stopLoading();
        ZSnackBarHelpers.warningSnackBar(title: "No Internet Connection");
        return;
      }

      //Form Validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        ZFullScreenLoader.stopLoading();
        return;
      }

      //Send Email to Reset password
      AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //Stop Loading
      ZFullScreenLoader.stopLoading();

      //Success Message
      ZSnackBarHelpers.successSnackBar(title: "Email Send",message: "Email link sent to Reset your password");


      //Redirect 
      Get.to(() =>ResetPasswordScreen(email: email.text.trim()));

    }catch(e){
      ZFullScreenLoader.stopLoading();
      ZSnackBarHelpers.errorSnackBar(title: "Failed Forget Password",message: e.toString());

    }
  }


  Future<void> resendPasswordResetEmail() async{
    try{

      //Start Loading
      ZFullScreenLoader.openLoadingDialog("Processing your request....");

      // Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        ZFullScreenLoader.stopLoading();
        ZSnackBarHelpers.warningSnackBar(title: "No Internet Connection");
        return;
      }

    
      //Send Email to Reset password
      AuthenticationRepository.instance.sendPasswordResetEmail(email.text);

      //Stop Loading
      ZFullScreenLoader.stopLoading();

      //Success Message
      ZSnackBarHelpers.successSnackBar(title: "Email Send",message: "Email link sent to Reset your password");




    }catch(e){
      ZFullScreenLoader.stopLoading();
      ZSnackBarHelpers.errorSnackBar(title: "Failed Forget Password",message: e.toString());

    }
  }


}