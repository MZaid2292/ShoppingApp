import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/constant/colors.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ZBottomAddToCart extends StatelessWidget {
  const ZBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    bool dark = ZHelperFunctions.isDarkMode(context);
    final controller = CartController.instance;

    controller.updateAlreadyAddedProductCount(product);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: ZSizes.defaultSpace,vertical: ZSizes.defaultSpace/2),
      decoration: BoxDecoration(
          color:dark ? ZColors.darkerGrey : ZColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ZSizes.cardRadiusLg),
          topRight: Radius.circular(ZSizes.cardRadiusLg)
        ),
      ),
      child: Obx(
        () => Row(
          children: [
        
            ///Decrement Button
            ZCircularIcon(
              icon: Iconsax.minus,
              backgroundColor: ZColors.darkGrey,
              width: 40,
              height: 40,
              color: ZColors.white,
              onPressed: controller.productQuantityInCart.value < 1 ? null : () => controller.productQuantityInCart.value -= 1,
            ),
            SizedBox(width: ZSizes.spaceBtwItems),
        
            ///Counter
            Text(controller.productQuantityInCart.value.toString() , style: Theme.of(context).textTheme.titleSmall),
            SizedBox(width: ZSizes.spaceBtwItems),
        
            ///Increment Button
            ZCircularIcon(
              icon: Iconsax.add,
              backgroundColor: ZColors.black,
              width: 40,
              height: 40,
              color: ZColors.white,
              onPressed: () => controller.productQuantityInCart.value += 1,
            ),
            Spacer(),
            
            
            ///Add to Cart Button
            ElevatedButton(onPressed:controller.productQuantityInCart.value < 1 ? null : () => controller.addToCart(product),style: ElevatedButton.styleFrom(
             padding: EdgeInsets.all(ZSizes.md),
              backgroundColor: ZColors.black,
              side: BorderSide(color: ZColors.black)
            ), child: Row(
              children: [
                Icon(Iconsax.shopping_bag),
                SizedBox(width: ZSizes.spaceBtwItems / 2),
                Text("Add To Cart"),
              ],
            ))
        
          ],
        ),
      ),
    );
  }
}
