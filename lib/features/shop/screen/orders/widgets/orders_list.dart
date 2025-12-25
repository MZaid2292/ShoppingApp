import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce/features/shop/controllers/orders/order_controller.dart';
import 'package:e_commerce/features/shop/models/order_model.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constant/colors.dart';
import 'package:e_commerce/utils/constant/images.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ZOrdersListItems extends StatelessWidget {
  const ZOrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (context, snapshot) {

          /// Handle Error, Loading, Empty State
          final nothingFound = ZAnimationLoader(
              text: "No order yet!",
              showActionButton: true,
            actionText: "Let's fill it",
            animation: ZImages.pencilAnimation,
            onActionPressed: () => Get.offAll(() => NavigationMenu()),
          );
          final widget = ZCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,nothingFound: nothingFound);
          if(widget != null) return widget;

          List<OrderModel> orders = snapshot.data!;
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: ZSizes.spaceBtwItems),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              OrderModel order = orders[index];
              return ZRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? ZColors.dark : ZColors.light,
                padding: EdgeInsets.all(ZSizes.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    ///1st - Row
                    Row(
                      children: [
                        ///Ship Icon
                        Icon(Iconsax.ship),
                        SizedBox(width: ZSizes.spaceBtwItems / 2),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ///Title
                              Text(order.orderStatusText,style: Theme.of(context).textTheme.bodyLarge!.apply(color: ZColors.primaryColor,fontWeightDelta: 1)),

                              ///Date
                              Text(order.formattedOrderDate,style: Theme.of(context).textTheme.headlineSmall,)
                            ],
                          ),
                        ),

                        IconButton(onPressed: (){}, icon: Icon(Iconsax.arrow_right_34,size: ZSizes.iconSm))
                      ],
                    ),
                    SizedBox(height: ZSizes.spaceBtwItems),


                    /// 2nd - Row
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [

                              ///Tag Icon
                              Icon(Iconsax.tag),
                              SizedBox(width: ZSizes.spaceBtwItems / 2),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    ///Order
                                    Text("order",style: Theme.of(context).textTheme.labelMedium),

                                    ///Order id
                                    Text(order.id,style: Theme.of(context).textTheme.titleMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Row(
                            children: [

                              ///Calendar Icon
                              Icon(Iconsax.calendar),
                              SizedBox(width: ZSizes.spaceBtwItems / 2),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    ///Shipping
                                    Text("Shipping Date",style: Theme.of(context).textTheme.labelMedium),

                                    ///Shipping Date
                                    Text(order.formattedDeliveryDate,style: Theme.of(context).textTheme.titleMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ],
                ),

              );
            },
          );
        },
    );
  }
}
