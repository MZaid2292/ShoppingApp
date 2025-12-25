import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../../common/widgets/appbar/custom_appbar.dart';
import '../../../../../common/widgets/products/cart/cart_counter.dart';
import '../../../../../utils/constant/colors.dart';


class ZHomeAppBar extends StatelessWidget {
  const ZHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return ZAppBar(

      ///Title and SubTitle
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Title
          Text(
            ZHelperFunctions.getGreetingMessage(),
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: ZColors.grey),
          ),
          SizedBox(height: ZSizes.spaceBtwItems / 3),

          ///SubTitle
          Obx(
            (){
              if(controller.profileLoading.value){
                return ZShimmerEffect(width: 80, height: 15);
              }

              return Text(
                controller.user.value.fullName,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.apply(color: ZColors.white),
              );
            }
          ),
        ],
      ),

      actions: [
        ZCartCounterIcon(),
      ],
    );
  }
}