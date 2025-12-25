import 'dart:async';

import 'package:e_commerce/common/widgets/screens/success_screen.dart';
import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/utils/constant/images.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Variables
  Timer? _emailVerificationTimer;

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  @override
  void onClose() {
    _emailVerificationTimer?.cancel();
    super.onClose();
  }

  /// Send Email Verification Link to current user
  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      ZSnackBarHelpers.successSnackBar(
          title: "Email Sent",
          message: "Please check your inbox and verify your email"
      );
    } catch (e) {
      ZSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  /// Timer to Automatically Redirect on Email Verification
  void setTimerForAutoRedirect() {
    _emailVerificationTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;

        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(() => SuccessScreen(
            title: ZTexts.accountCreatedTitle,
            subTitle: ZTexts.accountCreatedSubTitle,
            image: ZImages.successfulPaymentIcon,
            onTap: () => AuthenticationRepository.instance.screenRedirect(),
          ));
        }
      } catch (e) {
        timer.cancel();
        ZSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
      }
    });
  }

  /// Manually check if email is verified
  Future<void> checkEmailVerificationStatus() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null && currentUser.emailVerified) {
        Get.off(() => SuccessScreen(
          title: ZTexts.accountCreatedTitle,
          subTitle: ZTexts.accountCreatedSubTitle,
          image: ZImages.successfulPaymentIcon,
          onTap: () => AuthenticationRepository.instance.screenRedirect(),
        ));
      } else {
        ZSnackBarHelpers.warningSnackBar(
            title: "Not Verified",
            message: "Email not verified yet. Please check your inbox."
        );
      }
    } catch (e) {
      ZSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}