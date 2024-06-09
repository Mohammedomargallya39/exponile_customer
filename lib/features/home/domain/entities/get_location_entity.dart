import 'package:equatable/equatable.dart';

class GetLocationEntity extends Equatable {
  final int? success;
  final String? message;
  final LocationData? data;

  const GetLocationEntity({
    required this.success,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
    success,
    message,
    data,
      ];
}


class LocationData extends Equatable {

  final int? governorateID;
  final dynamic areaID;
  final String? governorateName;
  final String? areaName;
  final String? fullAddress;
  final String? lat;
  final String? lng;
  final String? street;
  final String? postcode;
  final String? houseNumber;

  const LocationData({
    required this.governorateID,
    required this.areaID,
    required this.governorateName,
    required this.areaName,
    required this.fullAddress,
    required this.lat,
    required this.lng,
    required this.street,
    required this.postcode,
    required this.houseNumber,
  });

  factory LocationData.fromJson(Map<String,dynamic> json){
    return LocationData(
      governorateID: json['governorate'],
      areaID: json['area'],
      governorateName: json['governorate_name'],
      areaName: json['area_name'],
      fullAddress: json['full_address'],
      lat: json['lat'],
      lng: json['lng'],
      street: json['street'],
      postcode: json['postcode'],
      houseNumber: json['housenumber'],
    );
  }

  @override
  List<Object?> get props => [
    governorateID,
    areaID,
    governorateName,
    areaName,
    fullAddress,
    lat,
    lng,
    street,
    postcode,
    houseNumber,
  ];
}


