import 'package:equatable/equatable.dart';

class ProductCategoryDetailsEntity extends Equatable {
  final int? success;
  final String? message;
  final List<Data> data;

  const ProductCategoryDetailsEntity({
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
    required this.name,
    required this.description,
    required this.basicQuantity,
    required this.basicPrice,
    required this.status,
    required this.launchingDate,
    required this.feature,
    required this.imageFeature,
    required this.publishingDate,
    required this.slug,
    required this.rate,
    required this.ratingsCount,
    required this.getCategory,
    required this.images,
    required this.offers,
  });

  int? id;
  String? name;
  String? description;
  int? basicQuantity;
  String? basicPrice;
  String? status;
  String? launchingDate;
  String? feature;
  String? imageFeature;
  dynamic publishingDate;
  String? slug;
  String? rate;
  int? ratingsCount;
  GetCategory getCategory;
  List<Image> images;
  List<Offer> offers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    description: json["description"] ?? '',
    basicQuantity: json["basic_quantity"] ?? 0,
    basicPrice: json["basic_price"] ?? '',
    status: json["status"] ?? '',
    launchingDate: json["launching_date"] ?? '',
    feature: json["feature"] ?? '',
    imageFeature: json["image_feature"] ?? '',
    publishingDate: DateTime.parse(json["publishing_date"] ?? ''),
    slug: json["slug"] ?? '',
    rate: json["rate"] ?? '',
    ratingsCount: json["ratings_count"] ?? 0,
    getCategory: GetCategory.fromJson(json["getCategory"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
  );
}

class GetCategory {
  GetCategory({
    required this.id,
    required this.name,
    required this.percentage,
    required this.isDeal,
    required this.banner,
    required this.bannerPath,
    required this.slug,
  });

  int? id;
  String? name;
  int? percentage;
  int? isDeal;
  dynamic banner;
  String? bannerPath;
  String? slug;

  factory GetCategory.fromJson(Map<String, dynamic> json) => GetCategory(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    percentage: json["percentage"] ?? 0,
    isDeal: json["isDeal"] ?? 0,
    banner: json["banner"] ?? '',
    bannerPath: json["banner_path"] ?? '',
    slug: json["slug"] ?? '',
  );
}

class Image {
  Image({
    required this.image,
    required this.imagePath,
  });

  String? image;
  String? imagePath;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    image: json["image"] ?? '',
    imagePath: json["image_path"] ?? '',
  );
}

class Offer {
  Offer({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.banner,
    required this.bannerPath,
    required this.setupType,
    required this.value,
    required this.minAmount,
    required this.promoCode,
    required this.buyAmount,
    required this.getAmount,
    required this.slug,
  });

  int? id;
  String? name;
  String? startDate;
  String? endDate;
  String? status;
  String? banner;
  String? bannerPath;
  String? setupType;
  String? value;
  dynamic minAmount;
  dynamic promoCode;
  dynamic buyAmount;
  dynamic getAmount;
  String? slug;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"] ?? '',
    name: json["name"] ?? '',
    startDate: json["start_date"] ?? '',
    endDate: json["end_date"] ?? '',
    status: json["status"] ?? '',
    banner: json["banner"] ?? '',
    bannerPath: json["banner_path"] ?? '',
    setupType: json["setup_type"] ?? '',
    value: json["value"] ?? '',
    minAmount: json["min_amount"] ?? '',
    promoCode: json["promo_code"] ?? '',
    buyAmount: json["buy_amount"] ?? '',
    getAmount: json["get_amount"] ?? '',
    slug: json["slug"] ?? '',
  );
}

class FilterData {
  FilterData({
    required this.rate,
    required this.days,
    required this.discounts,
  });

  Map<String, String> rate;
  Map<String, String> days;
  String? discounts;

  factory FilterData.fromJson(Map<String, dynamic> json) => FilterData(
    rate: Map.from(json["rate"])
        .map((k, v) => MapEntry<String, String>(k, v)),
    days: Map.from(json["days"])
        .map((k, v) => MapEntry<String, String>(k, v)),
    discounts: json["discounts"] ?? '',
  );
}

class Meta {
  Meta({
    required this.currentPage,
    required this.lastPage,
  });

  int? currentPage;
  int? lastPage;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"] ?? 0,
    lastPage: json["last_page"] ?? 0,
  );
}
