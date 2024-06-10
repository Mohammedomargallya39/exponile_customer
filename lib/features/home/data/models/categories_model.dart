import '../../domain/entities/categories_entity.dart';

class CategoriesModel extends CategoriesEntity {
  const CategoriesModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
