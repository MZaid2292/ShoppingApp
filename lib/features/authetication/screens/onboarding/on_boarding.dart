import 'package:e_commerce/features/authetication/controller/onboarding/onboarding_controller.dart';
import 'package:e_commerce/features/authetication/screens/onboarding/widgets/on_boarding_dot_navigation.dart';
import 'package:e_commerce/features/authetication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:e_commerce/features/authetication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:e_commerce/features/authetication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:e_commerce/utils/constant/images.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/constant/texts.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ZSizes.defaultSpace),
        child: Stack(
          children: [
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              //Also write like this
              // onPageChanged: (value) => controller.updatePageIndicator(value),
              children: [
                OnBoardingPage(animation:ZImages.onBoarding1Animation,title: ZTexts.onBoarding1Title,subtitle:ZTexts.onBoarding1SubTitle),
                OnBoardingPage(animation:ZImages.onBoarding2Animation,title: ZTexts.onBoarding2Title,subtitle:ZTexts.onBoarding2SubTitle),
                OnBoardingPage(animation:ZImages.onBoarding3Animation,title: ZTexts.onBoarding3Title,subtitle:ZTexts.onBoarding3SubTitle),
              ],
            ),

            ///Indicator
            OnBoardingDotNavigation(),

            ///Bottom Button
            OnBoardingNextButton(),

            ///Skip Button
            OnBoardingSkipButton()
          ],
        ),
      ),
    );
  }
}










