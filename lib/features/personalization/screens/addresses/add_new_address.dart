import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/button/zelevated_button.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      ///----------[AppBar]-------------
      appBar: ZAppBar(
        showBackArrow: true,
        title: Text(
          "Add New Address",
          style: Theme.of(context).textTheme.headlineMedium)),

      ///----------[Body]-------------
      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Form(
            key: controller.addressFormKey,
            child: Column(
             children: [
            
               ///Name
               TextFormField(
                 controller: controller.name,
                   validator: (value) => ZValidator.validateEmptyText("Name", value),
                 decoration: InputDecoration(
                   prefixIcon: Icon(Iconsax.user),
                   labelText: "Name")),
               SizedBox(height: ZSizes.spaceBtwInputFields),
            
               ///Phone Number
               TextFormField(
                 controller: controller.phoneNumber,
                   validator: (value) => ZValidator.validateEmptyText("Phone Number", value),
                   decoration: InputDecoration(
                       prefixIcon: Icon(Iconsax.mobile),
                       labelText: "Phone Number")),
               SizedBox(height: ZSizes.spaceBtwInputFields),
            
            
               Row(
                 children: [
            
                   ///Street
                   Expanded(
                     child: TextFormField(
                       controller: controller.street,
                         validator: (value) => ZValidator.validateEmptyText("Street", value),
                         decoration: InputDecoration(
                             prefixIcon: Icon(Iconsax.building_31),
                             labelText: "Street"))),
                   SizedBox(width: ZSizes.spaceBtwInputFields),
            
                  ///Postal Code
                   Expanded(
                     child: TextFormField(
                       controller: controller.postalCode,
                         validator: (value) => ZValidator.validateEmptyText("Postal Code", value),
                         decoration: InputDecoration(
                             prefixIcon: Icon(Iconsax.code),
                             labelText: "Postal Code")),
                   )]),
               SizedBox(height: ZSizes.spaceBtwInputFields),
            
               Row(
                 children: [
            
                   ///City
                   Expanded(
                     child: TextFormField(
                       controller: controller.city,
                         validator: (value) => ZValidator.validateEmptyText("City", value),
                         decoration: InputDecoration(
                             prefixIcon: Icon(Iconsax.building),
                             labelText: "City"))),
                   SizedBox(width: ZSizes.spaceBtwInputFields),
            
            
                   ///State
                   Expanded(
                     child: TextFormField(
                       controller: controller.state,
                         validator: (value) => ZValidator.validateEmptyText("State", value),
                         decoration: InputDecoration(
                             prefixIcon: Icon(Iconsax.activity),
                             labelText: "State"))
                   )]),
               SizedBox(height: ZSizes.spaceBtwInputFields),
            
               ///Country
               TextFormField(
                 controller: controller.country,
                   validator: (value) => ZValidator.validateEmptyText("Country", value),
                   decoration: InputDecoration(
                       prefixIcon: Icon(Iconsax.global),
                       labelText: "Country")),
               SizedBox(height: ZSizes.spaceBtwInputFields),
            
               ///Save Button
               ZElevatedButton(onPressed: controller.addNewAddress, child: Text("Save")),
               SizedBox(height: ZSizes.spaceBtwSections),
             ],
            ),
          ),
        ),
      ),
    );
  }
}
