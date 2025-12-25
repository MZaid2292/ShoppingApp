import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/sized.dart';

class ZOutlinedButtonTheme{

  ZOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: ZColors.dark,
      side: const BorderSide(color: ZColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: ZColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: ZSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZSizes.buttonRadius)),
    ),
  );


  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ZColors.light,
      side: const BorderSide(color: ZColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: ZColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: ZSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZSizes.buttonRadius)),
    ),
  );
}