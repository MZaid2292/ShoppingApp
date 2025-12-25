import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/features/personalization/screens/addresses/add_address.dart';
import 'package:e_commerce/features/personalization/screens/profile/widgets/profile_primary_header.dart';
import 'package:e_commerce/features/personalization/screens/profile/widgets/settings_menu_tile.dart';
import 'package:e_commerce/features/personalization/screens/profile/widgets/user_profile_tile.dart';
import 'package:e_commerce/features/shop/screen/cart/cart.dart';
import 'package:e_commerce/features/shop/screen/orders/order.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Primary Header
            ZProfilePrimaryHeader(),
        
            Padding(
              padding: const EdgeInsets.all(ZSizes.defaultSpace),
              child: Column(
                children: [
                  ///User profile Details
                  UserProfileTile(),
        
                  SizedBox(height: ZSizes.spaceBtwItems),
        
                  ///Account settings heading
                  ZSectionHeading(
                    title: "Account Settings",
                    showActionButton: false,
                  ),
        
                  ///Settings Menu
                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My Addresses",
                    subTitle: "Set shopping delivery addresses",
                    onTap: ()=>Get.to(()=>AddressScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: "My Cart",
                    subTitle: "Add, remove products and move to checkout",
                    onTap: () => Get.to(() => CartScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: "My Orders",
                    subTitle: "In-progress and Completed Orders",
                    onTap: ()=>Get.to(()=>OrdersScreen()),
                  ),

                  SizedBox(height: ZSizes.spaceBtwSections),

                  ///Logout
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: AuthenticationRepository.instance.logout,
                        child: Text("Logout")
                    ),
                  ),

                  SizedBox(height: ZSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
