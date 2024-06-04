
import '../../domain/entities/add_favourite_entity.dart';

class AddFavouriteModel extends AddFavouriteEntity {
  const AddFavouriteModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory AddFavouriteModel.fromJson(Map<String, dynamic> json) {
    return AddFavouriteModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
