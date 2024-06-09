import 'package:equatable/equatable.dart';

class CitiesEntity extends Equatable {
  final int? success;
  final String? message;
  final List<CitiesData>? data;

  const CitiesEntity({
    required this.success,
    required this.message,
    required this.data
  });

  @override
  List<Object?> get props => [
  ];
}


class CitiesData extends Equatable {

  final int? id;
  final String? name;
  final String? khazenlyCityName;

  const CitiesData({
    required this.id,
    this.name,
    this.khazenlyCityName,
  });

  factory CitiesData.fromJson(Map<String,dynamic> json){
    return CitiesData(
      id: json['id'],
      name: json['name'],
      khazenlyCityName: json['khazenly_cities_name'],
    );
  }

  @override
  List<Object?> get props => [
  ];
}
