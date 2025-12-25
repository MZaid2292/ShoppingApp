











import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/products/variation_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/constant/colors.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/chips/choice_chips.dart';

class ZProductAttributes extends StatelessWidget {
  const ZProductAttributes({super.key, required this.product});


  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());

    return Obx(
        () =>  Column(
        children: [

          ///Selected Attributes Pricing & Description
          if(controller.selectedVariation.value.id.isNotEmpty)
          ZRoundedContainer(
            padding: EdgeInsets.all(ZSizes.md),
            backgroundColor: dark ? ZColors.darkerGrey : ZColors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ///Title Price & Stock
                Row(
                  children: [

                    ///[Text] - Variation Heading
                    ZSectionHeading(title: "Variation", showActionButton: false),
                    SizedBox(width: ZSizes.spaceBtwItems),

                Column(
                  children: [

                    ///First Row (Price Sale Price , Actual Price)
                    Row(
                      children: [
                        ///[Text] - Price
                        ZProductTitleText(title: "Price: ", smallSize: true),

                        ///Actual Price
                        if(controller.selectedVariation.value.salePrice > 0)
                        Text(
                            "${ZTexts.currency}${controller.selectedVariation.value.price.toStringAsFixed(0)}",
                            style: Theme.of(context).textTheme.titleSmall!.apply(
                                decoration: TextDecoration.lineThrough)),
                        SizedBox(width: ZSizes.spaceBtwItems),

                        ///Sale Price
                        ZProductPrice(price: controller.getVarionPrice())]),


                    ///2nd Row [Stock Status]
                    Row(
                      children: [
                        ZProductTitleText(title: "Stock: ", smallSize: true),

                        Text(controller.variationStockStatus.value,style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  ],
                ),
                  ],
                ),


                ///Attributes Description
                ZProductTitleText(title: controller.selectedVariation.value.description ?? "",smallSize: true,maxLines: 4)
              ],
            ),
          ),
          SizedBox(height: ZSizes.spaceBtwItems),

          ///Attributes - [Colors]
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:product.productAttributes!.map((attribute) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ZSectionHeading(title: attribute.name ?? "",showActionButton: false),
                  SizedBox(height: ZSizes.spaceBtwItems / 2),

                  Wrap(
                      spacing: ZSizes.sm,
                      children: attribute.values!.map((attributeValue) {
                        bool isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                        bool available = controller.getAttributesAvailabilityInVariation(product.productVariations!, attribute.name!).contains(attributeValue);
                        return ZChoiceChip(
                            text: attributeValue,
                            selected: isSelected,
                            onSelected:available ?  (selected){
                              if(available && selected){
                                controller.onAttributeSelected(product, attribute.name, attributeValue);
                              }
                            } : null
                        );
                      }).toList()
                  ),
                ],
              );
            }).toList(),


          ),



          // //Attributes - [Sizes]
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     ZSectionHeading(title: "Sizes",showActionButton: false),
          //     SizedBox(height: ZSizes.spaceBtwItems / 2),
          //
          //     Wrap(
          //       spacing: ZSizes.sm,
          //       children: [
          //         ZChoiceChip(text: "Small",selected: false,onSelected: (value){}),
          //         ZChoiceChip(text: "Medium",selected: true,onSelected: (value){}),
          //         ZChoiceChip(text: "Large",selected: false,onSelected: (value){}),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}






