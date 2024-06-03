import 'package:equatable/equatable.dart';

class MainSearchProductEntity extends Equatable {
  final int? success;
  final String? message;
  final List<ProductData> data;

  const MainSearchProductEntity({
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

class ProductData {
  ProductData({
    required this.id,
    required this.deletedAt,
    required this.shop,
    required this.category,
    required this.subCategory,
    required this.code,
    required this.name,
    required this.description,
    required this.feature,
    required this.status,
    required this.launchingDate,
    required this.publishingDate,
    required this.basicQuantity,
    required this.basicPrice,
    required this.extraDeliveryFees,
    required this.extraTaxesFees,
    required this.returnTime,
    required this.returnTimeType,
    required this.createdAt,
    required this.updatedAt,
    required this.imageFeature,
    required this.featureId,
    required this.slug,
    required this.rate,
    required this.images,
    required this.getCategory,
    required this.getSubCategory,
    required this.getShop,
  });

  int? id;
  dynamic deletedAt;
  int? shop;
  int? category;
  dynamic subCategory;
  String? code;
  String? name;
  String? description;
  String? feature;
  String? status;
  dynamic launchingDate;
  dynamic publishingDate;
  int? basicQuantity;
  String? basicPrice;
  dynamic extraDeliveryFees;
  dynamic extraTaxesFees;
  dynamic returnTime;
  String? returnTimeType;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic imageFeature;
  dynamic featureId;
  String? slug;
  String? rate;
  List<ProductImage> images;
  GetCategory getCategory;
  dynamic getSubCategory;
  GetShop getShop;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    id: json["id"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    shop: json["shop"] ?? 0,
    category: json["category"] ?? 0,
    subCategory: json["subCategory"] ?? 0,
    code: json["code"] ?? '',
    name: json["name"] ?? '',
    description: json["description"] ?? '',
    feature: json["feature"] ?? '',
    status: json["status"] ?? '',
    launchingDate: json["launching_date"] ?? '',
    publishingDate: DateTime.parse(json["publishing_date"] ?? ''),
    basicQuantity: json["basic_quantity"] ?? 0,
    basicPrice: json["basic_price"] ?? '',
    extraDeliveryFees: json["extra_delivery_fees"] ?? '',
    extraTaxesFees: json["extra_taxes_fees"] ?? '',
    returnTime: json["return_time"] ?? '',
    returnTimeType: json["return_time_type"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    imageFeature: json["image_feature"] ?? '',
    featureId: json["feature_id"] ?? '',
    slug: json["slug"] ?? '',
    rate: json["rate"] ?? '',
    images: List<ProductImage>.from(
        json["images"].map((x) => ProductImage.fromJson(x))),
    getCategory: GetCategory.fromJson(json["get_category"]),
    getSubCategory: json["get_sub_category"],
    getShop: GetShop.fromJson(json["get_shop"]),
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "deleted_at": deletedAt,
//       "shop": shop,
//       "category": category,
//       "subCategory": subCategory,
//       "code": code,
//       "name": name,
//       "description": description,
//       "feature": feature,
//       "status": status,
//       "launching_date": launchingDate,
//       "publishing_date": publishingDate.toIso8601String(),
//       "basic_quantity": basicQuantity,
//       "basic_price": basicPrice,
//       "extra_delivery_fees": extraDeliveryFees,
//       "extra_taxes_fees": extraTaxesFees,
//       "return_time": returnTime,
//       "return_time_type": returnTimeType,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
//       "image_feature": imageFeature,
//       "feature_id": featureId,
//       "slug": slug,
//       "rate": rate,
//       "images": List<dynamic>.from(images.map((x) => x.toJson())),
//       "get_category": getCategory.toJson(),
//       "get_sub_category": getSubCategory,
//       "get_shop": getShop.toJson(),
//     };
}

class GetCategory {
  GetCategory({
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

  factory GetCategory.fromJson(Map<String, dynamic> json) => GetCategory(
    id: json["id"] ?? 0,
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    deletedAt: json["deleted_at"] ?? '',
    name: json["name"] ?? '',
    banner: json["banner"] ?? '',
    slug: json["slug"] ?? '',
    isDeal: json["isDeal"] ?? 0,
    parent: json["parent"] ?? 0,
    percentage: json["percentage"] ?? 0,
    bannerPath: json["banner_path"] ?? '',
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
//     };
}

class GetShop {
  GetShop({
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

  factory GetShop.fromJson(Map<String, dynamic> json) => GetShop(
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
//     };
}

class ProductImage {
  ProductImage({
    required this.id,
    required this.deletedAt,
    required this.product,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.subFeature,
    required this.imagePath,
  });

  int? id;
  dynamic deletedAt;
  int? product;
  String? image;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic subFeature;
  String? imagePath;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json["id"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    product: json["product"] ?? 0,
    image: json["image"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    subFeature: json["subfeature"] ?? '',
    imagePath: json["image_path"] ?? '',
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "deleted_at": deletedAt,
//       "product": product,
//       "image": image,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
//       "subfeature": subFeature,
//       "image_path": imagePath,
//     };
}
