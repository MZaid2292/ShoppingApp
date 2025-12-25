import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/button/zelevated_button.dart';
import 'package:e_commerce/features/personalization/controllers/change_name_controller.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/constant/texts.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeNameController());
    return Scaffold(

      /// [AppBar]
      appBar: ZAppBar(showBackArrow: true, title: Text("Update Name",style: Theme.of(context).textTheme.headlineSmall)),

      /// [Body]
      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///[Text] - Headings
              Text("Update your name to keep your profile accurate and personalized",
              style: Theme.of(context).textTheme.labelMedium),
              SizedBox(height: ZSizes.spaceBtwSections),

              ///Form
              Form(
                key: controller.updateUserFormKey,
                  child: Column(
                    children: [

                      ///First Name
                      TextFormField(
                        controller: controller.firstName,
                        validator: (value) => ZValidator.validateEmptyText("First Name", value),
                        decoration: InputDecoration(
                          labelText: ZTexts.firstName,
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                      SizedBox(height: ZSizes.spaceBtwInputFields),

                      ///Last Name
                      TextFormField(
                        controller: controller.lastName,
                        validator: (value) => ZValidator.validateEmptyText("Last Name", value),
                        decoration: InputDecoration(
                          labelText: ZTexts.lastName,
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                    ],
              )),

              SizedBox(height: ZSizes.spaceBtwSections),

              ZElevatedButton(onPressed: controller.updateUserName, child: Text("Save"))
            ],
          ),

        ),
      ),
    );
  }
}
