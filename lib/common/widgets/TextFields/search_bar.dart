import 'package:e_commerce/common/styles/shadow.dart';
import 'package:e_commerce/features/shop/screen/search_store/search_store.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/sized.dart';
import '../../../utils/constant/texts.dart';

class ZSearchBar extends StatelessWidget {
  const ZSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    bool dark = ZHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: 0,
      right: ZSizes.spaceBtwSections,
      left: ZSizes.spaceBtwSections,
      child: GestureDetector(
        onTap: () => Get.to(() => SearchStoreScreen()),
        child: Hero(
          tag: "search_animation",
          child: Container(
            height: ZSizes.searchBarHeight,
            padding: EdgeInsets.symmetric(horizontal: ZSizes.md),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ZSizes.borderRadiusLg),
                color: dark ? ZColors.dark : ZColors.light,
                boxShadow: ZShadow.searchBarShadow,
            ),
            child: Row(
              children: [
          
                //Search Icon
                Icon(Iconsax.search_normal,color: ZColors.darkGrey),
                SizedBox(width: ZSizes.spaceBtwItems),
                //Search Title
                Text(ZTexts.searchBarTitle,style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        ),
      ),
    );
  }
}