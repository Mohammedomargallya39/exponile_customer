import 'package:equatable/equatable.dart';

class LandingEntity extends Equatable {
  final int? success;
  final String? message;
  final Data data;

  const LandingEntity({
    required this.success,
    required this.message,
    required this.data
  });

  @override
  List<Object?> get props => [
  ];
}

class Data {
  Data({
    required this.banners,
    required this.categories,
    required this.products,
    required this.brands,
    required this.count,
    required this.mapUrl,
  });

  List<Banner> banners;
  List<Category> categories;
  List<Products> products;
  List<Brand> brands;
  int? count;
  String? mapUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      banners:
      List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
      categories: List<Category>.from(
          json["categories"].map((x) => Category.fromJson(x))),
      products: List<Products>.from(
          json["products"].map((x) => Products.fromJson(x))),
      brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
      count: json["count"] ?? 0,
      mapUrl: json["map_url"] ?? '');
}

class Banner {
  Banner({
    required this.banner,
    required this.title,
    required this.text,
    required this.link,
    required this.bannerPath,
  });

  String? banner;
  String? title;
  String? text;
  String? link;
  String? bannerPath;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    banner: json["banner"] ?? '',
    title: json["title"] ?? '',
    text: json["text"] ?? '',
    link: json["link"] ?? '',
    bannerPath: json["banner_path"] ?? '',
  );
}

class Brand {
  Brand({
    required this.getShop,
  });
  GetShop getShop;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    getShop: GetShop.fromJson(json["getShop"]),
  );
}

class GetShop {
  GetShop(
      {required this.id,
        required this.shopName,
        required this.slug,
        required this.logoPath,
        required this.favoritesCount,
        required this.categories});
  int? id;
  String? shopName;
  String? slug;
  String? logoPath;
  int? favoritesCount;
  List<GetShopCategories> categories;

  factory GetShop.fromJson(Map<String, dynamic> json) => GetShop(
      id: json["id"] ?? 0,
      shopName: json["shop_name"] ?? '',
      slug: json["slug"] ?? '',
      logoPath: json["logo_path"] ?? '',
      favoritesCount: json["favorites_count"] ?? 0,
      categories: List<GetShopCategories>.from(
          json["categories"].map((x) => GetShopCategories.fromJson(x))));
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? bannerPath;
  int? upTo;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.bannerPath,
    required this.upTo,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      slug: json["slug"] ?? '',
      bannerPath: json["banner_path"] ?? '',
      upTo: json["upto"] ?? 0);
}

class Products {
  int? id;
  String? name;
  String? basicPrice;
  String? feature;
  String? slug;
  String? rate;
  int? ratingCount;
  int? favoritesCount;
  GetCategory getCategory;
  List<ProductImages>? images;
  List<Offers>? offers;

  Products(
      {required this.id,
        required this.name,
        required this.basicPrice,
        required this.feature,
        required this.slug,
        required this.rate,
        required this.ratingCount,
        required this.favoritesCount,
        required this.getCategory,
        required this.images,
        required this.offers});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      basicPrice: json["basic_price"] ?? '',
      feature: json["feature"] ?? '',
      slug: json["slug"] ?? '',
      rate: json["rate"] ?? '',
      ratingCount: json["ratings_count"] ?? 0,
      favoritesCount: json["favorites_count"] ?? 0,
      getCategory: GetCategory.fromJson(json["getCategory"]),
      images: json["images"] == null
          ? null
          : List<ProductImages>.from(
          json["images"].map((x) => ProductImages.fromJson(x))),
      offers: json["offers"] == null
          ? null
          : List<Offers>.from(json["offers"].map((x) => Offers.fromJson(x))));
}

class GetCategory {
  String? name;
  String? slug;

  GetCategory({required this.name, required this.slug});

  factory GetCategory.fromJson(Map<String, dynamic> json) =>
      GetCategory(name: json["name"] ?? '', slug: json["slug"] ?? '');
}

class ProductImages {
  String? image;
  String? imagePath;

  ProductImages({required this.image, required this.imagePath});

  factory ProductImages.fromJson(Map<String, dynamic> json) => ProductImages(
      image: json["image"] ?? '', imagePath: json["image_path"] ?? '');
}

class Offers {
  String? value;

  Offers({required this.value});

  factory Offers.fromJson(Map<String, dynamic> json) =>
      Offers(value: json["value"] ?? '');
}

class GetShopCategories {
  String? name;
  String? slug;

  GetShopCategories({
    required this.name,
    required this.slug,
  });

  factory GetShopCategories.fromJson(Map<String, dynamic> json) =>
      GetShopCategories(name: json["name"] ?? '', slug: json["slug"] ?? '');
}