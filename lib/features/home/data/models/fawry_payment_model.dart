import '../../domain/entities/fawry_payment_entity.dart';

class FawryPaymentModel extends FawryPaymentEntity {
  const FawryPaymentModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory FawryPaymentModel.fromJson(Map<String, dynamic> json) {
    return FawryPaymentModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
