import 'package:e_commerce/features/authetication/controller/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/helpers/device_helpers.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });




  @override
  Widget build(BuildContext context) {

    final controller = OnBoardingController.instance;

    return Obx(
        ()=> controller.currentIndex.value==2?SizedBox(): Positioned(
        top: ZDeviceHelpers.getAppBarHeight(),right: 0,
        child: TextButton(onPressed: controller.skipPage,
            child: Text("Skip")
        ),
      ),
    );
  }
}