import '../../domain/entities/otp_entity.dart';

class SendOTPModel extends OTPEntity {
  const SendOTPModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory SendOTPModel.fromJson(Map<String, dynamic> json) {
    return SendOTPModel(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
}
}
