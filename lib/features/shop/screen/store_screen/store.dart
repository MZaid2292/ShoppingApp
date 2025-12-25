
import 'package:e_commerce/common/widgets/shimmer/brands_shimmer.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/brands/brand_controller.dart';
import 'package:e_commerce/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shop/models/brands_model.dart';
import 'package:e_commerce/features/shop/screen/brands/all_brands.dart';
import 'package:e_commerce/features/shop/screen/store_screen/widgets/category_tab.dart';
import 'package:e_commerce/features/shop/screen/store_screen/widgets/store_primary_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_card.dart';

import '../../../../utils/constant/sized.dart';
import '../brands/brand_products.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final brandController = Get.put(BrandController());


    return DefaultTabController(
      length: controller.featuredCategories.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                //A SliverAppBar is a collapsible and scrollable app bar in Flutter.
                automaticallyImplyLeading: false,
                expandedHeight: 340,
                pinned: true,
                //isko false karunga to pura ka pura oper jaega appBar show nh hoga
                floating: false,
                //means ye appBar ko show hony dega

                ///-------------[Upper Part]-------------------
                flexibleSpace: SingleChildScrollView(
                  child: Column(
                    children: [
                      ZStorePrimaryHeader(),

                      SizedBox(height: ZSizes.spaceBtwItems),

                      ///Brands List
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ZSizes.defaultSpace,
                        ),
                        child: Column(
                          children: [
                            ///Brand Heading
                            ZSectionHeading(title: "Brands", onPressed: ()=>Get.to(()=>AllBrandsScreen())),

                            ///Brand Card
                            SizedBox(
                              height: ZSizes.brandCardHeight,
                              child: Obx(
                                  (){

                                    /// Loading State
                                    if(brandController.isLoading.value){
                                      return ZBrandsShimmer();
                                    }

                                    /// Empty State
                                    if(brandController.featuredBrands.isEmpty){
                                      return Text("Brands Not Found");
                                    }

                                    ///  [DataFound] - State
                                    return ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            SizedBox(width: ZSizes.spaceBtwItems),
                                        shrinkWrap: true,
                                        itemCount: brandController.featuredBrands.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {


                                          BrandModel brand = brandController.featuredBrands[index];
                                          return SizedBox(width: ZSizes.brandCardWidth, child: ZBrandCard(brand: brand , onTap: ()=>Get.to(()=>BrandProductsScreen(
                                            title: brand.name,
                                            brand: brand,
                                          ))));
                                        }
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                bottom: ZTabBar(
                  tabs: controller.featuredCategories.map((category) => Tab(child: Text(category.name))).toList()
                ),
              ),
            ];
          },
          body: TabBarView(
            children: controller.featuredCategories.map((category) => ZCategoryTab(category: category)).toList()
          ),
        ),
      ),
    );
  }
}


