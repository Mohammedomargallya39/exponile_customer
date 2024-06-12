import '../../domain/entities/top_categories_entity.dart';

class TopCategoriesModel extends TopCategoriesEntity {
  TopCategoriesModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory TopCategoriesModel.fromJson(Map<String, dynamic> json) {
    return TopCategoriesModel(
      data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
      message: json['message'],
      success: json['success'],
    );
  }
}
