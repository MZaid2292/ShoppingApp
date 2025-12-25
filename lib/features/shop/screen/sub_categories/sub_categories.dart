import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/screen/all_products/all_products.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/products/products_card/product_card_horizontal.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: ZAppBar(showBackArrow: true,title: Text(category.name)),

      body: SingleChildScrollView(
        child: Padding(
            padding:ZPadding.screenPadding,
          child: FutureBuilder(
              future: controller.getSubCategories(category.id),
              builder: (context, snapshot) {


                /// Handle Loader, Error, Empty Data
                const loader = ZHorizontalProductShimmer();

                final widget = ZCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                if(widget != null) return widget;
                /// Data Found - Sub Categories
                List<CategoryModel> subCategories = snapshot.data!;
               return ListView.builder(
                 shrinkWrap: true,
                   itemCount: subCategories.length,
                   physics: NeverScrollableScrollPhysics(),
                   itemBuilder: (context, index) {
                     CategoryModel subCategory = subCategories[index];

                     /// Fetch Products for sub categories
                     return FutureBuilder(
                         future: controller.getCategoryProducts(categoryId: subCategory.id),
                         builder:(context, snapshot) {

                           /// Handle loader, Error and Empty Data

                           final widget = ZCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                           if(widget != null) return widget;

                           /// Data found - Products Found
                           List<ProductModel> products = snapshot.data!;
                           return Column(
                             children: [

                               ///Sub Categories
                               ZSectionHeading(title: subCategory.name,onPressed: () => Get.to(() => AllProductsScreen(
                                   title: subCategory.name,
                                 futureMethod: controller.getCategoryProducts(categoryId: subCategory.id,limit: -1),
                               ))),
                               SizedBox(height: ZSizes.spaceBtwItems / 2),

                               ///Horizontal Product Card
                               SizedBox(
                                   height: 120,
                                   child: ListView.separated(
                                     separatorBuilder: (context, index) => SizedBox(width: ZSizes.spaceBtwItems / 2),
                                     itemCount: products.length,
                                     scrollDirection: Axis.horizontal,
                                     itemBuilder: (context, index) {

                                       ProductModel product = products[index];
                                       return ZProductCardHorizontal(product: product);
                                     },
                                   )),
                             ],
                           );
                         },
                     );
                   },
               );
              },
          ),
        ),
      ),
    );
  }
}


