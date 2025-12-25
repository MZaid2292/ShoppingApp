import 'package:flutter/material.dart';

import '../../../utils/constant/colors.dart';

class ZCircularContainer extends StatelessWidget {
  const ZCircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.backgroundColor = ZColors.white,
    this.padding,
    this.margin,
    this.child
  });

  final double width, height;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding, margin;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
