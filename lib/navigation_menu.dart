import 'package:e_commerce/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce/features/shop/screen/home_screen/home.dart';
import 'package:e_commerce/features/shop/screen/store_screen/store.dart';
import 'package:e_commerce/features/shop/screen/wishlist/wishlist.dart';
import 'package:e_commerce/utils/constant/colors.dart';
import 'package:e_commerce/utils/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    bool dark = ZHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 0,
          backgroundColor: dark ? ZColors.dark : ZColors.light,
          indicatorColor: dark
              ? ZColors.light.withValues(alpha: 0.1)
              : ZColors.dark.withValues(alpha: 0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
          },
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

//For State Management
class NavigationController extends GetxController {

  static NavigationController get instance => Get.find();

  RxInt selectedIndex = 0.obs;

  List<Widget> screens = [
    HomeScreen(),
    StoreScreen(),
    WishlistScreen(),
    ProfileScreen()
  ];
}
