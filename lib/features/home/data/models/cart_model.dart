import '../../domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
