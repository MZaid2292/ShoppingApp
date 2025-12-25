import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/screen/all_products/all_products.dart';
import 'package:e_commerce/features/shop/screen/store_screen/widgets/category_brands.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/products_card/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constant/sized.dart';
import '../../../models/product_model.dart';

class ZCategoryTab extends StatelessWidget {
  const ZCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: ZSizes.defaultSpace),
          child: Column(
            children: [
              ///Brand Showcase 1
              CategoryBrands(category: category),

              SizedBox(height: ZSizes.spaceBtwItems),

              ///You might like section heading
              ZSectionHeading(
                title: "You might like",
                onPressed: () =>
                    Get.to(() => AllProductsScreen(
                        title: category.name,
                         futureMethod: controller.getCategoryProducts(categoryId: category.id,limit: -1),

                    )),
              ),

              ///Grid Layout products
             FutureBuilder(
               future: controller.getCategoryProducts(categoryId: category.id),
                 builder: (context, snapshot) {


                 /// Handle Error, Loader, and Empty states

                 const loader = ZVerticalProductShimmer(itemCount: 4);

                 final widget = ZCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot , loader: loader);
                 if(widget != null) return widget;

                 /// Data found
                 List<ProductModel> products = snapshot.data!;
                 return  ZGridLayout(

                   itemCount: products.length,
                   itemBuilder: (context, index) {
                     ProductModel product = products[index];
                     return ZProductCardVertical(product: product);
                   },
                 );
                 },
             ),

              SizedBox(height: ZSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
