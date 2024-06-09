import 'package:equatable/equatable.dart';

class AreasEntity extends Equatable {
  final int? success;
  final String? message;
  final List<AreasData>? data;

  const AreasEntity({
    required this.success,
    required this.message,
    required this.data
  });

  @override
  List<Object?> get props => [
  ];
}


class AreasData extends Equatable {

  final int? id;
  final String? name;
  final int? cityId;
  final GetCity? getCity;

  const AreasData({
    required this.id,
    this.name,
    this.cityId,
    this.getCity,
  });

  factory AreasData.fromJson(Map<String,dynamic> json){
    return AreasData(
      id: json['id'],
      name: json['name'],
      cityId: json['city'],
      getCity: GetCity.fromJson(json['get_city'])
    );
  }

  @override
  List<Object?> get props => [
  ];
}


class GetCity extends Equatable {

  final int? id;
  final String? name;
  final String? govID;
  final String? govDeliveryHubCode;
  final String? govPickUpHubCode;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;
  final String? khazenlyCityName;

  const GetCity({
    required this.id,
    this.name,
    this.khazenlyCityName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.govDeliveryHubCode,
    this.govID,
    this.govPickUpHubCode,
  });

  factory GetCity.fromJson(Map<String,dynamic> json){
    return GetCity(
      id: json['id'],
      name: json['name'],
      govPickUpHubCode: json['gov_pickup_hub_code'],
      govDeliveryHubCode: json['gov_delivery_hub_code'],
      govID: json['gov_id'],
      deletedAt: json['deleted_at'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      khazenlyCityName: json['khazenly_city_name'],
    );
  }

  @override
  List<Object?> get props => [
  ];
}

