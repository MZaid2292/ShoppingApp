import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/button/zelevated_button.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthenticateUserFormScreen extends StatelessWidget {
  const ReAuthenticateUserFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: ZAppBar(showBackArrow: true, title: Text("Re-Authenticate User")),

      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              children: [
                ///Email
                TextFormField(
                  controller: controller.email,
                  validator: ZValidator.validateEmail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: ZTexts.email,
                  ),
                ),
                SizedBox(height: ZSizes.spaceBtwInputFields),

                ///Password
                Obx(
                  () => TextFormField(
                    controller: controller.password,
                    obscureText: controller.isPasswordVisible.value,
                    validator: (value) =>
                        ZValidator.validateEmptyText("Password", value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: ZTexts.password,
                      suffixIcon: IconButton(
                        onPressed: () => controller.isPasswordVisible.toggle(),
                        icon: Icon(controller.isPasswordVisible.value ? Iconsax.eye : Iconsax.eye_slash),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ZSizes.spaceBtwSections),

                /// Verify Button
                ZElevatedButton(onPressed: controller.reAuthenticateUser, child: Text("Verify")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
