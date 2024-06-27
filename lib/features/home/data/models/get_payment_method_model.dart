import '../../domain/entities/get_payment_method_entity.dart';

class GetPaymentMethodModel extends GetPaymentMethodEntity {
  const GetPaymentMethodModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory GetPaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return GetPaymentMethodModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
