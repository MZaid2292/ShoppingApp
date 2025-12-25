import 'package:e_commerce/features/shop/controllers/home/home_screen_controller.dart';
import 'package:e_commerce/features/shop/controllers/products/product_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/screen/all_products/all_products.dart';
import 'package:e_commerce/features/shop/screen/home_screen/widgets/home_appbar.dart';
import 'package:e_commerce/features/shop/screen/home_screen/widgets/home_categories.dart';
import 'package:e_commerce/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:e_commerce/features/shop/screen/home_screen/widgets/promo_slider.dart';

import 'package:e_commerce/utils/constant/sized.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/TextFields/search_bar.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/products_card/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final controller = Get.put(HomeScreenController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///-------------[Upper Part]-------------------
            Stack(
              children: [
                ///Total height  +  20
                SizedBox(height: ZSizes.homePrimaryHeaderHeight + 10),

                ///Primary Header Container
                ZPrimaryHeaderContainer(
                  height: ZSizes.homePrimaryHeaderHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Home AppBar
                      ZHomeAppBar(),

                      SizedBox(height: ZSizes.spaceBtwSections),

                      ///Home Categories
                      ZHomeCategories(),
                    ],
                  ),
                ),

                ///Search Bar
                ZSearchBar(),
              ],
            ),

            ///--------------[Lower Part]------------------
            ///Banners
            Padding(
              padding: const EdgeInsets.all(ZSizes.defaultSpace),
              child: Column(
                children: [
                  ///Banners
                  ZPromoSlider(),

                  SizedBox(height: ZSizes.spaceBtwSections),

                  ///Sections heading
                  ZSectionHeading(
                    title: "Popular Products",
                    onPressed: () => Get.to(
                      () => AllProductsScreen(
                        title: "Popular Products",
                        futureMethod: productController.getAllFeaturedProduct(),
                      ),
                    ),
                  ),
                  SizedBox(height: ZSizes.spaceBtwItems),

                  ///GridView of  Product Card
                  Obx(() {
                    if (productController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (productController.featuredProducts.isEmpty) {
                      return Center(child: Text("Products Not Found"));
                    }

                    return ZGridLayout(
                      itemCount: productController.featuredProducts.length,
                      itemBuilder: (context, index) {
                        ProductModel product =
                            productController.featuredProducts[index];
                        return ZProductCardVertical(product: product);
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
