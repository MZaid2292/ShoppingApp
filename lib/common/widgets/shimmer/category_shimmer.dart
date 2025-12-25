

import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/sized.dart';

class ZCategoryShimmer extends StatelessWidget {
  const ZCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: ZSizes.spaceBtwItems),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              ZShimmerEffect(width: 55, height: 55, radius: 55),
              const SizedBox(height: ZSizes.spaceBtwItems / 2),

              /// Text
              ZShimmerEffect(width: 55, height: 8)
            ],
          );
        },
      ),
    );
  }
}
