import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/utils/constant/colors.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ZBillingAddress extends StatelessWidget {
  const ZBillingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    controller.getAllAddresses();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// [Text] - Billing Address
          ZSectionHeading(title: "Billing Address",buttonTitle: "Change",onPressed: () => controller.selectNewAddressBottomSheet(context)),

          Obx(() {

            final address = controller.selectedAddress.value;
            if(address.id.isEmpty){
              return Text("Select Address");
            }


            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.name,style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: ZSizes.spaceBtwItems / 2),

                Row(
                  children: [
                    Icon(Icons.phone,size: ZSizes.iconSm,color: ZColors.darkGrey),
                    SizedBox(width: ZSizes.spaceBtwItems),
                    Text(address.phoneNumber),
                  ],
                ),
                SizedBox(height: ZSizes.spaceBtwItems / 2),

                Row(
                  children: [
                    Icon(Icons.location_history,size: ZSizes.iconSm,color: ZColors.darkGrey),
                    SizedBox(width: ZSizes.spaceBtwItems),
                    Expanded(child: Text(address.toString(),softWrap: true)),
                  ],
                ),
              ],
            );
          })
    ]);
  }
}
