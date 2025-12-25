import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/controllers/orders/order_controller.dart';
import 'package:e_commerce/features/shop/screen/cart/widgets/cart_items.dart';
import 'package:e_commerce/features/shop/screen/checkout/widgets/billing_address.dart';
import 'package:e_commerce/features/shop/screen/checkout/widgets/billing_amount_section.dart';
import 'package:e_commerce/features/shop/screen/checkout/widgets/billing_payment_section.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:e_commerce/utils/helpers/pricing_calculator.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/TextFields/promo_code_textfield.dart';
import '../../../../common/widgets/button/zelevated_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    double subTotal = cartController.totalCartPrice.value;
    double totalPrice = ZPricingCalculator.calculateTotalPrice(
      subTotal,
      "Pakistan",
    );
    final orderController = Get.put(OrderController());

    return Scaffold(
      ///------------[AppBar]----------------
      appBar: ZAppBar(
        showBackArrow: true,
        title: Text(
          "Order Review",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      ///-------------[Body]---------------
      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Column(
            children: [
              ///List of Items
              ZCartItems(showAddRemoveButton: false),
              SizedBox(height: ZSizes.spaceBtwSections),

              ///Promo Code - TextField
              ZPromoCodeField(),
              SizedBox(height: ZSizes.spaceBtwSections),

              ///Billing Section
              ZRoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(ZSizes.md),
                backgroundColor: Colors.transparent,
                child: Column(
                  children: [
                    ///Amount
                    ZBillingAmountSection(),
                    SizedBox(height: ZSizes.spaceBtwItems),

                    ///Payment
                    ZBillingPaymentSection(),
                    SizedBox(height: ZSizes.spaceBtwItems),

                    ///Address
                    ZBillingAddress(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      ///------------[Bottom Navigation] - Checkout Button------------
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ZSizes.defaultSpace),
        child: ZElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalPrice)
              : () => ZSnackBarHelpers.errorSnackBar(
                  title: "Cart is Empty",
                  message: "Add items in the cart",
                ),
          child: Text("Checkout ${ZTexts.currency}$totalPrice"),
        ),
      ),
    );
  }
}
