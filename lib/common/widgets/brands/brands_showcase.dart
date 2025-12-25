import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:e_commerce/features/shop/screen/brands/brand_products.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brands_model.dart';
import '../../../utils/constant/colors.dart';

import '../../../utils/constant/sized.dart';
import '../custom_shapes/rounded_container.dart';
import 'brand_card.dart';

class ZBrandShowcase extends StatelessWidget {
  const ZBrandShowcase({super.key, required this.images, required this.brand});

  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunctions.isDarkMode(context);

    return InkWell(
      onTap: () => Get.to(() => BrandProductsScreen(title: brand.name, brand: brand)),
      child: ZRoundedContainer(
        showBorder: true,
        borderColor: ZColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(ZSizes.md),
        margin: EdgeInsets.only(bottom: ZSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            ///Brand with product Count
            ZBrandCard(showBorder: false, brand: brand),
      
            Row(
                children: images
                    .map((image) => buildBrandImage(dark, image))
                    .toList()
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBrandImage(bool dark, String image) {
    return Expanded(
      child: ZRoundedContainer(
          height: 100,
          margin: EdgeInsets.only(right: ZSizes.sm),
          padding: EdgeInsets.all(ZSizes.md),
          backgroundColor: dark ? ZColors.darkGrey : ZColors.light,
          child: CachedNetworkImage(imageUrl: image,
            fit: BoxFit.contain,
            progressIndicatorBuilder: (context, url, progress) =>ZShimmerEffect(width: 100, height: 100),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
      ),
    );
  }
}
