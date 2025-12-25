import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:e_commerce/utils/constant/colors.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../utils/constant/sized.dart';

class ZSingleAddress extends StatelessWidget {
  const ZSingleAddress({
    super.key,
    required this.address, required this.onTap,
  });


  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunctions.isDarkMode(context);
    final controller = AddressController.instance;

    return Obx((){
      String selectedAddressId = controller.selectedAddress.value.id;
      bool isSelected = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: ZRoundedContainer(
          width: double.infinity,
          showBorder: true,
          backgroundColor: isSelected ? ZColors.primaryColor.withValues(alpha: 0.5):Colors.transparent,
          borderColor: isSelected ? Colors.transparent : dark ?ZColors.darkerGrey : ZColors.grey,
          padding: EdgeInsets.all(ZSizes.md),
          child: Stack(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ///Name
                  Text(
                    address.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ZSizes.spaceBtwItems / 2),

                  ///Phone Number
                  Text(address.phoneNumber,maxLines: 1,overflow: TextOverflow.ellipsis),
                  SizedBox(height: ZSizes.spaceBtwItems / 2),

                  ///Address
                  Text(address.toString()),
                ],
              ),


              if(isSelected) Positioned(
                  top: 0,
                  bottom: 0,
                  right: 6,
                  child: Icon(Iconsax.tick_circle5)),
            ],
          ),
        ),
      );
    });
  }
}