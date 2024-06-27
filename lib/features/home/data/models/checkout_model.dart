import '../../domain/entities/checkout_entity.dart';

class CheckoutModel extends CheckoutEntity {
  const CheckoutModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
