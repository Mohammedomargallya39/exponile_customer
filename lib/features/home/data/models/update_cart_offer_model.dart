import '../../domain/entities/update_cart_offer_entity.dart';

class UpdateCartOfferModel extends UpdateCartOfferEntity {
  const UpdateCartOfferModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory UpdateCartOfferModel.fromJson(Map<String, dynamic> json) {
    return UpdateCartOfferModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
