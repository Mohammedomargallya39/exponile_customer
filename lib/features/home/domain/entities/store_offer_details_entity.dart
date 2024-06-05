import 'package:equatable/equatable.dart';

class StoreOfferDetailsEntity extends Equatable {
  final int? success;
  final String? message;
  final Data? data;

  const StoreOfferDetailsEntity({
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
  Offer? offer;
  List<Product>? products;

  Data({
    this.offer,
    this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );
}

class Offer {
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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? slug;
  dynamic category;
  String? bannerPath;
  GetType? getType;
  dynamic getCategory;
  GetShop? getShop;
  OfferPivot? pivot;

  Offer({
    this.id,
    this.shop,
    this.type,
    this.name,
    this.startDate,
    this.endDate,
    this.status,
    this.banner,
    this.setupType,
    this.value,
    this.minAmount,
    this.promoCode,
    this.buyAmount,
    this.getAmount,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.category,
    this.bannerPath,
    this.getType,
    this.getCategory,
    this.getShop,
    this.pivot,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    shop: json["shop"],
    type: json["type"],
    name: json["name"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    status: json["status"],
    banner: json["banner"],
    setupType: json["setup_type"],
    value: json["value"],
    minAmount: json["min_amount"],
    promoCode: json["promo_code"],
    buyAmount: json["buy_amount"],
    getAmount: json["get_amount"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    slug: json["slug"],
    category: json["category"],
    bannerPath: json["banner_path"],
    getType: json["get_type"] == null ? null : GetType.fromJson(json["get_type"]),
    getCategory: json["get_category"],
    getShop: json["get_shop"] == null ? null : GetShop.fromJson(json["get_shop"]),
    pivot: json["pivot"] == null ? null : OfferPivot.fromJson(json["pivot"]),
  );
}

class GetShop {
  int? id;
  dynamic deletedAt;
  int? user;
  String? shopName;
  String? email;
  String? mobile;
  String? whatsMobile;
  String? logo;
  String? banner;
  String? merchantType;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? slug;
  dynamic admin;
  int? firstUpdate;
  int? deliveryBoy;
  String? commercial;
  String? vat;
  int? percentageOnline;
  dynamic maxValueOnline;
  dynamic minValueOnline;
  dynamic fixedAmountOnline;
  dynamic percentageCod;
  dynamic maxValueCod;
  dynamic minValueCod;
  dynamic fixedAmountCod;
  int? campaign;
  String? rate;
  String? logoPath;
  String? bannerPath;
  String? commercialPath;
  String? vatPath;
  List<Category>? categories;
  List<dynamic>? favorites;
  List<dynamic>? ratings;

  GetShop({
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
    this.ratings,
  });

  factory GetShop.fromJson(Map<String, dynamic> json) => GetShop(
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
    ratings: json["ratings"] == null ? [] : List<dynamic>.from(json["ratings"]!.map((x) => x)),
  );
}

class Category {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  dynamic banner;
  String? slug;
  int? isDeal;
  int? parent;
  int? allowBosta;
  dynamic returnDays;
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
  GetCategoryPivot? pivot;

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
    pivot: json["pivot"] == null ? null : GetCategoryPivot.fromJson(json["pivot"]),
  );
}

class GetCategoryPivot {
  int? shop;
  int? category;

  GetCategoryPivot({
    this.shop,
    this.category,
  });

  factory GetCategoryPivot.fromJson(Map<String, dynamic> json) => GetCategoryPivot(
    shop: json["shop"],
    category: json["category"],
  );
}

class GetType {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  String? description;

  GetType({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.description,
  });

  factory GetType.fromJson(Map<String, dynamic> json) => GetType(
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    name: json["name"],
    description: json["description"],
  );
}

class OfferPivot {
  int? product;
  int? offer;

  OfferPivot({
    this.product,
    this.offer,
  });

  factory OfferPivot.fromJson(Map<String, dynamic> json) => OfferPivot(
    product: json["product"],
    offer: json["offer"],
  );
}

class Product {
  int? id;
  dynamic deletedAt;
  int? shop;
  int? category;
  dynamic subCategory;
  String? name;
  String? description;
  String? feature;
  String? status;
  dynamic launchingDate;
  DateTime? publishingDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic imageFeature;
  String? slug;
  dynamic basicHeight;
  dynamic basicWeight;
  int? firstUpdate;
  int? shopWarehouseId;
  String? basicPrice;
  int? basicQuantity;
  String? nameEn;
  String? nameAr;
  String? rate;
  List<Image>? images;
  List<dynamic>? ratings;
  Category? getCategory;
  Feature1? feature1;
  List<Offer>? offers;
  List<dynamic>? favorites;

  Product({
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
    this.basicPrice,
    this.basicQuantity,
    this.nameEn,
    this.nameAr,
    this.rate,
    this.images,
    this.ratings,
    this.getCategory,
    this.feature1,
    this.offers,
    this.favorites,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    basicPrice: json["basic_price"],
    basicQuantity: json["basic_quantity"],
    nameEn: json["name_en"],
    nameAr: json["name_ar"],
    rate: json["rate"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    ratings: json["ratings"] == null ? [] : List<dynamic>.from(json["ratings"]!.map((x) => x)),
    getCategory: json["get_category"] == null ? null : Category.fromJson(json["get_category"]),
    feature1: json["feature1"] == null ? null : Feature1.fromJson(json["feature1"]),
    offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
    favorites: json["favorites"] == null ? [] : List<dynamic>.from(json["favorites"]!.map((x) => x)),
  );
}

class Feature1 {
  int? id;
  dynamic deletedAt;
  int? product;
  int? feature;
  dynamic name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Feature1({
    this.id,
    this.deletedAt,
    this.product,
    this.feature,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Feature1.fromJson(Map<String, dynamic> json) => Feature1(
    id: json["id"],
    deletedAt: json["deleted_at"],
    product: json["product"],
    feature: json["feature"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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







