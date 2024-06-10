import '../../domain/entities/best_sellers_store_entity.dart';

class BestSellersStoresModel extends BestSellersStoresEntity {
  const BestSellersStoresModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory BestSellersStoresModel.fromJson(Map<String, dynamic> json) {
    return BestSellersStoresModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
