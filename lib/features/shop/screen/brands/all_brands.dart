import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/brands/brand_card.dart';
import 'package:e_commerce/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/brands/brand_controller.dart';
import 'package:e_commerce/features/shop/models/brands_model.dart';
import 'package:e_commerce/features/shop/screen/brands/brand_products.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: ZAppBar(
        showBackArrow: true,
        title: Text("Brand", style: Theme.of(context).textTheme.headlineSmall),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Column(
            children: [

              /// [Text] - Brands
              ZSectionHeading(title: "Brand",showActionButton: false),
              SizedBox(height: ZSizes.spaceBtwItems),

              ///List of Brands
              Obx(
                (){

                  // Start Loading
                  if(controller.isLoading.value){
                    return Center(child: CircularProgressIndicator());
                  }

                  // [Empty] - State
                  if(controller.allBrands.isEmpty){
                    return Center(child: Text("Brands Not Found"));
                  }

                  // [DataFound] - State
                  return ZGridLayout(
                    itemCount: controller.allBrands.length,
                    itemBuilder: (context, index) {
                      BrandModel brand = controller.allBrands[index];
                      return ZBrandCard(onTap: ()=>Get.to(()=>BrandProductsScreen(
                          title: brand.name,
                        brand: brand,
                      )),brand: brand);
                    },
                    mainAxisExtent: 80,
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
