import '../../domain/entities/home_favourite_store_entity.dart';

class HomeFavouriteStoresModel extends HomeFavouriteStoresEntity {
  const HomeFavouriteStoresModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory HomeFavouriteStoresModel.fromJson(Map<String, dynamic> json) {
    return HomeFavouriteStoresModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
