



import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:flutter/material.dart';
import '../../../utils/constant/sized.dart';

import '../layouts/grid_layout.dart';

class ZVerticalProductShimmer extends StatelessWidget {
  const ZVerticalProductShimmer({
    super.key,
    this.itemCount = 16
  });

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return ZGridLayout(
      itemCount: itemCount,
      itemBuilder: (context, index) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ZShimmerEffect(width: 180, height: 180),
            SizedBox(height: ZSizes.spaceBtwItems,),

            /// Text
            ZShimmerEffect(width: 160, height: 15),
            SizedBox(height: ZSizes.spaceBtwItems / 2,),
            ZShimmerEffect(width: 110, height: 15)
          ],
        ),
      ),
    );
  }
}
