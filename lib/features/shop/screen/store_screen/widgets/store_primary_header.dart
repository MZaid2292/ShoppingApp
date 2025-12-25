import 'package:flutter/material.dart';

import '../../../../../common/widgets/TextFields/search_bar.dart';
import '../../../../../common/widgets/appbar/custom_appbar.dart';
import '../../../../../common/widgets/products/cart/cart_counter.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sized.dart';
import '../../../../../common/widgets/custom_shapes/primary_header_container.dart';

class ZStorePrimaryHeader extends StatelessWidget {
  const ZStorePrimaryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///Total height  +  20
        SizedBox(height: ZSizes.storePrimaryHeaderHeight + 10),

        ///Primary Header Container
        ZPrimaryHeaderContainer(
          height: ZSizes.storePrimaryHeaderHeight,

          child: ZAppBar(
            title: Text(
              "Store",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.apply(color: ZColors.white),
            ),
            actions: [ZCartCounterIcon()],
          ),
        ),

        ///Search Bar
        ZSearchBar(),
      ],
    );
  }
}