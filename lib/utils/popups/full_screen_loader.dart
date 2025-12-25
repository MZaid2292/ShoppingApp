import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/animation_loader.dart';
import '../constant/colors.dart';
import '../helpers/helpers_function.dart';


class ZFullScreenLoader {
  static void openLoadingDialog(String text) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: ZHelperFunctions.isDarkMode(Get.context!) ? ZColors.dark : ZColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  /// Extra Space
                  const SizedBox(height: 250),

                  /// Animation
                  ZAnimationLoader(text: text)
                ],
              ),
            )));
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
