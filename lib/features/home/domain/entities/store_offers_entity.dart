import 'package:equatable/equatable.dart';

class StoreOffersEntity extends Equatable {
  final int? success;
  final String? message;
  final Data? data;

  const StoreOffersEntity({
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
    required this.offers,
  });

  Store store;
  List<Offer> offers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    store: Store.fromJson(json["store"]),
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
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
  int? minAmount;
  String? promoCode;
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
    minAmount: json["min_amount"] == null ? null : json["min_amount"] ?? 0,
    promoCode: json["promo_code"] == null ? null : json["promo_code"] ?? 0,
    buyAmount: json["buy_amount"] == null ? null : json["buy_amount"] ?? 0,
    getAmount: json["get_amount"] == null ? null : json["get_amount"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    slug: json["slug"] ?? '',
    category: json["category"] == null ? null : json["category"] ?? 0,
    bannerPath: json["banner_path"] ?? '',
  );
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
}







