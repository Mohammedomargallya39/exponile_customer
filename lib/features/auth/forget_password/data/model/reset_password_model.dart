
import '../../domain/entities/reset_password_entity.dart';

class ResetPasswordModel extends ResetPasswordEntity {
  const ResetPasswordModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
}
}
