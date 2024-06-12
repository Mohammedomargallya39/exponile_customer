import '../../domain/entities/hot_deals_entity.dart';

class HotDealsModel extends HotDealsEntity {
  const HotDealsModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory HotDealsModel.fromJson(Map<String, dynamic> json) {
    return HotDealsModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
