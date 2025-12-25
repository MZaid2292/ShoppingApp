import 'package:e_commerce/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sized.dart';
import '../../../../../utils/helpers/helpers_function.dart';
import '../../../models/payment_method_model.dart';

class ZPaymentTile extends StatelessWidget {
  const ZPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      onTap: (){
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      contentPadding: EdgeInsets.zero,
      leading: ZRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: ZHelperFunctions.isDarkMode(context) ? ZColors.light : ZColors.white,
        padding: EdgeInsets.all(ZSizes.sm),
        child: Image(image: AssetImage(paymentMethod.image),fit: BoxFit.contain),
      ),
      title: Text(paymentMethod.name),
      trailing: Icon(Iconsax.arrow_right_34),
    );
  }
}