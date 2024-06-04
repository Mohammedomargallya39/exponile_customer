import '../../domain/entities/add_to_cart_entity.dart';

class AddToCartModel extends AddToCartEntity {
  const AddToCartModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory AddToCartModel.fromJson(Map<String, dynamic> json) {
    return AddToCartModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
