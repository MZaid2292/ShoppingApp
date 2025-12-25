import 'package:e_commerce/features/shop/controllers/brands/brand_controller.dart';
import 'package:e_commerce/features/shop/models/brands_model.dart';
import 'package:e_commerce/features/shop/screen/brands/all_brands.dart';
import 'package:e_commerce/features/shop/screen/brands/brand_products.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sized.dart';

class SearchStoreBrands extends StatelessWidget {
  const SearchStoreBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    bool dark = ZHelperFunctions.isDarkMode(context);
    return Obx(() {
      /// [State] - Loading
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      /// [State] - Empty
      if (controller.allBrands.isEmpty) return Text("No Brands Found!");

      /// [State] - Data Found
      List<BrandModel> brands = controller.allBrands.take(10).toList();
      return Column(
        children: [
          ZSectionHeading(
            title: "Brands",
            onPressed: () => Get.to(() => AllBrandsScreen()),
          ),
          SizedBox(height: ZSizes.spaceBtwItems),
          Wrap(
            spacing: ZSizes.spaceBtwItems,
            runSpacing: ZSizes.spaceBtwItems,
            children: brands
                .map(
                  (brand) => ZVerticalImageTexts(
                    onTap: () => Get.to(
                      () =>
                          BrandProductsScreen(title: brand.name, brand: brand),
                    ),
                    title: brand.name,
                    image: brand.image,
                    textColor: dark ? ZColors.white : ZColors.black,
                  ),
                )
                .toList(),
          ),
        ],
      );
    });
  }
}
