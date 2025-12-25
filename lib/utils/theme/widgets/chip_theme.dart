import 'package:e_commerce/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class ZChipTheme{

  ZChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: ZColors.grey.withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: ZColors.black),
    selectedColor: ZColors.primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: ZColors.white,

  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: ZColors.darkerGrey,
    labelStyle: const TextStyle(color: ZColors.white),
    selectedColor: ZColors.primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: ZColors.white,

  );
}