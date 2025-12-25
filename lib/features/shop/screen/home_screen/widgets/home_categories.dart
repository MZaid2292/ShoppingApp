import 'package:e_commerce/common/widgets/shimmer/category_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/screen/sub_categories/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sized.dart';
import '../../../../../utils/constant/texts.dart';

class ZHomeCategories extends StatelessWidget {
  const ZHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Padding(
      padding: const EdgeInsets.only(left: ZSizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Section heading
          Text(
            ZTexts.popularCategories,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: ZColors.white),
          ),

          SizedBox(height: ZSizes.spaceBtwItems),

          ///ListView Categories List
          Obx(
            () {

              final categories = controller.featuredCategories;

              /// [Loading State]
              if(controller.isCategoriesLoading.value){
                return ZCategoryShimmer(itemCount: 6);
              }


              /// [Empty]
              if(categories.isEmpty){
                return Text("Categories Not Found");
              }

              /// [Data Found]
              return SizedBox(
                height: 82,
                child: ListView.separated(
                  //separated create space between two items
                  separatorBuilder: (context, index) =>
                      SizedBox(width: ZSizes.spaceBtwItems),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    CategoryModel category = categories[index];
                    return ZVerticalImageTexts(
                      title: category.name,
                      image: category.image,
                      textColor: ZColors.white,
                      onTap: ()=>Get.to(()=>SubCategoriesScreen(category: category)),
                    );
                  },
                  itemCount: categories.length,
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
