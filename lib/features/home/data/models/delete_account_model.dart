
import '../../domain/entities/delete_account_entity.dart';

class DeleteAccountModel extends DeleteAccountEntity {
  const DeleteAccountModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) {
    return DeleteAccountModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
