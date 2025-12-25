import 'package:e_commerce/common/widgets/custom_shapes/rounded_edges_container.dart';
import 'package:flutter/material.dart';
import 'circular_container.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/sized.dart';


class ZPrimaryHeaderContainer extends StatelessWidget {
  const ZPrimaryHeaderContainer({
    super.key, required this.child, required this.height,
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ZRoundedEdgesContainer(
      child: Container(
        height: height,
        color: ZColors.primaryColor,
        child: Stack(
          children: [

            //Circular Container
            Positioned(
              top: -150,
              right: -160,
              child: ZCircularContainer(
                height: ZSizes.homePrimaryHeaderHeight,
                width: ZSizes.homePrimaryHeaderHeight,
                backgroundColor: ZColors.white.withValues(alpha: 0.1),

              ),
            ),

            //Circular Container
            Positioned(
              top: 50,
              right: -250,
              child: ZCircularContainer(
                height: ZSizes.homePrimaryHeaderHeight,
                width: ZSizes.homePrimaryHeaderHeight,
                backgroundColor: ZColors.white.withValues(alpha: 0.1),
              ),
            ),

            ///Child
            child
          ],
        ),
      ),
    );
  }
}


