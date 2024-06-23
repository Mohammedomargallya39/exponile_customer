import '../../domain/entities/cancel_order_entity.dart';

class CancelOrderModel extends CancelOrderEntity {
  const CancelOrderModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory CancelOrderModel.fromJson(Map<String, dynamic> json) {
    return CancelOrderModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
