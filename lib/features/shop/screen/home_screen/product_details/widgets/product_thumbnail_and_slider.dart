import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common/widgets/products/favourite/favourite_icon.dart';
import 'package:e_commerce/features/shop/controllers/products/image_controller.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/appbar/custom_appbar.dart';
import '../../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../../utils/constant/colors.dart';
import '../../../../../../utils/constant/sized.dart';
import '../../../../models/product_model.dart';

class ZProductThumbnailAndSlider extends StatelessWidget {
  const ZProductThumbnailAndSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageController());
    final dark = ZHelperFunctions.isDarkMode(context);

    List<String> images = controller.getAllProductImages(product);

    return Container(
      color: dark ? ZColors.darkerGrey : ZColors.light,
      child: Stack(
        children: [
          ///-----------[Image] - [Thumbnail]-------------
          SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(ZSizes.productImageRadius * 2),
              child: Center(
                child: Obx(
                  (){

                    final image  = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () =>  controller.showEnlargeImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (context, url, progress) =>
                            CircularProgressIndicator(color: ZColors.primaryColor,value: progress.progress),
                      ),
                    );
                  }
                ),
              ),
            ),
          ),

          ///Image Slider
          Positioned(
            left: ZSizes.defaultSpace,
            right: 0,
            bottom: 30,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: ZSizes.spaceBtwItems),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) => Obx(
                  (){

                    bool isImageSelected = controller.selectedProductImage.value == images[index];
                    return ZRoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      onTap: () => controller.selectedProductImage.value = images[index],
                      backgroundColor: dark ? ZColors.dark : ZColors.light,
                      padding: EdgeInsets.all(ZSizes.sm),
                      border: Border.all(color: isImageSelected ? ZColors.primaryColor : Colors.transparent),
                      imageUrl: images[index],
                    );
                  }
                ),
              ),
            ),
          ),

          ///Back Arrow and Favourite Icon
          ZAppBar(
            showBackArrow: true,
            actions: [ZFavouriteIcon(productId: product.id)],
          ),
        ],
      ),
    );
  }
}
