import 'package:equatable/equatable.dart';

class ProductDataEntity extends Equatable {
  final int? success;
  final String? message;
  final Data? data;

  const ProductDataEntity({
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
  Data({
    required this.product,
    required this.relatedProductSameShop,
    required this.relatedProductDiffShop,
    required this.reviews,
  });

  Product product;
  List<RelatedProduct> relatedProductSameShop;
  List<RelatedProduct> relatedProductDiffShop;
  List<Review> reviews;
  factory Data.fromJson(Map<String, dynamic> json) => Data(
    product: Product.fromJson(json["product"]),
    relatedProductSameShop: List<RelatedProduct>.from(
        json["relatedProductSameShop"]
            .map((x) => RelatedProduct.fromJson(x))),
    relatedProductDiffShop: List<RelatedProduct>.from(
        json["relatedProductDiffShop"]
            .map((x) => RelatedProduct.fromJson(x))),
    reviews:
    List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
  );

// Map<String, dynamic> toJson() => {
//       "product": product.toJson(),
//       "relatedProductSameShop":
//           List<dynamic>.from(relatedProductSameShop.map((x) => x.toJson())),
//       "relatedProductDiffShop":
//           List<dynamic>.from(relatedProductDiffShop.map((x) => x.toJson())),
//       "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
//     };
}

class Product {
  Product({
    required this.id,
    required this.deletedAt,
    required this.shop,
    required this.category,
    required this.subCategory,
    required this.code,
    required this.name,
    required this.nameEn,
    required this.nameAr,
    required this.description,
    required this.feature,
    required this.status,
    required this.launchingDate,
    required this.publishingDate,
    required this.basicQuantity,
    required this.favoritesCount,
    required this.ratingsCount,
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
    required this.basicWidth,
    required this.basicLength,
    required this.basicHeight,
    required this.basicWeight,
    required this.basicPackageType,
    required this.skuCode,
    required this.reorderQuantity,
    required this.getCategory,
    required this.getShop,
    required this.images,
    required this.features,
    required this.offers,
    required this.ratings,
  });

  int? id;
  dynamic deletedAt;
  int? shop;
  int? category;
  int? subCategory;
  String? code;
  String? name;
  String? nameEn;
  String? nameAr;
  String? description;
  String? feature;
  String? status;
  dynamic launchingDate;
  dynamic publishingDate;
  int? basicQuantity;
  int? favoritesCount;
  int? ratingsCount;
  String? basicPrice;
  dynamic extraDeliveryFees;
  dynamic extraTaxesFees;
  dynamic returnTime;
  String? returnTimeType;
  dynamic createdAt;
  dynamic updatedAt;
  String? imageFeature;
  dynamic featureId;
  String? slug;
  String? rate;
  String? basicWidth;
  String? basicLength;
  String? basicHeight;
  String? basicWeight;
  String? basicPackageType;
  String? skuCode;
  int? reorderQuantity;
  GetCategory getCategory;
  GetShop getShop;
  List<ProductsImages> images;
  List<Feature1>? features;
  List<Offer> offers;
  List<Rating>? ratings;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    shop: json["shop"] ?? 0,
    category: json["category"] ?? 0,
    subCategory: json["subCategory"] ?? 0,
    code: json["code"] ?? '',
    name: json["name"] ?? '',
    nameEn: json["name_en"] ?? '',
    nameAr: json["name_ar"] ?? '',
    description: json["description"] ?? '',
    feature: json["feature"] ?? '',
    status: json["status"] ?? '',
    launchingDate: json["launching_date"] ?? '',
    publishingDate: DateTime.parse(json["publishing_date"] ?? ''),
    basicQuantity: json["basic_quantity"] ?? 0,
    favoritesCount: json["favorites_count"] ?? 0,
    ratingsCount: json["ratings_count"] ?? 0,
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
    basicWidth: json["basic_width"] ?? '',
    basicLength: json["basic_length"] ?? '',
    basicHeight: json["basic_height"] ?? '',
    basicWeight: json["basic_weight"] ?? '',
    basicPackageType: json["basic_package_type"] ?? '',
    skuCode: json["sku_code"] ?? '',
    reorderQuantity: json["reorder_quantity"] ?? 0,
    getCategory: GetCategory.fromJson(json["get_category"]),
    getShop: GetShop.fromJson(json["get_shop"]),
    images: List<ProductsImages>.from(json["images"].map((x) => ProductsImages.fromJson(x))),
    features: json["features"] == null
        ? null
        : List<Feature1>.from(
        json["features"].map((x) => Feature1.fromJson(x))),
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
    ratings:
    List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "deleted_at": deletedAt,
//       "shop": shop,
//       "category": category,
//       "subCategory": subCategory,
//       "code": code,
//       "name": name,
//       "name_en": nameEn,
//       "name_ar": nameAr,
//       "description": description,
//       "feature": feature,
//       "status": status,
//       "launching_date": launchingDate,
//       "publishing_date": publishingDate.toIso8601String(),
//       "basic_quantity": basicQuantity,
//       "favorites_count": favoritesCount,
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
//       "basic_width": basicWidth,
//       "basic_length": basicLength,
//       "basic_height": basicHeight,
//       "basic_weight": basicWeight,
//       "basic_package_type": basicPackageType,
//       "sku_code": skuCode,
//       "reorder_quantity": reorderQuantity,
//       "ratings_count": ratingsCount,
//       "get_category": getCategory.toJson(),
//       "get_shop": getShop.toJson(),
//       "images": List<dynamic>.from(images.map((x) => x.toJson())),
//       "features": List<dynamic>.from(features!.map((x) => x.toJson())),
//       "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
//       "ratings":
//           ratings == null ? null : List<dynamic>.from(ratings!.map((x) => x)),
//     };
}

class Rating {
  Rating({
    required this.id,
    required this.username,
    required this.email,
    required this.mobile,
    required this.whatsMobile,
    required this.emailVerifiedAt,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.shop,
    required this.provider,
    required this.providerId,
    required this.gender,
    required this.image,
    required this.imagePath,
    required this.pivot,
  });

  int id;
  String username;
  String email;
  String mobile;
  dynamic whatsMobile;
  DateTime emailVerifiedAt;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  dynamic shop;
  dynamic provider;
  dynamic providerId;
  String gender;
  dynamic image;
  String imagePath;
  Pivot pivot;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    mobile: json["mobile"],
    whatsMobile: json["whats_mobile"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    shop: json["shop"],
    provider: json["provider"],
    providerId: json["provider_id"],
    gender: json["gender"],
    image: json["image"],
    imagePath: json["image_path"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "username": username,
//       "email": email,
//       "mobile": mobile,
//       "whats_mobile": whatsMobile,
//       "email_verified_at": emailVerifiedAt.toIso8601String(),
//       "type": type,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
//       "deleted_at": deletedAt,
//       "shop": shop,
//       "provider": provider,
//       "provider_id": providerId,
//       "gender": gender,
//       "image": image,
//       "image_path": imagePath,
//       "pivot": pivot.toJson(),
//     };
}

class RelatedProduct {
  RelatedProduct({
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
    required this.getCategory,
    required this.images,
    required this.features,
    required this.offers,
    required this.ratings,
    required this.favoritesCount,
  });

  int? id;
  int? favoritesCount;
  dynamic deletedAt;
  int? shop;
  int? category;
  int? subCategory;
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
  String? imageFeature;
  dynamic featureId;
  String? slug;
  String? rate;
  GetCategory getCategory;
  List<ProductsImages> images;
  List<Feature1>? features;
  List<Offer> offers;
  List<dynamic>? ratings;

  factory RelatedProduct.fromJson(Map<String, dynamic> json) => RelatedProduct(
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
    favoritesCount: json["favorites_count"] ?? 0,
    getCategory: GetCategory.fromJson(json["get_category"]),
    images: List<ProductsImages>.from(json["images"].map((x) => ProductsImages.fromJson(x))),
    features: json["features"] == null
        ? null
        : List<Feature1>.from(
        json["features"].map((x) => Feature1.fromJson(x))),
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
    ratings: List<dynamic>.from(json["ratings"] ?? [].map((x) => x)),
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
//       "get_category": getCategory.toJson(),
//       "images": List<dynamic>.from(images.map((x) => x.toJson())),
//       "features": List<dynamic>.from(features!.map((x) => x.toJson())),
//       "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
//       "ratings":
//           ratings == null ? null : List<dynamic>.from(ratings!.map((x) => x)),
//     };
}

class Feature1 {
  Feature1({
    required this.id,
    required this.deletedAt,
    required this.product,
    required this.feature,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.getFeature,
    required this.subFeatures,
    required this.color,
  });

  int? id;
  dynamic deletedAt;
  int? product;
  int? feature;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;
  GetFeature? getFeature;
  List<Feature1>? subFeatures;
  String? color;

  factory Feature1.fromJson(Map<String, dynamic> json) => Feature1(
    id: json["id"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    product: json["product"] ?? 0,
    feature: json["feature"],
    name: json["name"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    getFeature: json["get_feature"] == null ? null : GetFeature.fromJson(json["get_feature"]),
    subFeatures: json["sub_features"] == null
        ? null
        : List<Feature1>.from(
        json["sub_features"].map((x) => Feature1.fromJson(x))),
    color: json["color"] ?? '',
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "deleted_at": deletedAt,
//       "product": product,
//       "feature": feature,
//       "name": name,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
//       "get_feature": getFeature == null ? null : getFeature!.toJson(),
//       "sub_features": subFeatures == null
//           ? null
//           : List<dynamic>.from(subFeatures!.map((x) => x.toJson())),
//       "color": color,
//     };
}

class GetFeature {
  GetFeature({
    required this.id,
    required this.deletedAt,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  dynamic deletedAt;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  factory GetFeature.fromJson(Map<String, dynamic> json) => GetFeature(
    id: json["id"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    name: json["name"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "deleted_at": deletedAt,
//       "name": name,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
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
  dynamic banner;
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

class ProductsImages {
  ProductsImages({
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

  factory ProductsImages.fromJson(Map<String, dynamic> json) => ProductsImages(
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

class Offer {
  Offer({
    required this.id,
    required this.shop,
    required this.type,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.banner,
    required this.setupType,
    required this.value,
    required this.minAmount,
    required this.promoCode,
    required this.buyAmount,
    required this.getAmount,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.category,
    required this.bannerPath,
    required this.pivot,
  });

  int? id;
  int? shop;
  int? type;
  String? name;
  String? startDate;
  String? endDate;
  String? status;
  String? banner;
  String? setupType;
  int? value;
  dynamic minAmount;
  dynamic promoCode;
  dynamic buyAmount;
  dynamic getAmount;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  String? slug;
  dynamic category;
  String? bannerPath;
  Pivot pivot;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"] ?? 0,
    shop: json["shop"] ?? 0,
    type: json["type"] ?? 0,
    name: json["name"] ?? '',
    startDate: json["start_date"] ?? '',
    endDate: json["end_date"] ?? '',
    status: json["status"] ?? '',
    banner: json["banner"] ?? '',
    setupType: json["setup_type"] ?? '',
    value: json["value"] ?? 0,
    minAmount: json["min_amount"] ?? '',
    promoCode: json["promo_code"] ?? '',
    buyAmount: json["buy_amount"] ?? '',
    getAmount: json["get_amount"] ?? '',
    deletedAt: json["deleted_at"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    slug: json["slug"] ?? '',
    category: json["category"] ?? '',
    bannerPath: json["banner_path"] ?? '',
    pivot: Pivot.fromJson(json["pivot"]),
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "shop": shop,
//       "type": type,
//       "name": name,
//       "start_date": startDate,
//       "end_date": endDate,
//       "status": status,
//       "banner": banner,
//       "setup_type": setupType,
//       "value": value,
//       "min_amount": minAmount,
//       "promo_code": promoCode,
//       "buy_amount": buyAmount,
//       "get_amount": getAmount,
//       "deleted_at": deletedAt,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
//       "slug": slug,
//       "category": category,
//       "banner_path": bannerPath,
//       "pivot": pivot.toJson(),
//     };
}

class Pivot {
  Pivot({
    required this.product,
    required this.offer,
  });

  int? product;
  int? offer;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    product: json["product"] ?? 0,
    offer: json["offer"] ?? 0,
  );

// Map<String, dynamic> toJson() => {
//       "product": product,
//       "offer": offer,
//     };
}

class Review {
  Review({
    required this.id,
    required this.deletedAt,
    required this.user,
    required this.product,
    required this.order,
    required this.rate,
    required this.review,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.getUser,
  });

  int? id;
  dynamic deletedAt;
  int? user;
  int? product;
  int? order;
  int? rate;
  String? review;
  String? status;
  String? createdAt;
  dynamic updatedAt;
  GetUser getUser;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    user: json["user"] ?? 0,
    product: json["product"] ?? 0,
    order: json["order"] ?? 0,
    rate: json["rate"] ?? 0,
    review: json["review"] ?? '',
    status: json["status"] ?? '',
    createdAt: json["created_at"] ?? '',
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    getUser: GetUser.fromJson(json["get_user"]),
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "deleted_at": deletedAt,
//       "user": user,
//       "product": product,
//       "order": order,
//       "rate": rate,
//       "review": review,
//       "status": status,
//       "created_at": createdAt,
//       "updated_at": updatedAt.toIso8601String(),
//       "get_user": getUser.toJson(),
//     };
}

class GetUser {
  GetUser({
    required this.id,
    required this.username,
    required this.email,
    required this.mobile,
    required this.whatsMobile,
    required this.emailVerifiedAt,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.shop,
    required this.provider,
    required this.providerId,
    required this.gender,
    required this.image,
    required this.imagePath,
  });

  int? id;
  String? username;
  String? email;
  String? mobile;
  dynamic whatsMobile;
  dynamic emailVerifiedAt;
  String? type;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic shop;
  dynamic provider;
  dynamic providerId;
  String? gender;
  dynamic image;
  String? imagePath;

  factory GetUser.fromJson(Map<String, dynamic> json) => GetUser(
    id: json["id"] ?? 0,
    username: json["username"] ?? '',
    email: json["email"] ?? '',
    mobile: json["mobile"] ?? '',
    whatsMobile: json["whats_mobile"] ?? '',
    emailVerifiedAt: DateTime.parse(json["email_verified_at"] ?? ''),
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    deletedAt: json["deleted_at"] ?? '',
    shop: json["shop"] ?? '',
    provider: json["provider"] ?? '',
    providerId: json["provider_id"] ?? '',
    gender: json["gender"] ?? '',
    image: json["image"] ?? '',
    imagePath: json["image_path"] ?? '',
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "username": username,
//       "email": email,
//       "mobile": mobile,
//       "whats_mobile": whatsMobile,
//       "email_verified_at": emailVerifiedAt.toIso8601String(),
//       "type": type,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
//       "deleted_at": deletedAt,
//       "shop": shop,
//       "provider": provider,
//       "provider_id": providerId,
//       "gender": gender,
//       "image": image,
//       "image_path": imagePath,
//     };
}







