
import '../../domain/entities/add_offer_to_cart_entity.dart';

class AddOfferToCartModel extends AddOfferToCartEntity {
  const AddOfferToCartModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory AddOfferToCartModel.fromJson(Map<String, dynamic> json) {
    return AddOfferToCartModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
