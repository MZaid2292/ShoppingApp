import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/custom_appbar.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/features/personalization/screens/change_name/change_name.dart';
import 'package:e_commerce/features/personalization/screens/edit_profile/widgets/user_profile_with_edit_icons.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: ZAppBar(
        showBackArrow: true,
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: ZPadding.screenPadding,
          child: Column(
            children: [
              ///User Profile With Edit Icon
              UserProfileWithEditIcon(),

              SizedBox(height: ZSizes.spaceBtwSections),

              Divider(),
              SizedBox(height: ZSizes.spaceBtwItems),

              ///Account Settings Heading
              ZSectionHeading(
                title: "Account Settings",
                showActionButton: false,
              ),
              UserDetailRow(
                title: "Name",
                value: controller.user.value.fullName,
                onTap: () => Get.to(() => ChangeNameScreen()),
              ),
              UserDetailRow(
                title: "Username",
                value: controller.user.value.userName,
                onTap: () {},
              ),

              SizedBox(height: ZSizes.spaceBtwItems),

              Divider(),
              SizedBox(height: ZSizes.spaceBtwItems),

              ///Profile Section Headings
              ZSectionHeading(
                title: "Profile Settings",
                showActionButton: false,
              ),
              SizedBox(height: ZSizes.spaceBtwItems),

              ///Profile Settings
              UserDetailRow(title: "User ID", value: controller.user.value.id, onTap: () {}),
              UserDetailRow(
                title: "Email",
                value: controller.user.value.email,
                onTap: () {},
              ),
              UserDetailRow(
                title: "Phone Number",
                value: "+92 ${controller.user.value.phoneNumber}",
                onTap: () {},
              ),
              UserDetailRow(title: "Gender", value: "Male", onTap: () {}),
              SizedBox(height: ZSizes.spaceBtwItems),

              ///Divider
              Divider(),
              SizedBox(height: ZSizes.spaceBtwItems),

              ///Close Account Button
              TextButton(
                onPressed: controller.deleteAccountWarningPopup,
                child: Text(
                  "Close Account",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDetailRow extends StatelessWidget {
  const UserDetailRow({
    super.key,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34,
    required this.onTap,
  });

  final String title, value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: ZSizes.spaceBtwItems / 1.5,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(child: Icon(icon, size: ZSizes.iconSm)),
          ],
        ),
      ),
    );
  }
}
