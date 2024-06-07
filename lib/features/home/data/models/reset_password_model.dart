import '../../domain/entities/reset_password_entity.dart';

class ResetPasswordSModel extends ResetPasswordSEntity {
  const ResetPasswordSModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory ResetPasswordSModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordSModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
