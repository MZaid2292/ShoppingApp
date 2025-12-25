import 'package:e_commerce/features/authetication/controller/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/images.dart';
import '../../../utils/constant/sized.dart';

class ZSocialButtons extends StatelessWidget {
  const ZSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Google Button
        buildButton(ZImages.googleIcon, controller.googleSignIn),
        SizedBox(width: ZSizes.spaceBtwItems),
        //Facebook Button
        buildButton(ZImages.facebookIcon, (){}),




      ],
    );
  }

  Container buildButton(String image , VoidCallback onPressed) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: ZColors.grey),
            borderRadius: BorderRadius.circular(100)
        ),
        child: IconButton(onPressed: onPressed,
          icon: Image.asset(image,height: ZSizes.iconMd,width: ZSizes.iconMd),
        ),
      );
  }
}