import '../../domain/entities/order_details_entity.dart';

class OrderDetailsModel extends OrderDetailsEntity {
  const OrderDetailsModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json['message'],
      success: json['success'],
    );
  }
}
