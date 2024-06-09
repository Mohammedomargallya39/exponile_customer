import '../../domain/entities/areas_entity.dart';
class AreasModel extends AreasEntity {
  const AreasModel({
    super.data,
    required super.message,
    required super.success,
  });

  factory AreasModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] is String) {
      return AreasModel(
        success: json['success'],
        message: json['message'],
      );
    } else {

      List<dynamic>? cities = json['data'];
      List<AreasData>? data;
      if (cities != null) {
        data = cities.map((citiesJson) => AreasData.fromJson(citiesJson)).toList();
      }

      return AreasModel(
        success: json['success'],
        message: json['message'],
        data: data,
      );
    }
  }
}
