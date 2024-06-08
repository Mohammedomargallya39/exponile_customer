import 'package:equatable/equatable.dart';

class AccountDataEntity extends Equatable {
  final int? success;
  final String? message;
  final Data data;

  const AccountDataEntity({
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

class Data {
  User? user;
  List<Address>? addresses;

  Data({
    this.user,
    this.addresses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    addresses: json["addresses"] == null ? [] : List<Address>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
  );
}

class Address {
  int? id;
  dynamic deletedAt;
  int? user;
  int? governorate;
  int? area;
  String? governorateName;
  String? areaName;
  String? lat;
  String? long;
  String? streetName;
  String? buildingName;
  String? landmark;
  int? floorNo;
  int? aptNo;
  int? postalNo;
  String? type;
  dynamic createdAt;
  dynamic updatedAt;
  GetArea? getArea;
  GetGovernorate? getGovernorate;

  Address({
    this.id,
    this.deletedAt,
    this.user,
    this.governorate,
    this.area,
    this.governorateName,
    this.areaName,
    this.lat,
    this.long,
    this.streetName,
    this.buildingName,
    this.landmark,
    this.floorNo,
    this.aptNo,
    this.postalNo,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.getArea,
    this.getGovernorate,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    deletedAt: json["deleted_at"],
    user: json["user"],
    governorate: json["governorate"],
    area: json["area"],
    governorateName: json["governorate_name"],
    areaName: json["area_name"],
    lat: json["lat"],
    long: json["long"],
    streetName: json["street_name"],
    buildingName: json["building_name"],
    landmark: json["landmark"],
    floorNo: json["floor_no"],
    aptNo: json["apt_no"],
    postalNo: json["postal_no"],
    type: json["type"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    getArea: json["get_area"] == null ? null : GetArea.fromJson(json["get_area"]),
    getGovernorate: json["get_governorate"] == null ? null : GetGovernorate.fromJson(json["get_governorate"]),
  );
}

class GetArea {
  int? id;
  String? name;
  String? areaId;
  String? areaDeliveryHubCode;
  String? areaPickupHubCode;
  int? showAsPickupArea;
  int? showAsDropoffArea;
  int? city;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? lat;
  String? long;

  GetArea({
    this.id,
    this.name,
    this.areaId,
    this.areaDeliveryHubCode,
    this.areaPickupHubCode,
    this.showAsPickupArea,
    this.showAsDropoffArea,
    this.city,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.lat,
    this.long,
  });

  factory GetArea.fromJson(Map<String, dynamic> json) => GetArea(
    id: json["id"],
    name: json["name"],
    areaId: json["area_id"],
    areaDeliveryHubCode: json["area_delivery_hub_code"],
    areaPickupHubCode: json["area_pickup_hub_code"],
    showAsPickupArea: json["show_as_pickup_area"],
    showAsDropoffArea: json["show_as_dropoff_area"],
    city: json["city"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    lat: json["lat"],
    long: json["long"],
  );
}

class GetGovernorate {
  int? id;
  String? name;
  String? govId;
  String? govDeliveryHubCode;
  String? govPickupHubCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  GetGovernorate({
    this.id,
    this.name,
    this.govId,
    this.govDeliveryHubCode,
    this.govPickupHubCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory GetGovernorate.fromJson(Map<String, dynamic> json) => GetGovernorate(
    id: json["id"],
    name: json["name"],
    govId: json["gov_id"],
    govDeliveryHubCode: json["gov_delivery_hub_code"],
    govPickupHubCode: json["gov_pickup_hub_code"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );
}

class User {
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? mobile;
  String? whatsMobile;
  DateTime? emailVerifiedAt;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? shop;
  dynamic provider;
  dynamic providerId;
  dynamic gender;
  dynamic image;
  int? mobileVerification;
  dynamic otp;
  String? wallet;
  dynamic emailWaiting;
  String? imagePath;

  User({
    this.id,
    this.username,
    this.fullName,
    this.email,
    this.mobile,
    this.whatsMobile,
    this.emailVerifiedAt,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.shop,
    this.provider,
    this.providerId,
    this.gender,
    this.image,
    this.mobileVerification,
    this.otp,
    this.wallet,
    this.emailWaiting,
    this.imagePath,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    fullName: json["full_name"],
    email: json["email"],
    mobile: json["mobile"],
    whatsMobile: json["whats_mobile"] ??'',
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    type: json["type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    shop: json["shop"],
    provider: json["provider"],
    providerId: json["provider_id"],
    gender: json["gender"],
    image: json["image"],
    mobileVerification: json["mobile_verification"],
    otp: json["otp"],
    wallet: json["wallet"],
    emailWaiting: json["email_waiting"],
    imagePath: json["image_path"],
  );
}

