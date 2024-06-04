import 'package:equatable/equatable.dart';

class ProductDetailsEntity extends Equatable {
  final int? success;
  final String? message;
  final Data? data;

  const ProductDetailsEntity({
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
  Product? product;
  List<FeaturesDetail>? featuresDetails;

  Data({
    this.product,
    this.featuresDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    featuresDetails: json["features_details"] == null ? [] : List<FeaturesDetail>.from(json["features_details"]!.map((x) => FeaturesDetail.fromJson(x))),
  );
}

class FeaturesDetail {
  int? id;
  dynamic deletedAt;
  int? subfeature1;
  int? subfeature2;
  String? price;
  String? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? skuCode;
  int? product;
  String? weight;
  int? reorderQuantity;
  dynamic transactionDate;
  int? packageType;
  String? totalQuantity;
  GetSubfeature? getSubfeature1;
  GetSubfeature? getSubfeature2;

  FeaturesDetail({
    this.id,
    this.deletedAt,
    this.subfeature1,
    this.subfeature2,
    this.price,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.skuCode,
    this.product,
    this.weight,
    this.reorderQuantity,
    this.transactionDate,
    this.packageType,
    this.totalQuantity,
    this.getSubfeature1,
    this.getSubfeature2,
  });

  factory FeaturesDetail.fromJson(Map<String, dynamic> json) => FeaturesDetail(
    id: json["id"],
    deletedAt: json["deleted_at"],
    subfeature1: json["subfeature_1"],
    subfeature2: json["subfeature_2"],
    price: json["price"],
    quantity: json["quantity"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    skuCode: json["sku_code"],
    product: json["product"],
    weight: json["weight"],
    reorderQuantity: json["reorder_quantity"],
    transactionDate: json["TransactionDate"],
    packageType: json["package_type"],
    totalQuantity: json["total_quantity"],
    getSubfeature1: json["get_subfeature1"] == null ? null : GetSubfeature.fromJson(json["get_subfeature1"]),
    getSubfeature2: json["get_subfeature2"] == null ? null : GetSubfeature.fromJson(json["get_subfeature2"]),
  );
}

class GetSubfeature {
  int? id;
  dynamic deletedAt;
  int? feature;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  GetSubfeature1GetFeature? getFeature;

  GetSubfeature({
    this.id,
    this.deletedAt,
    this.feature,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.getFeature,
  });

  factory GetSubfeature.fromJson(Map<String, dynamic> json) => GetSubfeature(
    id: json["id"],
    deletedAt: json["deleted_at"],
    feature: json["feature"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    getFeature: json["get_feature"] == null ? null : GetSubfeature1GetFeature.fromJson(json["get_feature"]),
  );
}

class GetSubfeature1GetFeature {
  int? id;
  dynamic deletedAt;
  int? product;
  int? feature;
  dynamic name;
  DateTime? createdAt;
  DateTime? updatedAt;
  GetFeatureGetFeature? getFeature;

  GetSubfeature1GetFeature({
    this.id,
    this.deletedAt,
    this.product,
    this.feature,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.getFeature,
  });

  factory GetSubfeature1GetFeature.fromJson(Map<String, dynamic> json) => GetSubfeature1GetFeature(
    id: json["id"],
    deletedAt: json["deleted_at"],
    product: json["product"],
    feature: json["feature"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    getFeature: json["get_feature"] == null ? null : GetFeatureGetFeature.fromJson(json["get_feature"]),
  );
}

class GetFeatureGetFeature {
  int? id;
  dynamic deletedAt;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetFeatureGetFeature({
    this.id,
    this.deletedAt,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory GetFeatureGetFeature.fromJson(Map<String, dynamic> json) => GetFeatureGetFeature(
    id: json["id"],
    deletedAt: json["deleted_at"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
  String? launchingDate;
  DateTime? publishingDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic imageFeature;
  String? slug;
  dynamic basicHeight;
  dynamic basicWeight;
  int? firstUpdate;
  int? shopBranchesDeliveryMethodsId;
  int? shopBranchesWarehouseMethodsId;
  String? rate;
  GetWarehouse? getWarehouse;
  Get? getDelivery;
  GetCategory? getCategory;
  dynamic getSubCategory;
  List<Image>? images;
  List<dynamic>? ratings;

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
    this.shopBranchesDeliveryMethodsId,
    this.shopBranchesWarehouseMethodsId,
    this.rate,
    this.getWarehouse,
    this.getDelivery,
    this.getCategory,
    this.getSubCategory,
    this.images,
    this.ratings,
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
    shopBranchesDeliveryMethodsId: json["shop_branches_delivery_methods_id"],
    shopBranchesWarehouseMethodsId: json["shop_branches_warehouse_methods_id"],
    rate: json["rate"],
    getWarehouse: json["get_warehouse"] == null ? null : GetWarehouse.fromJson(json["get_warehouse"]),
    getDelivery: json["get_delivery"] == null ? null : Get.fromJson(json["get_delivery"]),
    getCategory: json["get_category"] == null ? null : GetCategory.fromJson(json["get_category"]),
    getSubCategory: json["get_sub_category"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    ratings: json["ratings"] == null ? [] : List<dynamic>.from(json["ratings"]!.map((x) => x)),
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

class Get {
  int? id;
  dynamic deletedAt;
  int? method;
  int? shopWarehouseMethodId;
  int? branch;
  DateTime? createdAt;
  DateTime? updatedAt;
  Get? getShopMethod;
  int? shop;
  Method? getMethod;

  Get({
    this.id,
    this.deletedAt,
    this.method,
    this.shopWarehouseMethodId,
    this.branch,
    this.createdAt,
    this.updatedAt,
    this.getShopMethod,
    this.shop,
    this.getMethod,
  });

  factory Get.fromJson(Map<String, dynamic> json) => Get(
    id: json["id"],
    deletedAt: json["deleted_at"],
    method: json["method"],
    shopWarehouseMethodId: json["shop_warehouse_method_id"],
    branch: json["branch"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    getShopMethod: json["get_shop_method"] == null ? null : Get.fromJson(json["get_shop_method"]),
    shop: json["shop"],
    getMethod: json["get_method"] == null ? null : Method.fromJson(json["get_method"]),
  );
}

class Method {
  int? id;
  dynamic deletedAt;
  String? name;
  int? allowedCompany;
  int? allowedFreelance;
  int? defaultCompany;
  int? defaultFreelance;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? logo;
  int? isDelivery;
  int? isUnique;
  int? requiredCompany;
  int? requiredFreelance;
  int? isExponile;
  String? link;
  int? isActive;
  String? logoPath;
  int? allowedMerchantWarehouse;

  Method({
    this.id,
    this.deletedAt,
    this.name,
    this.allowedCompany,
    this.allowedFreelance,
    this.defaultCompany,
    this.defaultFreelance,
    this.createdAt,
    this.updatedAt,
    this.logo,
    this.isDelivery,
    this.isUnique,
    this.requiredCompany,
    this.requiredFreelance,
    this.isExponile,
    this.link,
    this.isActive,
    this.logoPath,
    this.allowedMerchantWarehouse,
  });

  factory Method.fromJson(Map<String, dynamic> json) => Method(
    id: json["id"],
    deletedAt: json["deleted_at"],
    name: json["name"],
    allowedCompany: json["allowed_company"],
    allowedFreelance: json["allowed_freelance"],
    defaultCompany: json["default_company"],
    defaultFreelance: json["default_freelance"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    logo: json["logo"],
    isDelivery: json["is_delivery"],
    isUnique: json["is_unique"],
    requiredCompany: json["required_company"],
    requiredFreelance: json["required_freelance"],
    isExponile: json["is_exponile"],
    link: json["link"],
    isActive: json["is_active"],
    logoPath: json["logo_path"],
    allowedMerchantWarehouse: json["allowed_merchant_warehouse"],
  );
}

class GetWarehouse {
  int? id;
  int? shopWarehouseMethodId;
  int? branchId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Method? shopWarehouseMethod;

  GetWarehouse({
    this.id,
    this.shopWarehouseMethodId,
    this.branchId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.shopWarehouseMethod,
  });

  factory GetWarehouse.fromJson(Map<String, dynamic> json) => GetWarehouse(
    id: json["id"],
    shopWarehouseMethodId: json["shop_warehouse_method_id"],
    branchId: json["branch_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    shopWarehouseMethod: json["shop_warehouse_method"] == null ? null : Method.fromJson(json["shop_warehouse_method"]),
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
    imagePath: json["image_path"] ?? '',
  );
}







