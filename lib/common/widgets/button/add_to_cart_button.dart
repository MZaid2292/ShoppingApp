import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/screen/home_screen/product_details/product_details.dart';
import 'package:e_commerce/utils/constant/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/sized.dart';

class ProductAddToCartButton extends StatelessWidget {
  const ProductAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return InkWell(
      onTap: () {
        if (product.productType == ProductType.single.toString()) {
          CartItemModel cartItem = controller.convertToCartItem(product, 1);
          controller.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailsScreen(product: product));
        }
      },
      child: Obx(() {
        int productQuantityInCart = controller.getProductQuantityInCart(
          product.id,
        );
        return Container(
          width: ZSizes.iconLg * 1.2,
          height: ZSizes.iconLg * 1.2,
          decoration: BoxDecoration(
            color: productQuantityInCart > 0 ? ZColors.dark : ZColors.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ZSizes.cardRadiusMd),
              bottomRight: Radius.circular(ZSizes.productImageRadius),
            ),
          ),
          child: Center(
            child: productQuantityInCart > 0
                ? Text(
                    productQuantityInCart.toString(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.apply(color: ZColors.white),
                  )
                : Icon(Iconsax.add, color: ZColors.white),
          ),
        );
      }),
    );
  }
}
