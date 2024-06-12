import 'package:equatable/equatable.dart';

class HotDealsEntity extends Equatable {
  final int success;
  final String message;
  final Data data;

  const HotDealsEntity({
    required this.success,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
  ];
}

class Data {
  Products? products;
  String? selectedSort;
  dynamic categoryArray;
  dynamic storeCategory;

  Data({
    this.products,
    this.selectedSort,
    this.categoryArray,
    this.storeCategory,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: json["products"] == null ? null : Products.fromJson(json["products"]),
    selectedSort: json["selectedSort"],
    categoryArray: json["categoryArray"],
    storeCategory: json["storeCategory"],
  );
}

class Products {
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

  Products({
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

  factory Products.fromJson(Map<String, dynamic> json) => Products(
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
  int? shop;
  int? category;
  dynamic subCategory;
  String? name;
  String? description;
  String? feature;
  String? status;
  String? launchingDate;
  DateTime? publishingDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic imageFeature;
  String? slug;
  dynamic basicHeight;
  dynamic basicWeight;
  int? firstUpdate;
  int? shopWarehouseId;
  String? finalPrice;
  String? originalPrice;
  String? rate;
  List<Image>? images;
  List<dynamic>? ratings;
  Image? firstImage;
  GetCategory? getCategory;
  List<Favorite>? favorites;

  Datum({
    this.id,
    this.deletedAt,
    this.shop,
    this.category,
    this.subCategory,
    this.name,
    this.description,
    this.feature,
    this.status,
    this.launchingDate,
    this.publishingDate,
    this.createdAt,
    this.updatedAt,
    this.imageFeature,
    this.slug,
    this.basicHeight,
    this.basicWeight,
    this.firstUpdate,
    this.shopWarehouseId,
    this.finalPrice,
    this.originalPrice,
    this.rate,
    this.images,
    this.ratings,
    this.firstImage,
    this.getCategory,
    this.favorites,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    deletedAt: json["deleted_at"],
    shop: json["shop"],
    category: json["category"],
    subCategory: json["subCategory"],
    name: json["name"],
    description: json["description"],
    feature: json["feature"],
    status: json["status"],
    launchingDate: json["launching_date"],
    publishingDate: json["publishing_date"] == null ? null : DateTime.parse(json["publishing_date"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    imageFeature: json["image_feature"],
    slug: json["slug"],
    basicHeight: json["basic_height"],
    basicWeight: json["basic_weight"],
    firstUpdate: json["first_update"],
    shopWarehouseId: json["shop_warehouse_id"],
    finalPrice: json["final_price"],
    originalPrice: json["original_price"],
    rate: json["rate"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    ratings: json["ratings"] == null ? [] : List<dynamic>.from(json["ratings"]!.map((x) => x)),
    firstImage: json["first_image"] == null ? null : Image.fromJson(json["first_image"]),
    getCategory: json["get_category"] == null ? null : GetCategory.fromJson(json["get_category"]),
    favorites: json["favorites"] == null ? [] : List<Favorite>.from(json["favorites"]!.map((x) => Favorite.fromJson(x))),
  );
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
  dynamic percentageOnline;
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