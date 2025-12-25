import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:e_commerce/utils/constant/colors.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZBillingPaymentSection extends StatelessWidget {
  const ZBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunctions.isDarkMode(context);
    final controller = Get.put(CheckoutController());
    return Column(
      children: [
        /// [Text] - Payment Method
        ZSectionHeading(
          title: "Payment Method",
          buttonTitle: "Change",
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        SizedBox(height: ZSizes.spaceBtwItems / 2),

        Obx(
          () => Row(
            children: [
              ///Payment Logo
              ZRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? ZColors.light : Colors.white,
                padding: EdgeInsets.all(ZSizes.sm),
                child: Image(
                  image: AssetImage(
                    controller.selectedPaymentMethod.value.image,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: ZSizes.spaceBtwItems / 2),

              ///Payment Name
              Text(
                controller.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
