import '../../domain/entities/reciept_entity.dart';

class ReceiptModel extends ReceiptEntity {
  const ReceiptModel({
    required super.userAddress,
    required super.paymentMethod,
    required super.customer,
    required super.orders,
    required super.purchaseOrderNumber,
    required super.date,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      userAddress: json["userAddress"] == null ? null : UserAddress.fromJson(json["userAddress"]),
      paymentMethod: json["paymentMethod"] == null ? null : PaymentMethod.fromJson(json["paymentMethod"]),
      customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
      orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      purchaseOrderNumber: json["purchase_order_number"],
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
    );
  }
}
