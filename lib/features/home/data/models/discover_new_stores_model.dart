import '../../domain/entities/discover_new_store_entity.dart';

class DiscoverNewStoresModel extends DiscoverNewStoresEntity {
  const DiscoverNewStoresModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory DiscoverNewStoresModel.fromJson(Map<String, dynamic> json) {
    return DiscoverNewStoresModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
