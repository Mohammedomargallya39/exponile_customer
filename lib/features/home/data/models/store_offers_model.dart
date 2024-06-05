
import '../../domain/entities/store_offers_entity.dart';

class StoreOffersModel extends StoreOffersEntity {
  const StoreOffersModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory StoreOffersModel.fromJson(Map<String, dynamic> json) {
    return StoreOffersModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
