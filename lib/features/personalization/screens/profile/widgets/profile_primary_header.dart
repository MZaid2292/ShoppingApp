
import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/primary_header_container.dart';

import '../../../../../common/widgets/images/user_profile_logo.dart';

import '../../../../../utils/constant/sized.dart';

class ZProfilePrimaryHeader extends StatelessWidget {
  const ZProfilePrimaryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Total Height
        SizedBox(height: ZSizes.profilePrimaryHeaderHeight + 60),

        ZPrimaryHeaderContainer(
          height: ZSizes.profilePrimaryHeaderHeight,
          child: Container(),
        ),

        ///User Profile
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: UserProfileLogo(),
          ),
        ),


      ],
    );
  }
}

