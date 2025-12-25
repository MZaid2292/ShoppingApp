import 'package:e_commerce/utils/constant/colors.dart';
import 'package:flutter/cupertino.dart';


class ZShadow{

  ZShadow._();

  static List<BoxShadow> searchBarShadow = [
    BoxShadow(
      color: ZColors.black.withValues(alpha: 0.1),
      spreadRadius: 4.0,
      blurRadius: 4.0,
    )];

  static List<BoxShadow> verticalProductShadow = [
    BoxShadow(
      color: ZColors.darkGrey.withValues(alpha: 0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: Offset(0, 2)
  )
  ];
}