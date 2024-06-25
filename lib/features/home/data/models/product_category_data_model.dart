import '../../domain/entities/product_category_details_entity.dart';

class ProductCategoryDetailsModel extends ProductCategoryDetailsEntity {
  const ProductCategoryDetailsModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory ProductCategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryDetailsModel(
      data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      message: json['message'],
      success: json['success'],
    );
  }
}
