import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sized.dart';
import '../../icons/circular_icon.dart';

class ZProductQuantityWithAddRemove extends StatelessWidget {
  const ZProductQuantityWithAddRemove({
    super.key, required this.quantity, this.add, this.remove,

  });

  final int quantity;
  final VoidCallback? add , remove;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        ///Decrement Button
        ZCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: ZSizes.iconSm,
          color: dark ? ZColors.white:ZColors.black,
          backgroundColor: dark ? ZColors.darkerGrey:ZColors.light,
          onPressed: remove,
        ),
        SizedBox(width: ZSizes.spaceBtwItems),

        Text(quantity.toString() , style: Theme.of(context).textTheme.titleSmall),
        SizedBox(width: ZSizes.spaceBtwItems),

        ///Increment Button
        ZCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: ZSizes.iconSm,
          color: ZColors.white,
          backgroundColor: ZColors.primaryColor,
          onPressed: add,
        ),
      ],
    );
  }
}