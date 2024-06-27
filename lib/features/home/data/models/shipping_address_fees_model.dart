import '../../domain/entities/shipping_address_entity.dart';

class GetShippingAddressFeesModel extends GetShippingAddressFeesEntity {
  const GetShippingAddressFeesModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory GetShippingAddressFeesModel.fromJson(Map<String, dynamic> json) {
    return GetShippingAddressFeesModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
