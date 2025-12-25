import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/sized.dart';

class ZElevatedButtonTheme{

  ZElevatedButtonTheme._();

  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: ZColors.light,
      backgroundColor: ZColors.primaryColor,
      disabledForegroundColor: ZColors.darkGrey,
      disabledBackgroundColor: ZColors.buttonDisabled,
      side: const BorderSide(color: ZColors.light),
      padding: const EdgeInsets.symmetric(vertical: ZSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: ZColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZSizes.buttonRadius)),
    ),
  );


  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
//Foreground color means the **color of the text or content** that appears on top of the background.
      foregroundColor: ZColors.light,
      backgroundColor: ZColors.primaryColor,
      disabledForegroundColor: ZColors.darkGrey,
      disabledBackgroundColor: ZColors.darkerGrey,
      side: const BorderSide(color: ZColors.primaryColor),
      padding: const EdgeInsets.symmetric(vertical: ZSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: ZColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZSizes.buttonRadius)),
    ),
  );
}