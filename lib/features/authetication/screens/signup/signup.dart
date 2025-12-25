import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/button/social_buttons.dart';
import 'package:e_commerce/common/widgets/login_signup/form_divider.dart';
import 'package:e_commerce/features/authetication/controller/signup/signup_controller.dart';
import 'package:e_commerce/features/authetication/screens/signup/widgets/signup_form.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: ZPadding.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  ZTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: ZSizes.spaceBtwSections),

                /// Form
                const ZSignupForm(),

                const SizedBox(height: ZSizes.spaceBtwSections),

                /// Divider
                ZFormDivider(title: ZTexts.orSignupWith),

                const SizedBox(height: ZSizes.spaceBtwSections),

                /// Social Buttons
                const ZSocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}