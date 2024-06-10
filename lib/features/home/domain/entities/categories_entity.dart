import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable {
  final int? success;
  final String? message;
  final Data data;

  const CategoriesEntity({
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
    required this.storeCats,
    required this.productCats,
  });

  List<StoreCat> storeCats;
  List<ProductCat> productCats;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    storeCats: List<StoreCat>.from(json["store_cats"].map((x)=>StoreCat.fromJson(x))),
    productCats: List<ProductCat>.from(json["product_cats"].map((x) => ProductCat.fromJson(x))),
  );

// Map<String, dynamic> toJson() => {
//       "store_cats": List<dynamic>.from(storeCats.map((x) => x.toJson())),
//       "product_cats": List<dynamic>.from(productCats.map((x) => x.toJson())),
//     };
}

class ProductCat {
  ProductCat({
    required this.name,
    required this.slug,
    required this.bannerPath,
    required this.subCategories,
  });

  String name;
  String slug;
  String bannerPath;
  List<StoreCat>? subCategories;

  factory ProductCat.fromJson(Map<String, dynamic> json) => ProductCat(
      name: json["name"],
      slug: json["slug"],
      bannerPath: json["banner_path"],
      subCategories:json["subCategories"]==null ? null : List<StoreCat>.from(json["subCategories"].map((x)=>StoreCat.fromJson(x)))
  );

// Map<String, dynamic> toJson() => {
//       "name": name,
//       "slug": slug,
//       "banner_path": bannerPath,
//       "subCategories": List<StoreCat>.from(subCategories!.map((e) => e.toJson()))
//     };
}

class StoreCat{
  String name;
  String slug;
  String bannerPath;
  StoreCat({
    required this.name,
    required this.slug,
    required this.bannerPath,
  });

  factory StoreCat.fromJson(Map<String,dynamic> json) => StoreCat(
    name: json["name"],
    slug: json["slug"],
    bannerPath: json["banner_path"],
  );
//
// Map<String,dynamic> toJson() => {
//   "name":name,
//   "slug":slug,
//   "banner_path":bannerPath,
// };

}