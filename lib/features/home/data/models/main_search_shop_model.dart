import '../../domain/entities/main_search_shop_entity.dart';

class MainSearchShopModel extends MainSearchShopEntity {
  const MainSearchShopModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory MainSearchShopModel.fromJson(Map<String, dynamic> json) {
    return MainSearchShopModel(
      success: json['success'],
      message: json['message'],
      data: List<StoresData>.from(json["data"].map((x) => StoresData.fromJson(x))),
    );
  }
}
