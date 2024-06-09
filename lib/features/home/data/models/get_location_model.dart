import '../../domain/entities/get_location_entity.dart';

class GetLocationModel extends GetLocationEntity {
  const GetLocationModel({
    super.data,
    required super.message,
    required super.success,
  });

  factory GetLocationModel.fromJson(Map<String, dynamic> json) {
    return GetLocationModel(
      success: json['success'],
      message: json['message'],
      data: LocationData.fromJson(json['data']),
    );
  }
}
