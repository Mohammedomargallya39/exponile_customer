import '../../domain/entities/product_data_entity.dart';

class ProductDataModel extends ProductDataEntity {
  const ProductDataModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
