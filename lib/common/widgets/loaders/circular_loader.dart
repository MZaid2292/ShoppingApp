import 'package:e_commerce/utils/constant/colors.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:flutter/material.dart';

class ZCircularLoader extends StatelessWidget {
  const ZCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ZSizes.lg),
      decoration: BoxDecoration(
        color: ZColors.primaryColor,
        shape: BoxShape.circle
      ),
      child: CircularProgressIndicator(color: ZColors.white),
    );
  }
}
