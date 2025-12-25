import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/data/repositories/order/order_repository.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:e_commerce/features/shop/models/order_model.dart';
import 'package:e_commerce/utils/constant/enums.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/screens/success_screen.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constant/images.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables

  final cartController = CartController.instance;
  final checkoutController = CheckoutController.instance;
  final addressController = AddressController.instance;
  final _repository = Get.put(OrderRepository());

  /// Process the order
  Future<void> processOrder(double totalAmount) async {
    try {
      // Start Loading
      ZFullScreenLoader.openLoadingDialog("Processing your order...");

      // Check user existence
      String userId = AuthenticationRepository.instance.currentUser!.uid;
      if (userId.isEmpty) return;

      // Check address is exists or not
      if(AddressController.instance.selectedAddress.value.id.isEmpty){
        ZSnackBarHelpers.warningSnackBar(title: "Address not selected",message: "Please select address");
        return;
      }

      // Create order model
      OrderModel order = OrderModel(
        id: UniqueKey().toString(),
        status: OrderStatus.pending,
        items: cartController.cartItems.toList(),
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        userId: userId,
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
      );

      // Save Order
      await _repository.saveOrder(order);

      // Update Cart
      cartController.clearCart();

      // Show Success Screen
      Get.to(
        () => SuccessScreen(
          title: "Payment Success!",
          subTitle: "Your item will be shipped soon!",
          image: ZImages.successfulPaymentIcon,
          onTap: () => Get.offAll(() => NavigationMenu()),
        ),
      );
    } catch (e) {
      ZSnackBarHelpers.errorSnackBar(
        title: "Order Failed!",
        message: e.toString(),
      );
    }
  }

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final orders = await _repository.fetchUserOrders();
      return orders;
    } catch (e) {
      ZSnackBarHelpers.errorSnackBar(title: "Failed!", message: e.toString());
      return [];
    }
  }
}
