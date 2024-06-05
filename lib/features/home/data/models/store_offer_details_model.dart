
import '../../domain/entities/store_offer_details_entity.dart';

class StoreOfferDetailsModel extends StoreOfferDetailsEntity {
  const StoreOfferDetailsModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory StoreOfferDetailsModel.fromJson(Map<String, dynamic> json) {
    return StoreOfferDetailsModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
