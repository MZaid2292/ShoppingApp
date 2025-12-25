import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce/common/widgets/products/products_card/product_card_vertical.dart';
import 'package:e_commerce/features/shop/controllers/products/product_controller.dart';
import 'package:e_commerce/features/shop/screen/search_store/widgets/search_store_brands.dart';
import 'package:e_commerce/features/shop/screen/search_store/widgets/search_store_categories.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SearchStoreScreen extends StatelessWidget {
  const SearchStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxString searchText = "".obs;

    return Scaffold(
      appBar: ZAppBar(
        showBackArrow: true,
        title: Text(
          "Search",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Column(
            children: [
              /// Search Field
              Hero(
                tag: "search_animation",
                child: Material(
                  color: Colors.transparent,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal),
                      hintText: "Search in store",
                    ),
                    onChanged: (value) => searchText.value = value,
                  ),
                ),
              ),
              SizedBox(height: ZSizes.spaceBtwSections),

              Obx(() {
                if (searchText.value.isEmpty) {
                  return Column(
                    children: [
                      /// Brands
                      SearchStoreBrands(),
                      SizedBox(height: ZSizes.spaceBtwSections),

                      /// Categories
                      SearchStoreCategories(),
                    ],
                  );
                }
                return FutureBuilder(
                  future: ProductController.instance.getAllProducts(),
                  builder: (context, snapshot) {
                    /// Handle Loading, Error, Empty State
                    final widget = ZCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                    );
                    if (widget != null) return widget;

                    /// Data Found
                    final products = snapshot.data!;

                    final filteredProducts = products.where(
                          (product) => product.title.toLowerCase().contains(
                            searchText.value.toLowerCase(),
                          )).toList();

                    /// Filtered Product Empty
                    if(filteredProducts.isEmpty) return Text("No products found!");

                    return ZGridLayout(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ZProductCardVertical(product: product);
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
