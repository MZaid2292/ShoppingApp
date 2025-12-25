import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce/common/widgets/products/products_card/product_card_vertical.dart';
import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/products/favourite_controller.dart';

import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../utils/constant/images.dart';
import '../../models/product_model.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///AppBar
      appBar: ZAppBar(
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          ZCircularIcon(
            icon: Iconsax.add,
            onPressed: () =>
                NavigationController.instance.selectedIndex.value = 0,
          ),
        ],
      ),

      ///Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ZSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                future: FavouriteController.instance.getFavouriteProduct(),
                builder: (context, snapshot) {

                  final nothingFound = ZAnimationLoader(
                      text: "Wishlist is Empty....",
                    animation: ZImages.pencilAnimation,
                    showActionButton: true,
                    actionText: "Let's add some",
                    onActionPressed: () => NavigationController.instance.selectedIndex.value = 0,


                  );
                  const loader = ZVerticalProductShimmer(itemCount: 6);

                  /// Handle Empty Data, Loading and Error
                  final widget = ZCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader, nothingFound: nothingFound);
                  if(widget != null) return widget;

                  /// Products Found
                  List<ProductModel> products = snapshot.data!;
                  return ZGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) => ZProductCardVertical(product: products[index]),
                  );
                },
            ),
          )
        ),
      ),
    );
  }
}
