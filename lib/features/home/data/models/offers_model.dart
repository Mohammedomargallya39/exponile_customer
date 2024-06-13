import '../../domain/entities/offers_entity.dart';

class OffersModel extends OffersEntity {
  const OffersModel({
    required super.message,
    required super.success,
    required super.data,
  });

  factory OffersModel.fromJson(Map<String, dynamic> json) {
    return OffersModel(
      message: json["message"],
      success: json["success"],
      data: Data.fromJson(json["data"]),
    );
  }
}
