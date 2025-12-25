import 'dart:io';

import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/data/repositories/user/user_repository.dart';
import 'package:e_commerce/features/authetication/screens/login_screen/login.dart';
import 'package:e_commerce/features/models/user_model.dart';
import 'package:e_commerce/features/personalization/screens/edit_profile/widgets/re_authenticate_user_form.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController {
  static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  RxBool profileLoading = false.obs;
  RxBool isProfileUploading = false.obs;



  ///Re-Authenticate Form Variables
  final email = TextEditingController();
  final password = TextEditingController();
  final reAuthFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = false.obs;

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  ///variables
  final _userRepository = Get.put(UserRepository());

  ///Function to Save user record
  Future<void> saveUserRecord(UserCredential userCredential) async {
    try {

      //First update Rx variable and then check if user data is already stored. If not then stored
      await fetchUserDetails();
      if(user.value.id.isEmpty){
        //convert Full Name to First Name and Last Name
        final nameParts = UserModel.nameParts(userCredential.user!.displayName);
        final userName = "${userCredential.user!.displayName}21";

        // Creat User Model
        UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join("") : "",
          userName: userName,
          email: userCredential.user!.email ?? "",
          phoneNumber: userCredential.user!.phoneNumber ?? "",
          profilePicture: userCredential.user!.photoURL ?? "",
        );

        //Save User Record
        await _userRepository.saveUserRecord(userModel);

      }


    } catch (e) {
      ZSnackBarHelpers.warningSnackBar(
        title: "Data not saved",
        message: "Something went wrong while saving your information",
      );
    }
  }

  ///Function to fetch user details
  Future<void> fetchUserDetails() async {
    try {
      profileLoading.value = true;
      UserModel user = await _userRepository.fetchUserDetails();
      this.user(user); // We can also do that this.user(value) = user;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// [Popup] - To Delete Account Confirmation
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(ZSizes.md),
      title: "Delete Account",
      middleText: "Are you sure you want to delete your account permanently?",
      confirm: ElevatedButton(
        onPressed: () => deleteUserAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red , side: BorderSide(color: Colors.red)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: ZSizes.lg),
          child: Text("Confirm"),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: Text("Cancel"),
      ),
    );
  }

  /// Delete Account
  Future<void> deleteUserAccount() async{
    try{
    // Start Loading
      ZFullScreenLoader.openLoadingDialog("Processing...");

      //Re-Authenticate User
      final authRepository = AuthenticationRepository.instance;
      final provider = authRepository.currentUser!.providerData.map((e) => e.providerId).first;

      ///If Google Provider
      if(provider == "google.com"){
        await authRepository.signInWithGoogle();
        await authRepository.deleteAccount();
        ZFullScreenLoader.stopLoading();
        Get.offAll(() => LoginScreen());

        ///If Email/Password provider
      }else if(provider == "password"){
        ZFullScreenLoader.stopLoading();
        Get.to(() => ReAuthenticateUserFormScreen());
      }

    }catch(e){
      ZFullScreenLoader.stopLoading();
      ZSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());

    }
  }


  /// Re-Authenticate User with email and password
  Future<void> reAuthenticateUser() async{
    try{
    //   Start loading
      ZFullScreenLoader.openLoadingDialog("Processing...");

    //   Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        ZFullScreenLoader.stopLoading();
        // ZSnackBarHelpers.warningSnackBar(title: "No Internet Connection");
        return;
      }

      //Form Validation
      if(!reAuthFormKey.currentState!.validate()){
        ZFullScreenLoader.stopLoading();
        return;
      }


      //Re-Authenticate User with email and password
      await AuthenticationRepository.instance.reAuthenticateUserWithEmailAndPassword(email.text.trim(), password.text.trim());
      await AuthenticationRepository.instance.deleteAccount();

      ZFullScreenLoader.stopLoading();

      //Redirect
      Get.offAll(() => LoginScreen());
    }catch(e){
      ZFullScreenLoader.stopLoading();
      ZSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    }
  }



  /// Update User Profile Picture
  Future<void> updateUserProfilePicture() async{
    try{

      //Start Loading
      isProfileUploading.value = true;

      //Pick Image from gallery
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery , maxHeight: 512, maxWidth: 512);
      if(image == null) return;


      //Convert XFile to File
      File file = File(image.path);


      //Delete user current Profile picture
      if(user.value.publicId.isNotEmpty){
        await _userRepository.deleteProfilePicture(user.value.publicId);
      }


      //Upload Profile picture to Cloudinary
      dio.Response response = await _userRepository.uploadImage(file);
      if(response.statusCode == 200){

        //Get Data
        final data = response.data;
        final imageUrl = data["url"];
        final publicId = data["public_id"];

        // Update profile picture from firestore
       await _userRepository.updateSingleField({"profilePicture" : imageUrl , "publicId":publicId});

       // Update Profile picture and publicId from Rx User
       user.value.profilePicture = imageUrl;
       user.value.publicId = publicId;

       user.refresh();

       //success message
        ZSnackBarHelpers.successSnackBar(title: "Congratulation",message: "Profile Picture updated successfully");

      }else{
        throw "Failed to upload profile picture. Pleas try again";
      }


    }catch(e){
      ZSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    }finally{
      isProfileUploading.value = false;
    }
  }


  }

