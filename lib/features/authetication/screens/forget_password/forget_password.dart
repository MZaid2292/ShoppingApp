import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/button/zelevated_button.dart';
import 'package:e_commerce/features/authetication/controller/forget_password/forget_password_controller.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///----------[Header]--------------
              ///Title
              Text(ZTexts.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium),

              SizedBox(height: ZSizes.spaceBtwItems / 2),

              ///SubTitle
              Text(ZTexts.forgetPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium),


              SizedBox(height: ZSizes.spaceBtwSections * 2),

              ///Form
               Column(
                  children: [

                    Form(
                      key: controller.forgetPasswordFormKey,
                      child: TextFormField(
                        controller: controller.email,
                        validator:  (value) => ZValidator.validateEmail(value),
                        decoration: InputDecoration(
                          labelText: ZTexts.email,
                          prefixIcon: Icon(Iconsax.direct_right),
                        ),
                      ),
                    ),
                
                    SizedBox(height: ZSizes.spaceBtwItems),
                
                
                    ZElevatedButton(onPressed: controller.sendPasswordResetEmail,
                        child: Text(ZTexts.submit)
                    ),
                  ],
                ),

            ],
          ),
        ),
      ),
    );
  }
}
