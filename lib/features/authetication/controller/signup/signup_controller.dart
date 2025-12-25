import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/data/repositories/user/user_repository.dart';
import 'package:e_commerce/features/authetication/screens/signup/verify_email.dart';
import 'package:e_commerce/features/models/user_model.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final _authRepository = Get.put(AuthenticationRepository());
  final signUpFormKey = GlobalKey<FormState>();

  RxBool isPasswordVisible = false.obs;
  RxBool privacyPolicy = false.obs;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phoneNumber.dispose();
    password.dispose();
    super.onClose();
  }

  /// Function to register the user with email and password
  Future<void> registerUser() async {
    try {
      // Start Loading
      ZFullScreenLoader.openLoadingDialog("We are processing your information...");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        ZSnackBarHelpers.warningSnackBar(title: "No Internet Connection");
        return;
      }

      // Check Privacy Policy
      if (!privacyPolicy.value) {
        ZFullScreenLoader.stopLoading();
        ZSnackBarHelpers.warningSnackBar(
            title: "Accept Privacy Policy",
            message: "In order to create account, you must have to read and accept the Privacy Policy & Terms of Use"
        );
        return;
      }

      // Form Validation
      if (!signUpFormKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Register the user using Firebase Authentication
      final userCredential = await _authRepository.registerUser(
          email.text.trim(),
          password.text.trim()
      );

      // Create User Model
      final userModel = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userName: "${firstName.text.trim()}${lastName.text.trim()}9745",
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: ""
      );

      // Save user record
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(userModel);

      // Stop loading before navigation
      ZFullScreenLoader.stopLoading();

      // Success Message
      ZSnackBarHelpers.successSnackBar(
          title: "Congratulations!",
          message: "Your account has been created! Verify email to continue"
      );

      // Redirect to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}