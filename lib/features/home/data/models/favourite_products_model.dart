import '../../domain/entities/favourite_products_entity.dart';

class FavouriteProductsModel extends FavouriteProductsEntity {
  const FavouriteProductsModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory FavouriteProductsModel.fromJson(Map<String, dynamic> json) {
    return FavouriteProductsModel(
      data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      message: json['message'],
      success: json['success'],
    );
  }
}
