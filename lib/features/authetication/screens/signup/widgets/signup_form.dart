import 'package:e_commerce/features/authetication/controller/signup/signup_controller.dart';
import 'package:e_commerce/features/authetication/screens/signup/widgets/privacy_policy_checkbox.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/button/zelevated_button.dart';
import '../../../../../utils/constant/sized.dart';
import '../../../../../utils/constant/texts.dart';

class ZSignupForm extends StatelessWidget {
  const ZSignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;

    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          ///First Name & Last Name
          Row(
            children: [
              //First Name
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      ZValidator.validateEmptyText("First Name", value),
                  decoration: InputDecoration(
                    labelText: ZTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              SizedBox(width: ZSizes.spaceBtwInputFields),

              //Last Name
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      ZValidator.validateEmptyText("Last Name", value),
                  decoration: InputDecoration(
                    labelText: ZTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: ZSizes.spaceBtwInputFields),

          //Email
          TextFormField(
            controller: controller.email,
            validator: (value) => ZValidator.validateEmail(value),
            decoration: InputDecoration(
              labelText: ZTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),

          SizedBox(height: ZSizes.spaceBtwInputFields),

          //Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => ZValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
              labelText: ZTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),

          SizedBox(height: ZSizes.spaceBtwInputFields),

          //Password
          Obx(
              () => TextFormField(
                obscureText: controller.isPasswordVisible.value,
              controller: controller.password,
              validator: (value) => ZValidator.validatePassword(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: ZTexts.password,
                suffixIcon: IconButton(
                  onPressed: ()=>controller..isPasswordVisible.value = !controller.isPasswordVisible.value,
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: ZSizes.spaceBtwInputFields / 2),

          //Privacy Policy Checkbox
          ZPrivacyPolicyCheckbox(),

          SizedBox(height: ZSizes.spaceBtwItems),

          //Create Account
          ZElevatedButton(
            onPressed: controller.registerUser,
            child: Text(ZTexts.createAccount),
          ),
        ],
      ),
    );
  }
}
