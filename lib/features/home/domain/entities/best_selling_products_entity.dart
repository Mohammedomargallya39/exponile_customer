import 'package:equatable/equatable.dart';

class BestSellingProductsEntity extends Equatable {
  final Category? category;
  final List<Product>? products;

  const BestSellingProductsEntity({
    required this.products,
    required this.category,
  });

  @override
  List<Object?> get props => [
  ];
}

class Category {
  int? id;
  String? name;
  String? slug;
  int? totalProductSales;
  String? bannerPath;

  Category({
    this.id,
    this.name,
    this.slug,
    this.totalProductSales,
    this.bannerPath,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    totalProductSales: json["total_product_sales"],
    bannerPath: json["banner_path"],
  );

}

class Product {
  int? id;
  String? name;
  int? category;
  String? description;
  String? status;
  String? slug;
  String? finalPrice;
  String? originalPrice;
  String? totalSales;
  String? rate;
  List<Image>? images;
  List<dynamic>? ratings;
  Image? firstImage;
  GetCategory? getCategory;
  List<dynamic>? favorites;

  Product({
    this.id,
    this.name,
    this.category,
    this.description,
    this.status,
    this.slug,
    this.finalPrice,
    this.originalPrice,
    this.totalSales,
    this.rate,
    this.images,
    this.ratings,
    this.firstImage,
    this.getCategory,
    this.favorites,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    description: json["description"],
    status: json["status"],
    slug: json["slug"],
    finalPrice: json["final_price"],
    originalPrice: json["original_price"],
    totalSales: json["total_sales"],
    rate: json["rate"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    ratings: json["ratings"] == null ? [] : List<dynamic>.from(json["ratings"]!.map((x) => x)),
    firstImage: json["first_image"] == null ? null : Image.fromJson(json["first_image"]),
    getCategory: json["get_category"] == null ? null : GetCategory.fromJson(json["get_category"]),
    favorites: json["favorites"] == null ? [] : List<dynamic>.from(json["favorites"]!.map((x) => x)),
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