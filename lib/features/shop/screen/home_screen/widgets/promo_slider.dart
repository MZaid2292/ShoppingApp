import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effects.dart';
import 'package:e_commerce/features/shop/controllers/banners/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constant/sized.dart';
import 'banners_dot_navigation.dart';

class ZPromoSlider extends StatelessWidget {
  const ZPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController = Get.put(BannerController());

    return Obx(() {
      if (bannerController.isLoading.value) {
        return ZShimmerEffect(width: double.infinity, height: 190);
      }
      if (bannerController.banners.isEmpty) {
        return Text("Banners Not Found");
      }

      return Column(
        children: [
          ///CarouselSlider
          CarouselSlider(
            items: //items means banners how many banners we want to use
            bannerController.banners
                .map(
                  (banner) => ZRoundedImage(
                    imageUrl: banner.imageUrl,
                    isNetworkImage: true,
                    onTap: () => Get.toNamed(banner.targetScreen),
                  ),
                )
                .toList(),

            options: CarouselOptions(
              viewportFraction: //viewportFraction means how much space one item takes on the screen
                  1.0,
              onPageChanged: (index, reason) =>
                  bannerController.onPageChanged(index),
            ),
            carouselController: bannerController.carouselController,
          ),

          SizedBox(height: ZSizes.spaceBtwItems),

          BannersDotNavigation(),
        ],
      );
    });
  }
}
