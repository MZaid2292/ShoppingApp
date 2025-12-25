import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sized.dart';
import '../../../../utils/helpers/helpers_function.dart';
import '../../images/rounded_image.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_title_text.dart';

class ZCartItem extends StatelessWidget {
  const ZCartItem({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        ///Product Image
        ZRoundedImage(
          imageUrl: cartItem.image ?? "",
          isNetworkImage: true,
          height: 60.0,
          width: 60.0,
          padding: EdgeInsets.all(ZSizes.sm),
          backgroundColor: dark ? ZColors.darkerGrey : ZColors.light,
        ),
        SizedBox(width: ZSizes.spaceBtwItems),

        ///Brand, Name, Variation
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Brand
              ZBrandTitleWithVerifyIcon(title: cartItem.brandName ?? ""),

              ///Product Title
              ZProductTitleText(title: cartItem.title, maxLines: 1),

              ///Variation OR Attributes
              RichText(
                text: TextSpan(
                  children: (cartItem.selectedVariation ?? {}).entries
                      .map(
                        (e) => TextSpan(
                          children: [
                            TextSpan(
                              text: "${e.key} ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: "${e.value} ",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
