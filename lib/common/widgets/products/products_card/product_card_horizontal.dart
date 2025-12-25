import 'package:e_commerce/common/widgets/button/add_to_cart_button.dart';
import 'package:e_commerce/common/widgets/products/favourite/favourite_icon.dart';
import 'package:e_commerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:e_commerce/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/products/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screen/home_screen/product_details/product_details.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sized.dart';
import '../../custom_shapes/rounded_container.dart';
import '../../images/rounded_image.dart';

class ZProductCardHorizontal extends StatelessWidget {
  const ZProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    String? salePercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
        width: 310,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ZSizes.productImageRadius),
          color: dark ? ZColors.darkerGrey : ZColors.white,
        ),

        child: Row(
          children: [
            ///Left Portion
            ZRoundedContainer(
              height: 120,
              padding: EdgeInsets.all(ZSizes.sm),
              backgroundColor: dark ? ZColors.dark : ZColors.light,
              child: Stack(
                children: [
                  ///Thumbnail
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ZRoundedImage(
                      imageUrl: product.thumbnail,
                      isNetworkImage: true,
                    ),
                  ),

                  ///Discount Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12.0,
                      child: ZRoundedContainer(
                        radius: ZSizes.sm,
                        backgroundColor: ZColors.yellow.withValues(alpha: 0.8),
                        padding: EdgeInsets.symmetric(
                          horizontal: ZSizes.sm,
                          vertical: ZSizes.xs,
                        ),
                        child: Text(
                          "$salePercentage%",
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.apply(color: ZColors.black),
                        ),
                      ),
                    ),

                  ///Favourite Button
                  Positioned(
                    right: 0,
                    top: 0,
                    child: ZFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),

            ///Right Portion
            SizedBox(
              width: 172,

              child: Padding(
                padding: const EdgeInsets.only(left: ZSizes.sm, top: ZSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Upper Part
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Product Title
                        ZProductTitleText(
                          title: product.title,
                          smallSize: true,
                        ),
                        SizedBox(height: ZSizes.spaceBtwItems / 2),

                        ///Product Brand
                        ZBrandTitleWithVerifyIcon(title: product.brand!.name),
                      ],
                    ),
                    Spacer(),

                    ///Lower Part
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Product Price
                        Flexible(
                          child: ZProductPrice(
                            price: controller.getProductPrice(product),
                          ),
                        ),

                        ///Add Button
                        ProductAddToCartButton(product: product),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
