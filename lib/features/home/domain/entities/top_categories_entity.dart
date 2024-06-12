import 'package:equatable/equatable.dart';

class TopCategoriesEntity extends Equatable {
  final int success;
  final String message;
  List<Data> data;

  TopCategoriesEntity({
    required this.success,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
  ];
}

class Data {
  String? categoryName;
  List<Shop>? shop;

  Data({
    this.categoryName,
    this.shop,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categoryName: json["category_name"],
    shop: json["shop"] == null ? [] : List<Shop>.from(json["shop"]!.map((x) => Shop.fromJson(x))),
  );
}

class Shop {
  int? id;
  String? shopName;
  String? logo;
  String? banner;
  String? commercial;
  String? vat;
  String? rate;
  String? logoPath;
  String? bannerPath;
  String? commercialPath;
  String? vatPath;
  List<dynamic>? ratings;

  Shop({
    this.id,
    this.shopName,
    this.logo,
    this.banner,
    this.commercial,
    this.vat,
    this.rate,
    this.logoPath,
    this.bannerPath,
    this.commercialPath,
    this.vatPath,
    this.ratings,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    shopName: json["shop_name"],
    logo: json["logo"],
    banner: json["banner"],
    commercial: json["commercial"],
    vat: json["vat"],
    rate: json["rate"],
    logoPath: json["logo_path"],
    bannerPath: json["banner_path"],
    commercialPath: json["commercial_path"],
    vatPath: json["vat_path"],
    ratings: json["ratings"] == null ? [] : List<dynamic>.from(json["ratings"]!.map((x) => x)),
  );
}