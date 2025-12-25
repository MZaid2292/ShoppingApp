

import 'package:e_commerce/features/authetication/screens/forget_password/forget_password.dart';
import 'package:e_commerce/features/authetication/screens/login_screen/login.dart';
import 'package:e_commerce/features/authetication/screens/onboarding/on_boarding.dart';
import 'package:e_commerce/features/authetication/screens/signup/signup.dart';
import 'package:e_commerce/features/authetication/screens/signup/verify_email.dart';
import 'package:e_commerce/features/personalization/screens/addresses/add_address.dart';
import 'package:e_commerce/features/personalization/screens/edit_profile/edit_profile.dart';
import 'package:e_commerce/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce/features/shop/screen/cart/cart.dart';
import 'package:e_commerce/features/shop/screen/checkout/checkout.dart';
import 'package:e_commerce/features/shop/screen/orders/order.dart';
import 'package:e_commerce/features/shop/screen/store_screen/store.dart';
import 'package:e_commerce/features/shop/screen/wishlist/wishlist.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:get/get.dart';

class ZAppRoutes{

  static final screens = [
    
    GetPage(name: ZRoutes.home, page: () => NavigationMenu()),
    GetPage(name: ZRoutes.store, page: () => StoreScreen()),
    GetPage(name: ZRoutes.wishlist, page: () => WishlistScreen()),
    GetPage(name: ZRoutes.profile, page: () => ProfileScreen()),
    GetPage(name: ZRoutes.order, page: () => OrdersScreen()),
    GetPage(name: ZRoutes.checkout, page: () => CheckoutScreen()),
    GetPage(name: ZRoutes.cart, page: () => CartScreen()),
    GetPage(name: ZRoutes.editProfile, page: () => EditProfileScreen()),
    GetPage(name: ZRoutes.userAddress, page: () => AddressScreen()),
    GetPage(name: ZRoutes.signup, page: () => SignupScreen()),
    GetPage(name: ZRoutes.verifyEmail, page: () => VerifyEmailScreen()),
    GetPage(name: ZRoutes.signIn, page: () => LoginScreen()),
    GetPage(name: ZRoutes.forgetPassword, page: () => ForgetPasswordScreen()),
    GetPage(name: ZRoutes.onBoarding, page: () => OnBoardingScreen()),


  ];
}