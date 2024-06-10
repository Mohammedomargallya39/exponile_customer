import '../../domain/entities/landing_entity.dart';

class LandingModel extends LandingEntity {
  const LandingModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory LandingModel.fromJson(Map<String, dynamic> json) {
    return LandingModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
