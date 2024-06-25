import 'package:equatable/equatable.dart';

class StoreCategoryDetailsEntity extends Equatable {
  final int? success;
  final String? message;
  final Data data;

  const StoreCategoryDetailsEntity({
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
    required this.stores,
    required this.categories,
  });

  Stores stores;
  Categories categories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    stores: Stores.fromJson(json["stores"]),
    categories: Categories.fromJson(json["categories"]),
  );

// Map<String, dynamic> toJson() => {
//       "stores": stores.toJson(),
//       "categories": categories.toJson(),
//     };
}

class Categories {
  Categories({
    required this.hypermarket,
    required this.jewelryWatches,
    required this.fitness,
    required this.healthBeauty,
    required this.departmentStores,
    required this.entertainments,
    required this.dining,
    required this.specialtyStores,
    required this.fashion,
    required this.electronics,
  });

  String? hypermarket;
  String? jewelryWatches;
  String? fitness;
  String? healthBeauty;
  String? departmentStores;
  String? entertainments;
  String? dining;
  String? specialtyStores;
  String? fashion;
  String? electronics;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    hypermarket: json["hypermarket"] ?? '',
    jewelryWatches: json["jewelry-watches"] ?? '',
    fitness: json["fitness"] ?? '',
    healthBeauty: json["health-beauty"] ?? '',
    departmentStores: json["department-stores"] ?? '',
    entertainments: json["entertainments"] ?? '',
    dining: json["dining"],
    specialtyStores: json["specialty-stores"] ?? '',
    fashion: json["fashion"] ?? '',
    electronics: json["electronics"] ?? '',
  );

// Map<String, dynamic> toJson() => {
//       "hypermarket": hypermarket,
//       "jewelry-watches": jewelryWatches,
//       "fitness": fitness,
//       "health-beauty": healthBeauty,
//       "department-stores": departmentStores,
//       "entertainments": entertainments,
//       "dining": dining,
//       "specialty-stores": specialtyStores,
//       "fashion": fashion,
//       "electronics": electronics,
//     };
}

class Category {
  Category({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.banner,
    required this.slug,
    required this.isDeal,
    required this.parent,
    required this.percentage,
    required this.bannerPath,
    required this.pivot,
  });

  int? id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String? name;
  dynamic banner;
  String? slug;
  int? isDeal;
  int? parent;
  int? percentage;
  String? bannerPath;
  Pivot pivot;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? 0,
    createdAt: DateTime.parse(json["created_at"] ?? ''),
    updatedAt: DateTime.parse(json["updated_at"] ?? ''),
    deletedAt: json["deleted_at"] ?? '',
    name: json["name"] ?? '',
    banner: json["banner"] ?? '',
    slug: json["slug"] ?? '',
    isDeal: json["isDeal"] ?? 0,
    parent: json["parent"] ?? 0,
    percentage: json["percentage"] ?? 0,
    bannerPath: json["banner_path"] ?? '',
    pivot: Pivot.fromJson(json["pivot"] ?? ''),
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
//       "deleted_at": deletedAt,
//       "name": name,
//       "banner": banner,
//       "slug": slug,
//       "isDeal": isDeal,
//       "parent": parent,
//       "percentage": percentage,
//       "banner_path": bannerPath,
//       "pivot": pivot.toJson(),
//     };
}

class Pivot {
  Pivot({
    required this.shop,
    required this.category,
  });

  int shop;
  int category;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    shop: json["shop"],
    category: json["category"],
  );

// Map<String, dynamic> toJson() => {
//       "shop": shop,
//       "category": category,
//     };
}

class Stores {
  int currentPage;
  List<Datum> data;
  int lastPage;

  Stores({
    required this.currentPage,
    required this.data,
    required this.lastPage,
  });

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    lastPage: json["last_page"],
  );

// Map<String, dynamic> toJson() => {
//       "current_page": currentPage,
//       "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       "last_page": lastPage,
//     };
}

class Datum {
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
  List<Category> categories;
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
    required this.categories,
    required this.favorites,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? 0,
    deletedAt: json["deleted_at"] ?? '',
    user: json["user"] ?? 0,
    shopName: json["shop_name"] ?? '',
    email: json["email"],
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
    categories: List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x))),
    favorites: List<dynamic>.from(json["favorites"].map((x) => x)),
  );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "deleted_at": deletedAt,
//       "user": user,
//       "shop_name": shopName,
//       "email": email,
//       "mobile": mobile,
//       "whats_mobile": whatsMobile,
//       "logo": logo,
//       "banner": banner,
//       "commercial1": commercial1,
//       "commercial2": commercial2,
//       "vat1": vat1,
//       "vat2": vat2,
//       "merchant_type": merchantType,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
//       "slug": slug,
//       "rate": rate,
//       "logo_path": logoPath,
//       "banner_path": bannerPath,
//       "commercial1_path": commercial1Path,
//       "commercial2_path": commercial2Path,
//       "vat1_path": vat1Path,
//       "vat2_path": vat2Path,
//       "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
//       "favorites": List<dynamic>.from(favorites.map((x) => x)),
//     };
}
