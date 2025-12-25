import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/sized.dart';


class ZListTileShimmer extends StatelessWidget {
  const ZListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            /// Brand Logo
            ZShimmerEffect(width: 50, height: 50, radius: 50,),
            SizedBox(width: ZSizes.spaceBtwItems,),
            Column(
              children: [
                /// Brand Name
                ZShimmerEffect(width: 100, height: 15),
                SizedBox(height: ZSizes.spaceBtwItems / 2,),
                /// Brand products
                ZShimmerEffect(width: 80, height: 12)
              ],
            )
          ],
        )
      ],
    );
  }
}
