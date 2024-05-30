import '../../domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel({
    required super.message,
    required super.success,
    super.data
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    if(json['success'] ==1) {
      return RegisterModel(
      message: json['message'],
      success: json['success'],
    );
    } else {
      return RegisterModel(
        message: json['message'],
        success: json['success'],
        data: RegisterData.fromJson(json['data']),
      );
    }
  }
}
