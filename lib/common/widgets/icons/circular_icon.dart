import 'package:flutter/material.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/sized.dart';
import '../../../utils/helpers/helpers_function.dart';



class ZCircularIcon extends StatelessWidget {
  const ZCircularIcon({
    super.key,
    required this.icon,
    this.size = ZSizes.iconMd,
    this.backgroundColor,
    this.onPressed,
    this.height,
    this.width,
    this.color,
  });

  final double? width, height, size;
  final IconData? icon;
  final Color? color, backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: (backgroundColor != null)
              ? backgroundColor
              : dark
              ? ZColors.dark.withValues(alpha: 0.9)
              : ZColors.light.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(1000)),
      child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color, size: size)),
    );
  }
}
