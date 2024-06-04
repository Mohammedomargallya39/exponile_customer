import 'package:equatable/equatable.dart';

class MainSearchShopEntity extends Equatable {
  final int? success;
  final String? message;
  final List<StoresData> data;

  const MainSearchShopEntity({
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

class StoresData {
  StoresData({
    required this.id,
    required this.deletedAt,
    required this.user,
    required this.shopName,
    required this.email,
    required this.mobile,
    required this.whatsMobile,
    required this.logo,
    required this.banner,
    required this.commercial1,
    required this.commercial2,
    required this.vat1,
    required this.vat2,
    required this.merchantType,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.rate,
    required this.logoPath,
    required this.bannerPath,
    required this.commercial1Path,
    required this.commercial2Path,
    required this.vat1Path,
    required this.vat2Path,
    required this.categories,
  });

  int? id;
  dynamic deletedAt;
  int? user;
  String? shopName;
  String? email;
  String? mobile;
  String? whatsMobile;
  String? logo;
  String? banner;
  dynamic commercial1;
  dynamic commercial2;
  dynamic vat1;
  dynamic vat2;
  String? merchantType;
  dynamic createdAt;
  dynamic updatedAt;
  String? slug;
  String? rate;
  String? logoPath;
  String? bannerPath;
  String? commercial1Path;
  String? commercial2Path;
  String? vat1Path;
  String? vat2Path;
  List<Category> categories;

  factory StoresData.fromJson(Map<String, dynamic> json) => StoresData(
    id: json["id"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    user: json["user"] ?? 0,
    shopName: json["shop_name"] ?? '',
    email: json["email"] ?? '',
    mobile: json["mobile"] ?? '',
    whatsMobile: json["whats_mobile"] ?? '',
    logo: json["logo"] ?? '',
    banner: json["banner"] ?? '',
    commercial1: json["commercial1"] ?? '',
    commercial2: json["commercial2"] ?? '',
    vat1: json["vat1"] ?? '',
    vat2: json["vat2"] ?? '',
    merchantType: json["merchant_type"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    slug: json["slug"] ?? '',
    rate: json["rate"] ?? '',
    logoPath: json["logo_path"] ?? '',
    bannerPath: json["banner_path"] ?? '',
    commercial1Path: json["commercial1_path"] ?? '',
    commercial2Path: json["commercial2_path"] ?? '',
    vat1Path: json["vat1_path"] ?? '',
    vat2Path: json["vat2_path"] ?? '',
    categories: List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x))),
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "deleted_at": deletedAt,
//       "user": user,
//       "shop_name": shopName,
//       "email": email,
//       "mobile": mobile,
//       "whats_mobile": whatsMobile,
//       "logo": logo,
//       "banner": banner,
//       "commercial1": commercial1,
//       "commercial2": commercial2,
//       "vat1": vat1,
//       "vat2": vat2,
//       "merchant_type": merchantType,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
//       "slug": slug,
//       "rate": rate,
//       "logo_path": logoPath,
//       "banner_path": bannerPath,
//       "commercial1_path": commercial1Path,
//       "commercial2_path": commercial2Path,
//       "vat1_path": vat1Path,
//       "vat2_path": vat2Path,
//       "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
//     };
}

class Category {
  Category({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.banner,
    required this.slug,
    required this.isDeal,
    required this.parent,
    required this.percentage,
    required this.bannerPath,
    required this.pivot,
  });

  int? id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String? name;
  String? banner;
  String? slug;
  int? isDeal;
  int? parent;
  int? percentage;
  String? bannerPath;
  Pivot pivot;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? 0,
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    deletedAt: json["deleted_at"] ?? '',
    name: json["name"] ?? '',
    banner: json["banner"] == null ? null : json["banner"] ?? '',
    slug: json["slug"] ?? '',
    isDeal: json["isDeal"] ?? 0,
    parent: json["parent"] ?? 0,
    percentage: json["percentage"] ?? 0,
    bannerPath: json["banner_path"] ?? '',
    pivot: Pivot.fromJson(json["pivot"]),
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
//       "deleted_at": deletedAt,
//       "name": name,
//       "banner": banner,
//       "slug": slug,
//       "isDeal": isDeal,
//       "parent": parent,
//       "percentage": percentage,
//       "banner_path": bannerPath,
//       "pivot": pivot.toJson(),
//     };
}

class Pivot {
  Pivot({
    required this.shop,
    required this.category,
  });

  int? shop;
  int? category;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    shop: json["shop"] ?? 0,
    category: json["category"] ?? 0,
  );

// Map<String, dynamic> toJson() => {
//       "shop": shop,
//       "category": category,
//     };
}