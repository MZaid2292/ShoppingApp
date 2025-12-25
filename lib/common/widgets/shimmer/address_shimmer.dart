import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/sized.dart';


class ZAddressesShimmer extends StatelessWidget {
  const ZAddressesShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(height: ZSizes.spaceBtwItems),
        itemCount: 4,
        itemBuilder: (context, index) => ZShimmerEffect(width: double.infinity, height: 150)
    );
  }
}