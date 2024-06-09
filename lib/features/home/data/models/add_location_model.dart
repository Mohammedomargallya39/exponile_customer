import '../../domain/entities/add_address_entity.dart';

class AddLocationModel extends AddLocationEntity {
  const AddLocationModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory AddLocationModel.fromJson(Map<String, dynamic> json) {
    return AddLocationModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
