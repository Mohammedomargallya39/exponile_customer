import 'package:equatable/equatable.dart';

class ShopDataEntity extends Equatable {
  final int? success;
  final String? message;
  final Data? data;

  const ShopDataEntity({
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
    required this.store,
    required this.categories,
    required this.products,
  });

  Store store;
  List<Category> categories;
  List<Product> products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    store: Store.fromJson(json["store"]),
    categories: List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x))),
    products: List<Product>.from(
        json["products"].map((x) => Product.fromJson(x))),
  );

// Map<String, dynamic> toJson() => {
//       "store": store.toJson(),
//       "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
//       "products": List<dynamic>.from(products.map((x) => x.toJson())),
//     };
}

class Category {
  Category(
      {required this.id,
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
        required this.subCategories});

  int? id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String name;
  String? banner;
  String? slug;
  int? isDeal;
  int? parent;
  int? percentage;
  String? bannerPath;
  List<Category>? subCategories;
  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? 0,
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    deletedAt: json["deleted_at"] ?? '',
    name: json["name"] ?? '',
    banner: json["banner"] == null ? null : json["banner"] ?? '',
    slug: json["slug"] ?? '',
    isDeal: json["isDeal"] ?? 0,
    parent: json["parent"] ?? 0,
    percentage: json["percentage"] ?? 0,
    bannerPath: json["banner_path"] ?? '',
    subCategories: json["sub_categories"] == null
        ? null
        : List<Category>.from(
        json["sub_categories"].map((x) => Category.fromJson(x))),
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
//       "sub_categories": subCategories == null
//           ? null
//           : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
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
    required this.ratings,
    required this.getCategory,
    required this.offers,
    required this.favorites,
  });

  int? id;
  dynamic deletedAt;
  int? shop;
  int? category;
  int? subCategory;
  String? code;
  String? name;
  String? description;
  String? feature;
  String? status;
  String? launchingDate;
  dynamic publishingDate;
  int? basicQuantity;
  String? basicPrice;
  String? extraDeliveryFees;
  String? extraTaxesFees;
  int? returnTime;
  String? returnTimeType;
  dynamic createdAt;
  dynamic updatedAt;
  String? imageFeature;
  dynamic featureId;
  String? slug;
  String? rate;
  List<Image> images;
  List<dynamic> ratings;
  Category? getCategory;
  List<Offer>? offers;
  List<dynamic> favorites;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    shop: json["shop"] ?? 0,
    category: json["category"] ?? 0,
    subCategory:
    json["subCategory"] == null ? null : json["subCategory"] ?? 0,
    code: json["code"] ?? '',
    name: json["name"] ?? '',
    description: json["description"] ?? '',
    feature: json["feature"] ?? '',
    status: json["status"] ?? '',
    launchingDate: json["launching_date"] == null
        ? null
        : json["launching_date"] ?? '',
    publishingDate: json["publishing_date"] ?? '',
    basicQuantity: json["basic_quantity"] ?? 0,
    basicPrice: json["basic_price"] ?? '',
    extraDeliveryFees: json["extra_delivery_fees"] == null
        ? null
        : json["extra_delivery_fees"] ?? '',
    extraTaxesFees: json["extra_taxes_fees"] == null
        ? null
        : json["extra_taxes_fees"] ?? '',
    returnTime:
    json["return_time"] == null ? null : json["return_time"] ?? 0,
    returnTimeType: json["return_time_type"] ?? '',
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    imageFeature:
    json["image_feature"] == null ? null : json["image_feature"] ?? '',
    featureId: json["feature_id"] ?? '',
    slug: json["slug"] ?? '',
    rate: json["rate"] ?? '',
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    ratings: List<dynamic>.from(json["ratings"].map((x) => x)),
    getCategory: json["get_category"] == null
        ? null
        : Category.fromJson(json["get_category"]),
    offers: json["offers"] == null
        ? null
        : List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
    favorites: List<dynamic>.from(json["favorites"].map((x) => x)),
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
//       "ratings": List<dynamic>.from(ratings.map((x) => x)),
//       "get_category": getCategory!.toJson(),
//       "offers": List<dynamic>.from(offers!.map((x) => x.toJson())),
//       "favorites": List<dynamic>.from(favorites.map((x) => x)),
//     };
}

class Image {
  Image({
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

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    product: json["product"] ?? 0,
    image: json["image"] ?? '',
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
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
  int? buyAmount;
  int? getAmount;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  String? slug;
  int? category;
  String? bannerPath;

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
    value: json["value"] == null ? null : json["value"] ?? 0,
    minAmount: json["min_amount"] ?? '',
    promoCode: json["promo_code"],
    buyAmount: json["buy_amount"] == null ? null : json["buy_amount"] ?? 0,
    getAmount: json["get_amount"] == null ? null : json["get_amount"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    slug: json["slug"] ?? '',
    category: json["category"] == null ? null : json["category"] ?? 0,
    bannerPath: json["banner_path"] ?? '',
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
//     };
}

class Store {
  Store({
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
    required this.ratings,
    required this.categories,
    required this.offers,
    required this.favorites,
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
  List<dynamic> ratings;
  List<Category> categories;
  List<Offer> offers;
  List<dynamic> favorites;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
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
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    slug: json["slug"] ?? '',
    rate: json["rate"] ?? '',
    logoPath: json["logo_path"] ?? '',
    bannerPath: json["banner_path"] ?? '',
    commercial1Path: json["commercial1_path"] ?? '',
    commercial2Path: json["commercial2_path"] ?? '',
    vat1Path: json["vat1_path"] ?? '',
    vat2Path: json["vat2_path"] ?? '',
    ratings: List<dynamic>.from(json["ratings"].map((x) => x)),
    categories: List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x))),
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
    favorites: List<dynamic>.from(json["favorites"].map((x) => x)),
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
//       "ratings": List<dynamic>.from(ratings.map((x) => x)),
//       "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
//       "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
//       "favorites": List<dynamic>.from(favorites.map((x) => x)),
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
  RatingPivot pivot;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"] ?? 0,
    username: json["username"] ?? '',
    email: json["email"] ?? '',
    mobile: json["mobile"] ?? '',
    whatsMobile: json["whats_mobile"] ?? '',
    emailVerifiedAt: DateTime.parse(json["email_verified_at"] ?? ''),
    type: json["type"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    deletedAt: json["deleted_at"] ?? '',
    shop: json["shop"] ?? 0,
    provider: json["provider"] ?? '',
    providerId: json["provider_id"] ?? '',
    gender: json["gender"] ?? '',
    image: json["image"] ?? '',
    imagePath: json["image_path"] ?? '',
    pivot: RatingPivot.fromJson(json["pivot"]),
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

class RatingPivot {
  RatingPivot({
    required this.shop,
    required this.user,
  });

  int? shop;
  int? user;

  factory RatingPivot.fromJson(Map<String, dynamic> json) => RatingPivot(
    shop: json["shop"] ?? 0,
    user: json["user"] ?? 0,
  );

// Map<String, dynamic> toJson() => {
//       "shop": shop,
//       "user": user,
//     };
}