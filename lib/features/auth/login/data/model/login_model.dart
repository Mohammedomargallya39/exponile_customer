import '../../domain/entities/log_in_entity.dart';

class LogInModel extends LoginEntity {
  const LogInModel({
    super.data,
    required super.message,
    required super.success,
  });

  factory LogInModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] == 0) {
      return LogInModel(
        success: json['success'],
        message: json['message'],
      );
    } else {
      return LogInModel(
        success: json['success'],
        message: json['message'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
