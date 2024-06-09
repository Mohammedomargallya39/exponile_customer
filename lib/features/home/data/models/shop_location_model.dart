
import '../../domain/entities/shop_location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    super.data,
    required super.message,
    required super.success,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] is String) {
      return LocationModel(
        success: json['success'],
        message: json['message'],
      );
    } else {

      List<dynamic>? shopLocation = json['data'];
      List<ShopLocationData>? data;
      if (shopLocation != null) {
        data = shopLocation.map((shopLocationJson) => ShopLocationData.fromJson(shopLocationJson)).toList();
      }

      return LocationModel(
        success: json['success'],
        message: json['message'],
        data: data!,
      );
    }
  }
}
