
import 'package:e_commerce/utils/constant/enums.dart';

class PaymentMethodModel{
  String name;
  String image;
  PaymentMethods paymentMethod;

  PaymentMethodModel({
    required this.name,
    required this.image,
    required this.paymentMethod
});

  static PaymentMethodModel empty() => PaymentMethodModel(name: "", image: "",paymentMethod: PaymentMethods.creditCard);
}