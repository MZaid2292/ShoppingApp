import 'package:e_commerce/features/authetication/controller/login/login_controller.dart';
import 'package:e_commerce/features/authetication/screens/forget_password/forget_password.dart';
import 'package:e_commerce/features/authetication/screens/signup/signup.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/button/zelevated_button.dart';
import '../../../../../utils/constant/sized.dart';
import '../../../../../utils/constant/texts.dart';

class ZLoginForm extends StatelessWidget {
  const ZLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Email
          TextFormField(
            controller: controller.email,
            validator: (value) => ZValidator.validateEmail(value),
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: ZTexts.email,
            ),
          ),

          SizedBox(height: ZSizes.spaceBtwInputFields),

          ///Password
          Obx(
            ()=> TextFormField(
              controller: controller.password,
              obscureText: controller.isPasswordVisible.value,
              validator: (value) => ZValidator.validateEmptyText("Password" , value),
              decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: ZTexts.password,
                  suffixIcon: IconButton(onPressed: ()=>controller.isPasswordVisible.toggle(), //toggle means when false it shows true
                      icon: Icon(controller.isPasswordVisible.value ? Iconsax.eye_slash : Iconsax.eye)
                  )
              ),
            ),
          ),

          SizedBox(height: ZSizes.spaceBtwInputFields / 2),

          ///Remember Me & Forget Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///Remember Me
              Row(
                children: [
                  Obx(
                        ()=> Checkbox(value:controller.rememberMe.value,
                        onChanged:(value)=>controller.rememberMe.toggle()),
                  ),
                  Text(ZTexts.rememberMe),
                ],
              ),

              ///Forget Password
              TextButton(
                onPressed: ()=>Get.to(()=>ForgetPasswordScreen()),
                child: Text(ZTexts.forgetPassword),

              )
            ],
          ),

          SizedBox(height: ZSizes.spaceBtwSections),

          ///Sign In
          ZElevatedButton(onPressed: controller.loginWithEmailAndPassword,
            child: Text(ZTexts.signIn),
          ),

          SizedBox(height: ZSizes.spaceBtwItems / 2),

          ///Create Account
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(onPressed: ()=>Get.to(()=>SignupScreen()),
              child: Text(ZTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}