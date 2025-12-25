import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/button/zelevated_button.dart';
import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/screen/cart/widgets/cart_items.dart';
import 'package:e_commerce/features/shop/screen/checkout/checkout.dart';
import 'package:e_commerce/utils/constant/images.dart';
import 'package:e_commerce/utils/constant/sized.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      ///-------------[AppBar]--------------
      appBar: ZAppBar(
        showBackArrow: true,
        title: Text("Cart", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          ZCircularIcon(icon: Iconsax.box_remove,onPressed: () => controller.clearCart(),)
        ],
      ),

      ///---------[Body]-------------
      body: Obx(
        () {

          final emptyWidget = ZAnimationLoader(
              text: "Cart is Empty",
            animation: ZImages.cartEmptyAnimation,
            showActionButton: true,
            actionText: "Let's fill it",
            onActionPressed: Get.back,
          );
          if(controller.cartItems.isEmpty){
            return emptyWidget;
          }
          return SingleChildScrollView(
            child: Padding(
              padding: ZPadding.screenPadding,
              child: ZCartItems(),
            ),
          );
        }
      ),


      ///------------[Bottom Navigation] - Checkout Button------------
      bottomNavigationBar: Obx(
          () {

            if(controller.cartItems.isEmpty) return SizedBox();
            return Padding(
              padding: const EdgeInsets.all(ZSizes.defaultSpace),
              child: ZElevatedButton(onPressed: ()=>Get.to(()=>CheckoutScreen()), child:Text("Checkout \$${controller.totalCartPrice.value.toStringAsFixed(2)}") ),
            );
          }
      ),
    );
  }
}




