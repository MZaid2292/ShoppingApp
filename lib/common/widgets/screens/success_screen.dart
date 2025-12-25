import 'package:e_commerce/common/styles/padding.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/sized.dart';
import '../../../utils/constant/texts.dart';
import '../../../utils/helpers/device_helpers.dart';
import '../button/zelevated_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.title, required this.subTitle, required this.image, required this.onTap});

  final String title , subTitle , image;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Column(
            children: [
              ///Image
              Image.asset(
                image,
                height: ZDeviceHelpers.getScreenWidth(context) * 0.6,
              ),

              SizedBox(height: ZSizes.spaceBtwItems),

              ///Title
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: ZSizes.spaceBtwItems),


              ///SubTitle
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: ZSizes.spaceBtwSections),

              ///Continue
              ZElevatedButton(
                onPressed: onTap,
                child: Text(ZTexts.zContinue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
