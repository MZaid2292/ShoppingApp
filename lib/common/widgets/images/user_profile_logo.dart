import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/images.dart';
import 'circular_image.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Obx(
        () {
          bool isProfileAvailable = controller.user.value.profilePicture.isNotEmpty;

          /// [Loading State]
          if(controller.isProfileUploading.value){
            return ZShimmerEffect(width: 120.0, height: 120.0,radius: 120);
          }
          return ZCircularImage(
            image: isProfileAvailable ? controller.user.value.profilePicture : ZImages.profileLogo,
            height: 120,
            width: 120,
            borderWidth: 5.0,
            padding: 0,
            isNetworkImage: isProfileAvailable ? true : false,
          );
        }
    );
  }
}