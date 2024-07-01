import '../../domain/entities/order_reciept_entity.dart';

class OrderReceiptModel extends OrderReceiptEntity {
  const OrderReceiptModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory OrderReceiptModel.fromJson(Map<String, dynamic> json) {
    return OrderReceiptModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
