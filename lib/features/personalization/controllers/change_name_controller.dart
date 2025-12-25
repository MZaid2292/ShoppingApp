import 'package:e_commerce/data/repositories/user/user_repository.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeNameController extends GetxController{

  static ChangeNameController get instance => Get.find();


  ///variables
  final _userController = UserController.instance;
  final _userRepository = UserRepository.instance;
  final firstName = TextEditingController();
  final lastName = TextEditingController();

  final updateUserFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }


  void initializeNames(){
    firstName.text = _userController.user.value.firstName;
    lastName.text = _userController.user.value.lastName;

  }


  Future<void> updateUserName() async{
    try{

      //Start Loading
      ZFullScreenLoader.openLoadingDialog("We are updating your information...");

      //Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        ZFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if(!updateUserFormKey.currentState!.validate()){
        ZFullScreenLoader.stopLoading();
        return;
      }

      //Update User Name from firestore
      Map<String , dynamic> map = ({"firstName":firstName.text, "lastName":lastName.text});
      await _userRepository.updateSingleField(map);

      //Update user from Rx variable
      _userController.user.value.firstName = firstName.text;
      _userController.user.value.lastName = lastName.text;

      //Stop loading
      ZFullScreenLoader.stopLoading();

      //Redirect
      Get.offAll(() => NavigationMenu());

      //Success Message
      ZSnackBarHelpers.successSnackBar(title: "Congratulation" , message: "Your name has been updated");

    }catch(e){
      ZFullScreenLoader.stopLoading();
      ZSnackBarHelpers.errorSnackBar(title: "Update Name Failed!",message: e.toString());
    }
  }

}