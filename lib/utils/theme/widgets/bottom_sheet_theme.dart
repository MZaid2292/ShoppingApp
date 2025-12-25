import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class ZBottomSheetTheme{

  ZBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true, //Used to show a small drag bar on a BottomSheet for dragging.
    backgroundColor: ZColors.white,
    modalBackgroundColor: ZColors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: ZColors.black,
    modalBackgroundColor: ZColors.black,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}