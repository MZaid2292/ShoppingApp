import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/products/cart/product_quantity_with_add_remove.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constant/sized.dart';

class ZCartItems extends StatelessWidget {
  const ZCartItems({
    super.key,
    this.showAddRemoveButton = true
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) =>
            SizedBox(height: ZSizes.spaceBtwSections),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = controller.cartItems[index];
          return Column(
            children: [
              ///Cart Item
              ZCartItem(cartItem: cartItem),
              if(showAddRemoveButton) SizedBox(height: ZSizes.spaceBtwItems),

              ///Price, Counter Button
              if(showAddRemoveButton) Row(
                children: [
                  SizedBox(width: 70.0),

                  ///Quantity Buttons
                  ZProductQuantityWithAddRemove(
                    quantity: cartItem.quantity,
                    add: () => controller.addOneToCart(cartItem),
                    remove: () => controller.removeOneFromCart(cartItem),
                  ),
                  Spacer(),

                  ///Product Price
                  ZProductPrice(price: (cartItem.price * cartItem.quantity).toStringAsFixed(0))
                ],
              ),
            ],
          );

        },
      ),
    );
  }
}