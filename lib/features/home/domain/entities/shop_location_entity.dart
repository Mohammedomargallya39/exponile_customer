import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final int? success;
  final String? message;
  final List<ShopLocationData>? data;

  const LocationEntity({
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


class ShopLocationData extends Equatable {

  final String? displayName;
  final String? lat;
  final String? long;
  final Address? address;

  const ShopLocationData({
    required this.displayName,
    required this.lat,
    required this.long,
    required this.address,
  });

  factory ShopLocationData.fromJson(Map<String,dynamic> json){
    return ShopLocationData(
      displayName: json['display_name'],
      lat: json['lat'],
      long: json['long'],
      address: Address.fromJson(json['address']),
    );
  }

  @override
  List<Object?> get props => [];
}


class Address extends Equatable {

  final int? stateID;
  final String? stateName;
  final String? city;
  final String? cityName;

  const Address({
    required this.stateID,
    required this.stateName,
    required this.city,
    required this.cityName,
  });

  factory Address.fromJson(Map<String,dynamic> json){
    return Address(
      stateID: json['id'],
      stateName: json['state_name'],
      city: json['city'],
      cityName: json['city_name'],
    );
  }

  @override
  List<Object?> get props => [];
}




