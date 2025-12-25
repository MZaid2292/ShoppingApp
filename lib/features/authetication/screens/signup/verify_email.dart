import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/button/zelevated_button.dart';
import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/features/authetication/controller/signup/verify_email_controller.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:e_commerce/utils/helpers/device_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constant/images.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: AuthenticationRepository.instance.logout,
              icon: const Icon(CupertinoIcons.clear),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: ZPadding.screenPadding,
            child: Column(
              children: [
                /// Image
                Image.asset(
                  ZImages.mailSentImage,
                  height: ZDeviceHelpers.getScreenWidth(context) * 0.6,
                ),

                const SizedBox(height: ZSizes.spaceBtwItems),

                /// Title
                Text(
                  ZTexts.verifyEmailTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: ZSizes.spaceBtwItems),

                /// Email
                Text(
                  email ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: ZSizes.spaceBtwItems),

                /// SubTitle
                Text(
                  ZTexts.verifyEmailSubTitle,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: ZSizes.spaceBtwSections),

                /// Continue Button
                ZElevatedButton(
                  onPressed: controller.checkEmailVerificationStatus,
                  child: const Text(ZTexts.zContinue),
                ),

                const SizedBox(height: ZSizes.spaceBtwItems),

                /// Resend Email Button
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: controller.sendEmailVerification,
                    child: const Text(ZTexts.resendEmail),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}