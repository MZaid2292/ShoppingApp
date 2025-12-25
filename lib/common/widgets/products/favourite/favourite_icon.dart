import 'package:e_commerce/features/shop/controllers/products/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

import '../../icons/circular_icon.dart';

class ZFavouriteIcon extends StatelessWidget {
  const ZFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return  Obx(
        () => ZCircularIcon(
        icon: controller.isFavourite(productId) ? Iconsax.heart5
        :Iconsax.heart,
          color:controller.isFavourite(productId) ? Colors.red : null,
        onPressed: () => controller.toggleFavouriteProduct(productId),
      ),
    );
  }
}
