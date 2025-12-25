import 'package:e_commerce/features/shop/models/brands_model.dart';
import 'package:flutter/material.dart';
import '../../../utils/constant/enums.dart';
import '../../../utils/constant/sized.dart';
import '../custom_shapes/rounded_container.dart';
import '../images/rounded_image.dart';
import '../texts/brand_title_with_verify_icon.dart';

class ZBrandCard extends StatelessWidget {
  const ZBrandCard({super.key, this.showBorder = true, this.onTap, required this.brand});

  final bool showBorder;
  final VoidCallback? onTap;


  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ZRoundedContainer(
        height: ZSizes.brandCardHeight,
        showBorder: showBorder,
        padding: EdgeInsets.all(ZSizes.sm),
        backgroundColor: Colors.transparent,

        child: Row(
          children: [
            ///Brand Image
            Flexible(
              child: ZRoundedImage(
                imageUrl: brand.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
              ),
            ),

            SizedBox(width: ZSizes.spaceBtwItems / 2),

            ///Right Portion
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///Brand Name & Verify Icon
                  ZBrandTitleWithVerifyIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),

                  ///Text
                  Text(
                    "${brand.productsCount} Products",
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
