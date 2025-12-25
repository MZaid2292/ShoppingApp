import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/screen/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constant/colors.dart';
import '../../../../utils/helpers/helpers_function.dart';

class ZCartCounterIcon extends StatelessWidget {
  const ZCartCounterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = ZHelperFunctions.isDarkMode(context);
    final controller = Get.put(CartController());

    return Stack(
      children: [
        //Cart Icon
        IconButton(
          onPressed: () => Get.to(() => CartScreen()),
          icon: Icon(Iconsax.shopping_bag),
          color: ZColors.light,
        ),

        //Counter Text
        Positioned(
          right: 6.0,
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: dark ? ZColors.dark : ZColors.light,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.noOfCartItem.value.toString(),
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                    fontSizeFactor: 0.8,
                    color: dark ? ZColors.light : ZColors.dark,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
