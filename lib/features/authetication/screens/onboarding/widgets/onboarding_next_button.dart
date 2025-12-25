import 'package:e_commerce/features/authetication/controller/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/button/zelevated_button.dart';
import '../../../../../utils/constant/sized.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final controller = OnBoardingController.instance;

    return Positioned(
      left: 0,
      right: 0,
      bottom: ZSizes.spaceBtwItems,
      child: ZElevatedButton(
        onPressed: controller.nextPage,
        child:Obx(()=> Text(controller.currentIndex.value == 2? "Get Started" :"Next"))
      ),
    );
  }
}