//Meta Data means data inside a data.

import 'package:e_commerce/features/shop/controllers/products/product_controller.dart';
import 'package:e_commerce/utils/constant/enums.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


import '../../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../../common/widgets/images/circular_image.dart';
import '../../../../../../common/widgets/texts/brand_title_with_verify_icon.dart';
import '../../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../../utils/constant/colors.dart';
import '../../../../../../utils/constant/sized.dart';
import '../../../../models/product_model.dart';

class ZProductMetaData extends StatelessWidget {
  const ZProductMetaData({
    super.key, required this.product,
  });


  final ProductModel product;


  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;

    String? salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ///Sale Tag , Sale Price , Actual Price , and Share Button
        Row(
          children: [
            ///Sale Tag

            if(salePercentage != null)...[
              ZRoundedContainer(
                radius: ZSizes.sm,
                backgroundColor: ZColors.yellow.withValues(alpha: 0.8),
                padding: EdgeInsets.symmetric(
                  horizontal: ZSizes.sm,
                  vertical: ZSizes.xs,
                ),
                child: Text(
                  "$salePercentage%",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.apply(color: ZColors.black),
                ),
              ),
              SizedBox(width: ZSizes.spaceBtwItems),
            ],


            ///Actual price
            if(product.productType == ProductType.single.toString() && product.salePrice > 0)...[
              Text(
                  "${ZTexts.currency}${product.price.toStringAsFixed(0)}",
                  style: Theme.of(context).textTheme.titleSmall!.apply(
                      decoration: TextDecoration.lineThrough)),
              SizedBox(width: ZSizes.spaceBtwItems),
            ],


            ///Sale Price or Actual Price
            ZProductPrice(price: controller.getProductPrice(product),isLarge: true),
            Spacer(),

            ///Share Button
            IconButton(onPressed: (){},
              icon: Icon(Iconsax.share),
            ),
          ],
        ),
        SizedBox(height: ZSizes.spaceBtwItems / 1.5),

        ///Product Title
        ZProductTitleText(title: product.title),
        SizedBox(height: ZSizes.spaceBtwItems / 1.5),

        ///Product Status
        Row(
          children: [
            ZProductTitleText(title: "Status"),
            SizedBox(width: ZSizes.spaceBtwItems),

            Text(controller.getProductStockStatus(product.stock),style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        SizedBox(height: ZSizes.spaceBtwItems / 1.5),


        ///Product Brand Image With Title
        Row(
          children: [

            ///Brand Image
            ZCircularImage(
                padding: 0,
                isNetworkImage: true,
                image: product.brand != null ? product.brand!.image : "",width: 32.0,height: 32.0),
            SizedBox(width: ZSizes.spaceBtwItems),

            ///Brand Title
            ZBrandTitleWithVerifyIcon(title: product.brand != null ? product.brand!.name : "")
          ],
        ),




      ],
    );
  }
}