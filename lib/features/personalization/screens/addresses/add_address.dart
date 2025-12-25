import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/shimmer/address_shimmer.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';

import 'package:e_commerce/features/personalization/screens/addresses/add_new_address.dart';
import 'package:e_commerce/features/personalization/screens/addresses/widgets/single_address.dart';
import 'package:e_commerce/utils/constant/colors.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      ///--------[AppBar]---------
      appBar: ZAppBar(
        showBackArrow: true,
        title: Text(
          "Addresses",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      ///----------[Body]-------------
      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
                future: controller.getAllAddresses(),
                builder: (context, snapshot) {
            
            
                  /// Handle Error, Loading, Empty
                  const loader = ZAddressesShimmer();
                  final widget = ZCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                  if(widget != null) return widget;
            
                  /// Data Found - Addresses Found
                  List<AddressModel> addresses = snapshot.data!;
                  return ListView.separated(
                    shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: addresses.length,
                      separatorBuilder:(context, index) => SizedBox(height: ZSizes.spaceBtwItems),
                      itemBuilder: (context, index) {
                        return ZSingleAddress(
                          onTap: () => controller.selectAddress(addresses[index]),
                          address:addresses[index]
            
                        );
                      },
            
            
                  );
                  
                  
                },
            ),
          ),
        ),
      ),

      ///----------[Floating Action Button]----------------
      floatingActionButton: FloatingActionButton(
          onPressed: ()=>Get.to(()=>AddNewAddressScreen()),
        backgroundColor: ZColors.primaryColor,
        child: Icon(Iconsax.add,color: Colors.white),

      ),
    );
  }
}


