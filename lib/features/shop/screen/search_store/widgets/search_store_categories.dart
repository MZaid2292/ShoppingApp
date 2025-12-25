import 'package:e_commerce/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/screen/all_products/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constant/sized.dart';

class SearchStoreCategories extends StatelessWidget {
  const SearchStoreCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Obx(() {
      /// [State] - Loading
      if (controller.isCategoriesLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      /// [State] - Empty
      if (controller.allCategories.isEmpty) return Text("No Categories Found!");

      /// [State] - Data Found
      List<CategoryModel> categories = controller.allCategories;

      return Column(
        children: [
          ZSectionHeading(title: "Categories", showActionButton: false),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              CategoryModel category = categories[index];
              return ListTile(
                onTap: () => Get.to(
                  () => AllProductsScreen(
                    title: category.name,
                    futureMethod: controller.getCategoryProducts(
                      categoryId: category.id,
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                leading: ZRoundedImage(
                  imageUrl: category.image,
                  borderRadius: 0,
                  width: ZSizes.iconLg,
                  height: ZSizes.iconLg,
                  isNetworkImage: true,
                ),
                title: Text(category.name),
              );
            },
          ),
        ],
      );
    });
  }
}
