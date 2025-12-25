



import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/sized.dart';

class ZBrandsShimmer extends StatelessWidget {
  const ZBrandsShimmer({super.key,this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(width: ZSizes.spaceBtwItems),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) => ZShimmerEffect(width: ZSizes.brandCardWidth, height: ZSizes.brandCardHeight),
    );
  }
}
