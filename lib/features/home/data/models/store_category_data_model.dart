import '../../domain/entities/store_category_details_entity.dart';

class StoreCategoryDetailsModel extends StoreCategoryDetailsEntity {
  const StoreCategoryDetailsModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory StoreCategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    return StoreCategoryDetailsModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
