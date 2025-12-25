import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/images.dart';
import '../../../utils/constant/sized.dart';


class ZAnimationLoader extends StatelessWidget {
  final String text;
  final String animation;
  final bool showActionButton;
  final String? actionText;
  final VoidCallback? onActionPressed;



  const ZAnimationLoader({
    super.key,
    required this.text,
    this.animation = ZImages.loadingAnimation,
    this.showActionButton = false,
    this.actionText,
    this.onActionPressed
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Animation
          Lottie.asset(animation, width: Get.width * 0.8),
          const SizedBox(height: ZSizes.defaultSpace),

          /// Title
          Text(text, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: ZSizes.defaultSpace),

          showActionButton ?
          SizedBox(
              width : 250,
              child: OutlinedButton(
                onPressed: onActionPressed,
                style: OutlinedButton.styleFrom(backgroundColor: ZColors.dark),
                child: Text(
                  actionText!,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(color: ZColors.light),
                ),
              )
          ) : SizedBox()
        ],
      ),
    );
  }
}
