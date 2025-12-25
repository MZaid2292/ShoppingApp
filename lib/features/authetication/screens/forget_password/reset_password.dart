import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/button/zelevated_button.dart';
import 'package:e_commerce/features/authetication/controller/forget_password/forget_password_controller.dart';
import 'package:e_commerce/features/authetication/screens/login_screen/login.dart';
import 'package:e_commerce/utils/constant/images.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:e_commerce/utils/helpers/device_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});


  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = ForgetPasswordController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          //means right side portion
          IconButton(
            onPressed: () => Get.offAll(() => LoginScreen()),
            //offAll means sari screen remove hojaen sirf login screen ajae
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Column(
            children: [
              ///Image
              Image.asset(
                ZImages.mailSentImage,
                height: ZDeviceHelpers.getScreenWidth(context) * 0.6,
              ),

              SizedBox(height: ZSizes.spaceBtwItems),

              ///Title
              Text(
                ZTexts.resetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              SizedBox(height: ZSizes.spaceBtwItems),

              ///Email
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              SizedBox(height: ZSizes.spaceBtwItems),

              ///SubTitle
              Text(
                ZTexts.resetPasswordSubTitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: ZSizes.spaceBtwSections),

              ///Done
              ZElevatedButton(onPressed: ()=>Get.offAll(() => LoginScreen()), child: Text(ZTexts.done)),

              ///Resend Email
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: controller.resendPasswordResetEmail,

                  child: Text(ZTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
