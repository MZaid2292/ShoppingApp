import 'package:e_commerce/common/widgets/products/products_card/product_card_vertical.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/shop/controllers/products/all_products_controller.dart';
import '../../../utils/constant/sized.dart';
import '../layouts/grid_layout.dart';

class ZSortableProducts extends StatelessWidget {
  const ZSortableProducts({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);

    return Column(
      children: [
        ///Filter Field
        DropdownButtonFormField(
          initialValue: controller.selectedSortOption.value,
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) => controller.sortProducts(value!),
          items: ["Name", "Lower Price", "Higher Price", "Sale", "Newest"].map((
            filter,
          ) {
            return DropdownMenuItem(value: filter, child: Text(filter));
          }).toList(),
        ),
        SizedBox(height: ZSizes.spaceBtwSections),

        ///Products
        Obx(
          () => ZGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (context, index) =>
                ZProductCardVertical(product: controller.products[index]),
          ),
        ),
      ],
    );
  }
}
