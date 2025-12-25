
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/models/payment_method_model.dart';
import 'package:e_commerce/utils/constant/enums.dart';
import 'package:e_commerce/utils/constant/images.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController{
  static CheckoutController get instance => Get.find();


  /// Variables
  Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;


  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: "Cash on delivery", image: ZImages.codIcon,paymentMethod: PaymentMethods.cashOnDelivery);
    super.onInit();
  }

  Future<void> selectPaymentMethod(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(ZSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZSectionHeading(title: "Select Payment Method",showActionButton: false),
                SizedBox(height: ZSizes.spaceBtwSections),
                ZPaymentTile(paymentMethod: PaymentMethodModel(name: "Cash on delivery", image: ZImages.codIcon,paymentMethod: PaymentMethods.cashOnDelivery)),
                SizedBox(height: ZSizes.spaceBtwItems / 2),
                ZPaymentTile(paymentMethod: PaymentMethodModel(name: "Paypal", image: ZImages.paypal,paymentMethod: PaymentMethods.paypal)),
                SizedBox(height: ZSizes.spaceBtwItems / 2),
                ZPaymentTile(paymentMethod: PaymentMethodModel(name: "Credit Card", image: ZImages.creditCard,paymentMethod: PaymentMethods.creditCard)),
                SizedBox(height: ZSizes.spaceBtwItems / 2),
                ZPaymentTile(paymentMethod: PaymentMethodModel(name: "Master Card", image: ZImages.masterCard,paymentMethod: PaymentMethods.masterCard)),
                SizedBox(height: ZSizes.spaceBtwItems / 2),



              ],
            ),
          ),
        ),
    );
  }
}



