import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/features/authetication/screens/login_screen/widgets/login_form.dart';
import 'package:e_commerce/features/authetication/screens/login_screen/widgets/login_header.dart';

import 'package:e_commerce/utils/constant/sized.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/button/social_buttons.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../utils/constant/texts.dart';
import '../../controller/login/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());


    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ///-----------Header----------------
            ///Title and Subtitle
            ZLoginHeader(),
        
            SizedBox(height: ZSizes.spaceBtwSections),
        
        
            ///------------Form-----------------
              ZLoginForm(),
        
              SizedBox(height: ZSizes.spaceBtwSections),
        
            ///-------------Divider-------------
            ZFormDivider(title: ZTexts.orSignInWith,),
        
        
            SizedBox(height: ZSizes.spaceBtwSections),
        
            ///------------Footer----------------
              ///Social Buttons
              ZSocialButtons(),
          ],
          ),
        ),
      ),
    );
  }
}








