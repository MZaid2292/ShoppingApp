import 'package:e_commerce/utils/constant/colors.dart';
import 'package:e_commerce/utils/theme/widgets/appbar_theme.dart';
import 'package:e_commerce/utils/theme/widgets/bottom_sheet_theme.dart';
import 'package:e_commerce/utils/theme/widgets/checkbox_theme.dart';
import 'package:e_commerce/utils/theme/widgets/chip_theme.dart';
import 'package:e_commerce/utils/theme/widgets/elevated_button_theme.dart';
import 'package:e_commerce/utils/theme/widgets/outlined_button_theme.dart';
import 'package:e_commerce/utils/theme/widgets/text_field_theme.dart';
import 'package:e_commerce/utils/theme/widgets/text_theme.dart';
import 'package:flutter/material.dart';

class ZAppTheme {
  //Private Constructor or Singleton class
  ZAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Nunito",
    brightness: Brightness.light,
    primaryColor: ZColors.primaryColor,
    disabledColor: ZColors.grey,
    textTheme: ZTextTheme.lightTextTheme,
    chipTheme: ZChipTheme.lightChipTheme,
    scaffoldBackgroundColor: ZColors.white,
    appBarTheme: ZAppBarTheme.lightAppBarTheme,
    checkboxTheme: ZCheckBoxTheme.lightCheckboxTheme,
    bottomSheetTheme: ZBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: ZElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: ZOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: ZTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Nunito",
    brightness: Brightness.dark,
    primaryColor: ZColors.primaryColor,
    disabledColor: ZColors.grey,
    textTheme: ZTextTheme.darkTextTheme,
    chipTheme: ZChipTheme.darkChipTheme,
    scaffoldBackgroundColor: ZColors.black,
    appBarTheme: ZAppBarTheme.darkAppBarTheme,
    checkboxTheme: ZCheckBoxTheme.darkCheckboxTheme,
    bottomSheetTheme: ZBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: ZElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: ZOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: ZTextFormFieldTheme.darkInputDecorationTheme,
  );
}
