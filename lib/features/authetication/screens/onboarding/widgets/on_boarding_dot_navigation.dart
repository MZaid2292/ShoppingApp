import 'package:e_commerce/features/authetication/controller/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/helpers/device_helpers.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final controller = OnBoardingController.instance;

    return Positioned(
        bottom: ZDeviceHelpers.getBottomNavigationBarHeight() * 4,
        left: ZDeviceHelpers.getScreenWidth(context) / 3,
        right: ZDeviceHelpers.getScreenWidth(context) / 3,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(dotHeight: 6.0),

        ));
  }
}