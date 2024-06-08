import 'package:equatable/equatable.dart';

class FavouriteProductsEntity extends Equatable {
  final int? success;
  final String? message;
  final List<Data>? data;

  const FavouriteProductsEntity({
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
  dynamic createdAt;
  dynamic updatedAt;
  String? imageFeature;
  dynamic featureId;
  String? slug;
  String? rate;
  List<Image> images;
  List<Favorite> ratings;
  GetCategory getCategory;

  List<Offer> offers;
  List<Favorite> favorites;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    imageFeature: json["image_feature"] ?? '',
    featureId: json["feature_id"] ?? '',
    slug: json["slug"] ?? '',
    rate: json["rate"] ?? '',
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    ratings: List<Favorite>.from(
        json["ratings"].map((x) => Favorite.fromJson(x))),
    getCategory: GetCategory.fromJson(json["get_category"]),
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
    favorites: List<Favorite>.from(
        json["favorites"].map((x) => Favorite.fromJson(x))),
  );
}

class Favorite {
  Favorite({
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
  FavoritePivot pivot;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
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
    shop: json["shop"] ?? '',
    provider: json["provider"] ?? '',
    providerId: json["provider_id"] ?? '',
    gender: json["gender"] ?? '',
    image: json["image"] ?? '',
    imagePath: json["image_path"] ?? '',
    pivot: FavoritePivot.fromJson(json["pivot"]),
  );
}

class FavoritePivot {
  FavoritePivot({
    required this.product,
    required this.user,
  });

  int? product;
  int? user;

  factory FavoritePivot.fromJson(Map<String, dynamic> json) => FavoritePivot(
    product: json["product"] ?? 0,
    user: json["user"] ?? 0,
  );
}

class Detail {
  Detail({
    required this.id,
    required this.deletedAt,
    required this.subFeature1,
    required this.subFeature2,
    required this.price,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  dynamic deletedAt;
  int? subFeature1;
  int? subFeature2;
  String? price;
  String? quantity;
  dynamic createdAt;
  dynamic updatedAt;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    subFeature1: json["subfeature_1"] ?? 0,
    subFeature2: json["subfeature_2"] ?? 0,
    price: json["price"] ?? '',
    quantity: json["quantity"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
  );
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
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    subFeature: json["subfeature"] ?? '',
    imagePath: json["image_path"] ?? '',
  );
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
  OfferPivot pivot;

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
    pivot: OfferPivot.fromJson(json["pivot"]),
  );
}

class OfferPivot {
  OfferPivot({
    required this.product,
    required this.offer,
  });

  int? product;
  int? offer;

  factory OfferPivot.fromJson(Map<String, dynamic> json) => OfferPivot(
    product: json["product"] ?? '',
    offer: json["offer"] ?? '',
  );
}

