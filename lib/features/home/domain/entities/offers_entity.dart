import 'package:equatable/equatable.dart';

class OffersEntity extends Equatable {
  final int success;
  final String message;
  final Data data;

  const OffersEntity({
    required this.success,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
  ];
}

class Data {
  Offers? offers;

  Data({
    required this.offers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    offers: json["offers"] == null ? null :Offers.fromJson(json["offers"]),
  );
}

class Offers {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Offers({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Offers.fromJson(Map<String, dynamic> json) => Offers(
    currentPage: json["current_page"]??0,
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"]??'',
    from: json["from"]??0,
    lastPage: json["last_page"]??0,
    lastPageUrl: json["last_page_url"]??'',
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"]??'',
    path: json["path"]??'',
    perPage: json["per_page"]??0,
    prevPageUrl: json["prev_page_url"]??'',
    to: json["to"]??0,
    total: json["total"]??0,
  );
}

class Datum {
  int id;
  dynamic deletedAt;
  int user;
  String shopName;
  String email;
  String mobile;
  String whatsMobile;
  String logo;
  String banner;
  String merchantType;
  DateTime createdAt;
  DateTime updatedAt;
  String slug;
  dynamic admin;
  int firstUpdate;
  int deliveryBoy;
  String commercial;
  String vat;
  int percentageOnline;
  dynamic maxValueOnline;
  dynamic minValueOnline;
  dynamic fixedAmountOnline;
  dynamic percentageCod;
  dynamic maxValueCod;
  dynamic minValueCod;
  dynamic fixedAmountCod;
  int campaign;
  String rate;
  String logoPath;
  String bannerPath;
  String commercialPath;
  String vatPath;
  List<dynamic> favorites;

  Datum({
    required this.id,
    required this.deletedAt,
    required this.user,
    required this.shopName,
    required this.email,
    required this.mobile,
    required this.whatsMobile,
    required this.logo,
    required this.banner,
    required this.merchantType,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.admin,
    required this.firstUpdate,
    required this.deliveryBoy,
    required this.commercial,
    required this.vat,
    required this.percentageOnline,
    required this.maxValueOnline,
    required this.minValueOnline,
    required this.fixedAmountOnline,
    required this.percentageCod,
    required this.maxValueCod,
    required this.minValueCod,
    required this.fixedAmountCod,
    required this.campaign,
    required this.rate,
    required this.logoPath,
    required this.bannerPath,
    required this.commercialPath,
    required this.vatPath,
    required this.favorites,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"]??0,
    deletedAt: json["deleted_at"] ,
    user: json["user"]??0,
    shopName: json["shop_name"]??'',
    email: json["email"]??'',
    mobile: json["mobile"]??'',
    whatsMobile: json["whats_mobile"]??'',
    logo: json["logo"]??'',
    banner: json["banner"]??'',
    merchantType: json["merchant_type"]??'',
    createdAt: DateTime.parse(json["created_at"]) ,
    updatedAt: DateTime.parse(json["updated_at"]) ,
    slug: json["slug"]??'',
    admin: json["admin"] ,
    firstUpdate: json["first_update"]??0,
    deliveryBoy: json["delivery_boy"]??0,
    commercial: json["commercial"]??'',
    vat: json["vat"]??'',
    percentageOnline: json["percentage_online"]??0,
    maxValueOnline: json["max_value_online"] ,
    minValueOnline: json["min_value_online"] ,
    fixedAmountOnline: json["fixed_amount_online"] ,
    percentageCod: json["percentage_cod"] ,
    maxValueCod: json["max_value_cod"] ,
    minValueCod: json["min_value_cod"] ,
    fixedAmountCod: json["fixed_amount_cod"] ,
    campaign: json["campaign"]??0,
    rate: json["rate"]??'',
    logoPath: json["logo_path"]??'',
    bannerPath: json["banner_path"]??'',
    commercialPath: json["commercial_path"]??'',
    vatPath: json["vat_path"]??'',
    favorites: List<dynamic>.from(json["favorites"].map((x) => x)) ,
  );
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"]??'',
    label: json["label"]??'',
    active: json["active"]??false,
  );
}
