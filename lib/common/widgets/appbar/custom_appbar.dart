import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/sized.dart';
import '../../../utils/helpers/device_helpers.dart';
import '../../../utils/helpers/helpers_function.dart';

class ZAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ZAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {

    bool dark = ZHelperFunctions.isDarkMode(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ZSizes.md),
      child: AppBar(
        //I do this here because if I want to wrap this with padding then I can
        automaticallyImplyLeading: false,

        ///Leading
        leading: showBackArrow
            ? IconButton(
          onPressed:  Get.back,
          icon: Icon(Iconsax.arrow_left,color: dark? ZColors.white:ZColors.dark,),
        )
            : leadingIcon != null
            ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
            : null,

        ///Title
        title: title,

        ///Actions
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ZDeviceHelpers.getAppBarHeight());
}