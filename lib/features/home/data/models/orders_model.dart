import '../../domain/entities/orders_entity.dart';

class OrdersModel extends OrdersEntity {
  const OrdersModel({
    required super.message,
    required super.success,
    required super.data,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      message: json["message"],
      success: json["success"],
      data: Data.fromJson(json["data"]),
    );
  }
}
