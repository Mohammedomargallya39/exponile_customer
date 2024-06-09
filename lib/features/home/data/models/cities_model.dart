import '../../domain/entities/cities_entity.dart';

class CitiesModel extends CitiesEntity {
  const CitiesModel({
    super.data,
    required super.message,
    required super.success,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] is String) {
      return CitiesModel(
        success: json['success'],
        message: json['message'],
      );
    } else {

      List<dynamic>? cities = json['data'];
      List<CitiesData>? data;
      if (cities != null) {
        data = cities.map((citiesJson) => CitiesData.fromJson(citiesJson)).toList();
      }

      return CitiesModel(
        success: json['success'],
        message: json['message'],
        data: data,
      );
    }
  }
}
