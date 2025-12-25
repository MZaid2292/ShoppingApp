import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/sized.dart';

class ZCheckBoxTheme{

  ZCheckBoxTheme._();

  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZSizes.xs)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ZColors.white;
      } else {
        return ZColors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ZColors.primaryColor;
      } else {
        return Colors.transparent;
      }
    }),
  );


  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZSizes.xs)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ZColors.white;
      } else {
        return ZColors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ZColors.primaryColor;
      } else {
        return Colors.transparent;
      }
    }),
  );
}