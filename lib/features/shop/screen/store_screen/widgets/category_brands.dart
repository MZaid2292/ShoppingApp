import "package:e_commerce/common/widgets/shimmer/boxes_shimmer.dart";
import "package:e_commerce/common/widgets/shimmer/list_tile_shimmer.dart";
import "package:e_commerce/features/shop/controllers/brands/brand_controller.dart";
import "package:e_commerce/features/shop/models/category_model.dart";
import "package:e_commerce/utils/constant/sized.dart";
import "package:e_commerce/utils/helpers/cloud_helper_functions.dart";
import "package:flutter/material.dart";
import "../../../../../common/widgets/brands/brands_showcase.dart";

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return  FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {

        const loader = Column(
          children: [
            ZListTileShimmer(),
            SizedBox(height: ZSizes.spaceBtwItems),
            ZBoxesShimmer(),
            SizedBox(height: ZSizes.spaceBtwItems),
          ],
        );

        // Handle Loader, No Records, Error
        final widget = ZCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
        if(widget != null) return widget;

        /// Records Found
        final brands = snapshot.data!;
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
            itemCount: brands.length,
            itemBuilder: (context , index){
              final brand = brands[index];
              return FutureBuilder(
                  future: controller.getBrandProducts(brand.id,limit: 3),
                  builder: (context, snapshot) {

                    /// Handle loader, or No Records, Error
                    final widget = ZCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if(widget != null) return widget;

                    /// Products Found
                    final products = snapshot.data!;
                    return ZBrandShowcase(
                        brand: brand,
                        images: products.map((product) => product.thumbnail).toList()
                    );
                  },
              );
            }
        );
      }
    );

  }
}
