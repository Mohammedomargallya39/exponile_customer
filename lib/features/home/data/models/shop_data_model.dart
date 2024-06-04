import '../../domain/entities/shop_data_entity.dart';

class ShopDataModel extends ShopDataEntity {
  const ShopDataModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory ShopDataModel.fromJson(Map<String, dynamic> json) {
    return ShopDataModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
