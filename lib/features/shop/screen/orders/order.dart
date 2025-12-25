import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/features/shop/screen/orders/widgets/orders_list.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZAppBar(showBackArrow: true,title: Text("My Orders",style: Theme.of(context).textTheme.headlineMedium)),
      
      
      body: Padding(
          padding: ZPadding.screenPadding,
        child: ZOrdersListItems(),
      ),
    );
  }
}
