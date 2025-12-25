
import 'package:e_commerce/utils/helpers/device_helpers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.animation, required this.title, required this.subtitle,
  });


  final String animation;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ZDeviceHelpers.getAppBarHeight()),
      child: Column(
        children: [
          ///Animation
          Lottie.asset(animation),

          ///Title
          Text(title,style:Theme.of(context).textTheme.headlineMedium),

          ///Subtitle
          Text(subtitle,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}