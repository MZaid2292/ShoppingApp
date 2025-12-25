import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import '../../../utils/constant/colors.dart';

class ZCircularImage extends StatelessWidget {
  const ZCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = ZSizes.sm,
    this.showBorder = false,
    this.borderColor = ZColors.primaryColor,
    this.borderWidth = 1.0,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunctions.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (dark ? ZColors.dark : ZColors.light),
        borderRadius: BorderRadius.circular(100),
        border: showBorder ? Border.all(color: borderColor, width: borderWidth):null),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: isNetworkImage
            ?CachedNetworkImage(
            fit: fit,
            color: overlayColor,
            progressIndicatorBuilder: (context, url, progress) => ZShimmerEffect(width: 55, height: 55),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageUrl: image)
            : Image(
          fit: fit,
          image:  AssetImage(image)),
      ),
    );
  }
}
