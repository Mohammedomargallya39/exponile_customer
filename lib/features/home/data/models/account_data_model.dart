
import '../../domain/entities/account_data_entity.dart';

class AccountDataModel extends AccountDataEntity {
  const AccountDataModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory AccountDataModel.fromJson(Map<String, dynamic> json) {
    return AccountDataModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
