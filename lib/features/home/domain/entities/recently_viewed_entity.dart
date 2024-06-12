import 'package:equatable/equatable.dart';

class RecentlyViewedEntity extends Equatable {
  final int? id;
  final dynamic deletedAt;
  final int? shop;
  final int? category;
  final int? subCategory;
  final String? name;
  final String? description;
  final String? feature;
  final String? status;
  final String? launchingDate;
  final DateTime? publishingDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic imageFeature;
  final String? slug;
  final dynamic basicHeight;
  final dynamic basicWeight;
  final int? firstUpdate;
  final int? shopWarehouseId;
  final String? finalPrice;
  final String? originalPrice;
  final String? rate;
  final List<Image>? images;
  final List<dynamic>? ratings;
  final Image? firstImage;
  final GetCategory? getCategory;
  final List<Favorite>? favorites;

  const RecentlyViewedEntity({
    required this.id,
    required this.deletedAt,
    required this.shop,
    required this.category,
    required this.subCategory,
    required this.name,
    required this.description,
    required this.feature,
    required this.status,
    required this.launchingDate,
    required this.publishingDate,
    required this.createdAt,
    required this.updatedAt,
    required this.imageFeature,
    required this.slug,
    required this.basicHeight,
    required this.basicWeight,
    required this.firstUpdate,
    required this.shopWarehouseId,
    required this.finalPrice,
    required this.originalPrice,
    required this.rate,
    required this.images,
    required this.ratings,
    required this.firstImage,
    required this.getCategory,
    required this.favorites,
  });

  @override
  List<Object?> get props => [
  ];
}

class Favorite {
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
  Pivot? pivot;

  Favorite({
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
    this.pivot,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json["id"],
    username: json["username"],
    fullName: json["full_name"],
    email: json["email"],
    mobile: json["mobile"],
    whatsMobile: json["whats_mobile"],
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
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );
}

class Pivot {
  int? product;
  int? user;

  Pivot({
    this.product,
    this.user,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    product: json["product"],
    user: json["user"],
  );
}

class Image {
  int? id;
  dynamic deletedAt;
  int? product;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? subfeature;
  int? shop;
  String? imagePath;

  Image({
    this.id,
    this.deletedAt,
    this.product,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.subfeature,
    this.shop,
    this.imagePath,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    deletedAt: json["deleted_at"],
    product: json["product"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subfeature: json["subfeature"],
    shop: json["shop"],
    imagePath: json["image_path"],
  );
}

class GetCategory {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  String? banner;
  String? slug;
  int? isDeal;
  int? parent;
  int? allowBosta;
  int? returnDays;
  int? percentageOnline;
  dynamic maxValueOnline;
  dynamic minValueOnline;
  dynamic fixedAmountOnline;
  dynamic percentageCod;
  dynamic maxValueCod;
  dynamic minValueCod;
  dynamic fixedAmountCod;
  dynamic symbol;
  String? bannerPath;

  GetCategory({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.banner,
    this.slug,
    this.isDeal,
    this.parent,
    this.allowBosta,
    this.returnDays,
    this.percentageOnline,
    this.maxValueOnline,
    this.minValueOnline,
    this.fixedAmountOnline,
    this.percentageCod,
    this.maxValueCod,
    this.minValueCod,
    this.fixedAmountCod,
    this.symbol,
    this.bannerPath,
  });

  factory GetCategory.fromJson(Map<String, dynamic> json) => GetCategory(
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    name: json["name"],
    banner: json["banner"],
    slug: json["slug"],
    isDeal: json["isDeal"],
    parent: json["parent"],
    allowBosta: json["allow_bosta"],
    returnDays: json["return_days"],
    percentageOnline: json["percentage_online"],
    maxValueOnline: json["max_value_online"],
    minValueOnline: json["min_value_online"],
    fixedAmountOnline: json["fixed_amount_online"],
    percentageCod: json["percentage_cod"],
    maxValueCod: json["max_value_cod"],
    minValueCod: json["min_value_cod"],
    fixedAmountCod: json["fixed_amount_cod"],
    symbol: json["symbol"],
    bannerPath: json["banner_path"],
  );
}