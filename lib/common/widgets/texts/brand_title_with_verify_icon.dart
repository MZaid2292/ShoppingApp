import 'package:e_commerce/utils/constant/enums.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/sized.dart';
import 'brand_title_text.dart';

class ZBrandTitleWithVerifyIcon extends StatelessWidget {
  const ZBrandTitleWithVerifyIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = ZColors.primaryColor,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ZBrandTitleText(
            title: title,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
            color: textColor,
          ),
        ),

        SizedBox(width: ZSizes.xs),
        Icon(Iconsax.verify5, color: ZColors.primaryColor, size: ZSizes.iconXs),
      ],
    );
  }
}
