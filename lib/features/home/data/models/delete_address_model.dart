import '../../domain/entities/delete_address_entity.dart';

class DeleteAddressModel extends DeleteAddressEntity {
  const DeleteAddressModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory DeleteAddressModel.fromJson(Map<String, dynamic> json) {
    return DeleteAddressModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
