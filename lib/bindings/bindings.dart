import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/features/shop/controllers/products/variation_controller.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

import '../features/shop/controllers/checkout/checkout_controller.dart';

class ZBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(CheckoutController());
    Get.put(AddressController());


  }


}