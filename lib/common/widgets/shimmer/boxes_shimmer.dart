
import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/sized.dart';


class ZBoxesShimmer extends StatelessWidget {
  const ZBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            /// Three Products
            Expanded(child: ZShimmerEffect(width: 150, height: 110)),
            SizedBox(width: ZSizes.spaceBtwItems,),
            Expanded(child: ZShimmerEffect(width: 150, height: 110)),
            SizedBox(width: ZSizes.spaceBtwItems,),
            Expanded(child: ZShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}
