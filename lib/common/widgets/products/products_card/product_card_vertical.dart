import 'package:e_commerce/common/widgets/button/add_to_cart_button.dart';
import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';

import 'package:e_commerce/common/widgets/products/favourite/favourite_icon.dart';
import 'package:e_commerce/features/shop/controllers/products/product_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/screen/home_screen/product_details/product_details.dart';
import 'package:e_commerce/utils/constant/colors.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constant/sized.dart';
import '../../../styles/shadow.dart';

import '../../images/rounded_image.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';

class ZProductCardVertical extends StatelessWidget {
  const ZProductCardVertical({super.key, required this.product});

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
        width: 180,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: ZShadow.verticalProductShadow,
          borderRadius: BorderRadius.circular(ZSizes.productImageRadius),
          color: dark ? ZColors.darkGrey : ZColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Thumbnail Favourite Button and Discount Tag
            ZRoundedContainer(
              height: 180,
              padding: EdgeInsets.all(ZSizes.sm),
              backgroundColor: dark ? ZColors.dark : ZColors.light,
              child: Stack(
                children: [
                  ///Thumbnail or Image
                  Center(
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

            SizedBox(height: ZSizes.spaceBtwItems / 2),

            ///Products Details
            Padding(
              padding: const EdgeInsets.only(left: ZSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  ZProductTitleText(title: product.title, smallSize: true),

                  SizedBox(height: ZSizes.spaceBtwItems / 2),

                  //Product Brand
                  ZBrandTitleWithVerifyIcon(title: product.brand!.name),
                ],
              ),
            ),

            Spacer(),

            ///Product price & Add Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Product Price
                Padding(
                  padding: const EdgeInsets.only(left: ZSizes.sm),
                  child: ZProductPrice(
                    price: controller.getProductPrice(product),
                  ),
                ),

                //Add Button
                ProductAddToCartButton(product: product),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
