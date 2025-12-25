import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:e_commerce/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constant/sized.dart';

class ZBillingAmountSection extends StatelessWidget {
  const ZBillingAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [

        ///Subtotal
        Row(
          children: [
            Expanded(child: Text("Subtotal",style: Theme.of(context).textTheme.bodyMedium)),
            Text("${ZTexts.currency}$subTotal",style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: ZSizes.spaceBtwItems / 2),

        ///Shipping fee
        Row(
          children: [
            Expanded(child: Text("Shipping fee",style: Theme.of(context).textTheme.bodyMedium)),
            Text("${ZTexts.currency}${ZPricingCalculator.calculateShippingCost(subTotal, "Pakistan")}",style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(height: ZSizes.spaceBtwItems / 2),

        ///Tax Fee
        Row(
          children: [
            Expanded(child: Text("Tax fee",style: Theme.of(context).textTheme.bodyMedium)),
            Text("${ZTexts.currency}${ZPricingCalculator.calculateTax(subTotal, "Pakistan")}",style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(height: ZSizes.spaceBtwItems / 2),

        ///Order Total
        Row(
          children: [
            Expanded(child: Text("Order Total",style: Theme.of(context).textTheme.bodyMedium)),
            Text("${ZTexts.currency}${ZPricingCalculator.calculateTotalPrice(subTotal, "Pakistan")}",style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}