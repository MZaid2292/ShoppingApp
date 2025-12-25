
import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/sized.dart';

class ZHorizontalProductShimmer extends StatelessWidget {
  const ZHorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ZSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: ZSizes.spaceBtwItems),
        itemCount: itemCount,
        itemBuilder: (context, index) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// Image
            ZShimmerEffect(width: 120, height: 120),
            SizedBox(width: ZSizes.spaceBtwItems),


            /// Text
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ZSizes.spaceBtwItems),

                    /// Title
                    ZShimmerEffect(width: 160, height: 15),
                    SizedBox(height: ZSizes.spaceBtwItems / 2),
                    /// Brand
                    ZShimmerEffect(width: 110, height: 15)
                  ],

                ),

                Row(
                  children: [
                    ZShimmerEffect(width: 40, height: 20),
                    SizedBox(width: ZSizes.spaceBtwSections),
                    ZShimmerEffect(width: 40, height: 20)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
