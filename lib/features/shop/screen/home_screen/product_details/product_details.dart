import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/button/zelevated_button.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/screen/home_screen/product_details/widgets/bottom_add_to_cart.dart';
import 'package:e_commerce/features/shop/screen/home_screen/product_details/widgets/product_attributes.dart';
import 'package:e_commerce/features/shop/screen/home_screen/product_details/widgets/product_meta_data.dart';
import 'package:e_commerce/features/shop/screen/home_screen/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:e_commerce/utils/constant/enums.dart';
import 'package:e_commerce/utils/constant/sized.dart';

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../models/product_model.dart';




class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      ///---------[Body]----------------
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///------------[Product Image with Slider]---------
            ZProductThumbnailAndSlider(product: product),

            ///---------[Product Details]---------------
           Padding(
             padding: ZPadding.screenPadding,
             child: Column(
               children: [
                 ///Price Title Stock And Brand
                 ZProductMetaData(product: product),

                 ///Attributes
                 if(product.productType == ProductType.variable.toString())...[
                   ZProductAttributes(product: product),
                   SizedBox(height: ZSizes.spaceBtwSections),
                 ],



                 ///Checkout Button
                 ZElevatedButton(onPressed: () => CartController.instance.checkout(product),child: Text("Checkout")),
                 SizedBox(height: ZSizes.spaceBtwSections),


                 ///Description
                 ZSectionHeading(title: "Description",showActionButton: false),
                 SizedBox(height: ZSizes.spaceBtwItems),

                 ReadMoreText(
                   product.description ?? "",
                   trimLines: 2,
                   trimMode: TrimMode.Line,
                   trimCollapsedText: " Show more",
                   trimExpandedText: " Less",
                   moreStyle: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w800),
                   lessStyle: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w800),
                 ),
                 SizedBox(height: ZSizes.spaceBtwSections),
               ],
             ),
           ),
          ],
        ),
      ),


      ///----------[Bottom Navigation]------------
      bottomNavigationBar: ZBottomAddToCart(product: product),
    );
  }
}


