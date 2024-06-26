import '../../domain/entities/update_cart_product_entity.dart';

class UpdateCartProductModel extends UpdateCartProductEntity {
  const UpdateCartProductModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory UpdateCartProductModel.fromJson(Map<String, dynamic> json) {
    return UpdateCartProductModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
