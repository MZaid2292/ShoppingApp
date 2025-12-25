import 'package:e_commerce/common/widgets/images/circular_image.dart';
import 'package:flutter/material.dart';
import '../../../utils/constant/sized.dart';


class ZVerticalImageTexts extends StatelessWidget {
  const ZVerticalImageTexts({
    super.key,
    required this.title,
    required this.image,
    required this.textColor,
    this.backgroundColor,
    this.onTap,
  });

  final String title, image;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ///Circular Image
          ZCircularImage(height: 56,
              width:56,
              image: image,
            isNetworkImage: true,
          ),


          SizedBox(height: ZSizes.spaceBtwItems / 2),

          ///Title
          SizedBox(
            width: 55,
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.apply(color: textColor),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}