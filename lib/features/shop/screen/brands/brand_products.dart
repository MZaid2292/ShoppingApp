import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/brands/brand_card.dart';
import 'package:e_commerce/common/widgets/products/sortable_products.dart';
import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/brands/brand_controller.dart';
import 'package:e_commerce/features/shop/models/brands_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key , required this.title, required this.brand});

  final String title;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: ZAppBar(showBackArrow: true,title: Text(title,style: Theme.of(context).textTheme.headlineSmall)),

      body: SingleChildScrollView(
        child: Padding(
            padding:ZPadding.screenPadding,
          child: Column(
            children: [

              ///Brands
              ZBrandCard(brand: brand),
              SizedBox(height: ZSizes.spaceBtwSections),

              ///Brands Products
              FutureBuilder(
                future: controller.getBrandProducts(brand.id),
                builder: (context, snapshot) {


                  /// Handle Loading, Error and Empty States
                  const loader = ZVerticalProductShimmer();
                  Widget? widget = ZCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                  if(widget != null) return widget;

                  /// Data Found
                  List<ProductModel> products = snapshot.data!;
                  return ZSortableProducts(products: products);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
