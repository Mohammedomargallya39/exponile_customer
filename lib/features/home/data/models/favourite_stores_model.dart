import '../../domain/entities/favourite_stores_entity.dart';

class FavouriteStoresModel extends FavouriteStoresEntity {
  const FavouriteStoresModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory FavouriteStoresModel.fromJson(Map<String, dynamic> json) {
    return FavouriteStoresModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
