import 'package:equatable/equatable.dart';

class BestSellersStoresEntity extends Equatable {
  final int success;
  final String message;
  final Data data;

  const BestSellersStoresEntity({
    required this.success,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
  ];
}

class Data {
  Stores? stores;
  Categories? categories;
  dynamic selectedSort;
  List<dynamic>? storeCategory;
  dynamic offerFilter;
  Map<String, String>? offerTypes;

  Data({
    this.stores,
    this.categories,
    this.selectedSort,
    this.storeCategory,
    this.offerFilter,
    this.offerTypes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    stores: json["stores"] == null ? null : Stores.fromJson(json["stores"]),
    categories: json["categories"] == null ? null : Categories.fromJson(json["categories"]),
    selectedSort: json["selectedSort"],
    storeCategory: json["storeCategory"] == null ? [] : List<dynamic>.from(json["storeCategory"]!.map((x) => x)),
    offerFilter: json["offerFilter"],
    offerTypes: Map.from(json["offerTypes"]!).map((k, v) => MapEntry<String, String>(k, v)),
  );
}

class Categories {
  String? fashion;
  String? accessories;
  String? homeKithchen;
  String? stationaryAndBooks;
  String? healthBeauty;
  String? games;
  String? electronics;
  String? ngoProducts;

  Categories({
    this.fashion,
    this.accessories,
    this.homeKithchen,
    this.stationaryAndBooks,
    this.healthBeauty,
    this.games,
    this.electronics,
    this.ngoProducts,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    fashion: json["fashion"],
    accessories: json["accessories"],
    homeKithchen: json["home-kithchen"],
    stationaryAndBooks: json["stationary-and-books"],
    healthBeauty: json["health-beauty"],
    games: json["games"],
    electronics: json["electronics"],
    ngoProducts: json["ngo-products"],
  );
}

class Stores {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Stores({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );
}

class Datum {
  int? id;
  dynamic deletedAt;
  int? user;
  String? shopName;
  String? email;
  String? mobile;
  String? whatsMobile;
  dynamic logo;
  dynamic banner;
  String? merchantType;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? slug;
  dynamic admin;
  int? firstUpdate;
  int? deliveryBoy;
  dynamic commercial;
  dynamic vat;
  dynamic percentageOnline;
  dynamic maxValueOnline;
  dynamic minValueOnline;
  int? fixedAmountOnline;
  dynamic percentageCod;
  dynamic maxValueCod;
  dynamic minValueCod;
  int? fixedAmountCod;
  int? campaign;
  String? rate;
  String? logoPath;
  String? bannerPath;
  String? commercialPath;
  String? vatPath;
  List<Category>? categories;
  List<dynamic>? favorites;

  Datum({
    this.id,
    this.deletedAt,
    this.user,
    this.shopName,
    this.email,
    this.mobile,
    this.whatsMobile,
    this.logo,
    this.banner,
    this.merchantType,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.admin,
    this.firstUpdate,
    this.deliveryBoy,
    this.commercial,
    this.vat,
    this.percentageOnline,
    this.maxValueOnline,
    this.minValueOnline,
    this.fixedAmountOnline,
    this.percentageCod,
    this.maxValueCod,
    this.minValueCod,
    this.fixedAmountCod,
    this.campaign,
    this.rate,
    this.logoPath,
    this.bannerPath,
    this.commercialPath,
    this.vatPath,
    this.categories,
    this.favorites,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    deletedAt: json["deleted_at"],
    user: json["user"],
    shopName: json["shop_name"],
    email: json["email"],
    mobile: json["mobile"],
    whatsMobile: json["whats_mobile"],
    logo: json["logo"],
    banner: json["banner"],
    merchantType: json["merchant_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    slug: json["slug"],
    admin: json["admin"],
    firstUpdate: json["first_update"],
    deliveryBoy: json["delivery_boy"],
    commercial: json["commercial"],
    vat: json["vat"],
    percentageOnline: json["percentage_online"],
    maxValueOnline: json["max_value_online"],
    minValueOnline: json["min_value_online"],
    fixedAmountOnline: json["fixed_amount_online"],
    percentageCod: json["percentage_cod"],
    maxValueCod: json["max_value_cod"],
    minValueCod: json["min_value_cod"],
    fixedAmountCod: json["fixed_amount_cod"],
    campaign: json["campaign"],
    rate: json["rate"],
    logoPath: json["logo_path"],
    bannerPath: json["banner_path"],
    commercialPath: json["commercial_path"],
    vatPath: json["vat_path"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    favorites: json["favorites"] == null ? [] : List<dynamic>.from(json["favorites"]!.map((x) => x)),
  );
}

class Category {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  String? banner;
  String? slug;
  int? isDeal;
  dynamic parent;
  int? allowBosta;
  int? returnDays;
  dynamic percentageOnline;
  dynamic maxValueOnline;
  dynamic minValueOnline;
  int? fixedAmountOnline;
  dynamic percentageCod;
  dynamic maxValueCod;
  dynamic minValueCod;
  int? fixedAmountCod;
  dynamic symbol;
  String? bannerPath;
  Pivot? pivot;

  Category({
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
    this.pivot,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );
}

class Pivot {
  int? shop;
  int? category;

  Pivot({
    this.shop,
    this.category,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    shop: json["shop"],
    category: json["category"],
  );
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );
}