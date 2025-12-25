import 'package:e_commerce/features/authetication/controller/signup/signup_controller.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/texts.dart';

class ZPrivacyPolicyCheckbox extends StatelessWidget {
  const ZPrivacyPolicyCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = ZHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.privacyPolicy.value,
            onChanged: (value) => controller.privacyPolicy.value =
                !controller.privacyPolicy.value,
          ),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(text: ZTexts.iAgreeTo),
              TextSpan(
                text: ZTexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: dark ? ZColors.white : ZColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? ZColors.white : ZColors.primaryColor,
                ),
              ),
              TextSpan(text: " ${ZTexts.and}"),
              TextSpan(
                text: ZTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: dark ? ZColors.white : ZColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? ZColors.white : ZColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
