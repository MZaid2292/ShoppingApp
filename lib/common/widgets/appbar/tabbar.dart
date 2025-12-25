import 'package:flutter/material.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/helpers/device_helpers.dart';
import '../../../utils/helpers/helpers_function.dart';

class ZTabBar extends StatelessWidget implements PreferredSizeWidget {
  const ZTabBar({
    super.key, required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {

    final dark = ZHelperFunctions.isDarkMode(context);

    return Material(
      color: dark ? ZColors.black : ZColors.white,
      child: TabBar(
        isScrollable: true,
        labelColor: dark ? ZColors.white : ZColors.primaryColor,
        unselectedLabelColor: ZColors.darkGrey,
        indicatorColor: ZColors.primaryColor,
        tabs: tabs,
      ),
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(ZDeviceHelpers.getAppBarHeight());
}