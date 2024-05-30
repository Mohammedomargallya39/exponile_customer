import '../../domain/entities/forget_password_entity.dart';

class ForgetPasswordModel extends ForgetPasswordEntity {
  const ForgetPasswordModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
}
}
