import '../../domain/entities/promo_code_entity.dart';

class PromoCodeModel extends PromoCodeEntity {
  const PromoCodeModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
