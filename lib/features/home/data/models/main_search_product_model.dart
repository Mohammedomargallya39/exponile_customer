import '../../domain/entities/main_search_entity.dart';

class MainSearchProductModel extends MainSearchProductEntity {
  const MainSearchProductModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory MainSearchProductModel.fromJson(Map<String, dynamic> json) {
    return MainSearchProductModel(
      success: json['success'],
      message: json['message'],
      data: List<ProductData>.from(json["data"].map((x) => ProductData.fromJson(x))),
    );
  }
}
