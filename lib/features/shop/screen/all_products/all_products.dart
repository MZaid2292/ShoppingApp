import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/products/all_products_controller.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/products/sortable_products.dart';
import '../../models/product_model.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key, this.futureMethod, this.query, required this.title});


  final String title;
  final Future<List<ProductModel>>? futureMethod;
  final Query? query;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());

    return Scaffold(
      appBar: ZAppBar(
        showBackArrow: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                const loader = ZVerticalProductShimmer();
                final widget = ZCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                if(widget != null) return widget;


                List<ProductModel> products = snapshot.data!;
                return ZSortableProducts(products: products);
              },
          ),
        ),
      ),
    );
  }
}


