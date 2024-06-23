import '../../domain/entities/payment_order_data_entity.dart';

class PaymentOrderDataModel extends PaymentOrderDataEntity {
  const PaymentOrderDataModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory PaymentOrderDataModel.fromJson(Map<String, dynamic> json) {
    return PaymentOrderDataModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json['message'],
      success: json['success'],
    );
  }
}
