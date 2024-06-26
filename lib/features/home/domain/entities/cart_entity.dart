import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int? success;
  final String? message;
  final Data data;

  const CartEntity({
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
    required this.shopsCart,
    required this.totalCarts,
    required this.storesSubtotal,
    required this.storesDiscounts,
    this.storesPromoAmount
  });

  Map<String, ShopsCart> shopsCart;
  String? totalCarts;
  String? storesSubtotal;
  String? storesDiscounts;
  dynamic storesPromoAmount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    shopsCart: Map.from(json["shopsCart"]).map((k, v) {
      return MapEntry<String, ShopsCart>(k, ShopsCart.fromJson(v));
    }
    ),
    totalCarts: json["totalCarts"] ?? '',
    storesSubtotal: json["stores_subtotal"] ?? '',
    storesDiscounts: json["stores_discounts"] ?? '',
    storesPromoAmount: json["stores_promo_amount"] ?? '',
  );
}

class ShopsCart {
  ShopsCart({
    required this.products,
    required this.offers,
    required this.status,
    required this.shop,
    required this.price,
    required this.productStoreTotal,
    required this.storeDiscountValue,
    required this.storeTotalAfterDiscount,
  });

  List<Product> products;
  List<Offer>? offers;
  String? status;
  Shop shop;
  String? price;
  String? productStoreTotal;
  String? storeDiscountValue;
  String? storeTotalAfterDiscount;

  factory ShopsCart.fromJson(Map<String, dynamic> json) => ShopsCart(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    offers: json["offers"] == null ? null : List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
    status: json["status"] ?? '',
    shop: Shop.fromJson(json["shop"]),
    price: json["price"] ?? '',
    productStoreTotal: json["product_store_total"] ?? '',
    storeDiscountValue: json["store_discount_value"] ?? '',
    storeTotalAfterDiscount: json["store_total_afetr_discount"] ?? '',
  );
}

class Product {
  Product({
    required this.id,
    required this.shop,
    required this.customer,
    required this.pId,
    required this.oId,
    required this.pType,
    required this.cat,
    required this.image,
    required this.slug,
    required this.qty,
    required this.f1,
    required this.f2,
    required this.price,
    required this.oldPrice,
    required this.oValue,
    required this.oType,
    required this.deliveryFees,
    required this.name,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.nameEn,
    required this.nameAr,
    required this.f1Id,
    required this.pf1,
    required this.f2Id,
    required this.pf2,
    required this.imagePath,
  });

  int? id;
  int? shop;
  int? customer;
  int? pId;
  int? oId;
  String? pType;
  int? cat;
  String? image;
  String? slug;
  int? qty;
  String? f1;
  String? f2;
  String? price;
  String? oldPrice;
  String? oValue;
  String? oType;
  String? deliveryFees;
  String? name;
  String? status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  String? nameEn;
  String? nameAr;
  int? f1Id;
  String? pf1;
  int? f2Id;
  String? pf2;
  String? imagePath;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] ?? 0,
    shop: json["shop"] ?? 0,
    customer: json["customer"] ?? 0,
    pId: json["p_id"] ?? 0,
    oId: json["o_id"] ?? 0,
    pType: json["p_type"] ?? '',
    cat: json["cat"] ?? 0,
    image: json["image"] ?? '',
    slug: json["slug"] ?? '',
    qty: json["qty"] ?? 0,
    f1: json["f1"] ?? '',
    f2: json["f2"] ?? '',
    price: json["price"] ?? '',
    oldPrice: json["old_price"] ?? '',
    oValue: json["o_value"] ?? '',
    oType: json["o_type"] ?? '',
    deliveryFees: json["delivery_fees"] ?? '',
    name: json["name"] ?? '',
    status: json["status"] ?? '',
    deletedAt: json["deleted_at"] ?? '',
    createdAt:json["created_at"] ?? '',
    //DateTime.parse(json["created_at"] ?? ''),
    updatedAt:json["updated_at"] ?? '',
    //DateTime.parse(json["updated_at"] ?? ''),
    nameEn: json["name_en"] ?? '',
    nameAr: json["name_ar"] ?? '',
    f1Id: json["f1_id"] ?? 0,
    pf1: json["pf1"] ?? '',
    f2Id: json["f2_id"] ?? 0,
    pf2: json["pf2"] ?? '',
    imagePath: json["image_path"] ?? '',
  );
}

class OfferProduct {
  OfferProduct({
    required this.id,
    required this.shop,
    required this.customer,
    required this.pId,
    required this.oId,
    required this.pType,
    required this.cat,
    required this.image,
    required this.imagePath,
    required this.slug,
    required this.qty,
    required this.f1,
    required this.f2,
    required this.price,
    required this.oldPrice,
    required this.oValue,
    required this.oType,
    required this.deliveryFees,
    required this.name,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.nameEn,
    required this.nameAr,
    required this.f1Id,
    required this.pf1,
    required this.f2Id,
    required this.pf2,
    required this.cartOffer,
  });

  int? id;
  int? shop;
  int? customer;
  int? pId;
  int? oId;
  String? pType;
  int? cat;
  String? image;
  String? imagePath;
  String? slug;
  int? qty;
  String? f1;
  String? f2;
  String? price;
  String? oldPrice;
  String? oValue;
  String? oType;
  String? deliveryFees;
  String? name;
  String? status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  String? nameEn;
  String? nameAr;
  int? f1Id;
  String? pf1;
  int? f2Id;
  String? pf2;
  int? cartOffer;
  factory OfferProduct.fromJson(Map<String, dynamic> json) => OfferProduct(
    id: json["id"] ?? 0,
    shop: json["shop"] ?? 0,
    customer: json["customer"] ?? 0,
    pId: json["p_id"] ?? 0,
    oId: json["o_id"] ?? 0,
    pType: json["p_type"] ?? '',
    cat: json["cat"] ?? 0,
    image: json["image"] ?? '',
    imagePath: json["image_path"] ?? '',
    slug: json["slug"] ?? '',
    qty: json["qty"] ?? 0,
    f1: json["f1"] ?? '',
    f2: json["f2"] ?? '',
    price: json["price"] ?? '',
    oldPrice: json["old_price"] ?? '',
    oValue: json["o_value"] ?? '',
    oType: json["o_type"] ?? '',
    deliveryFees: json["delivery_fees"] ?? '',
    name: json["name"] ?? '',
    status: json["status"] ?? '',
    deletedAt: json["deleted_at"] ?? '',
    createdAt: json["created_at"] ?? '',
    //DateTime.parse(json["created_at"] ?? ''),
    updatedAt: json["updated_at"] ?? '',
    //DateTime.parse(json["updated_at"] ?? ''),
    nameEn: json["name_en"] ?? '',
    nameAr: json["name_ar"] ?? '',
    f1Id: json["f1_id"] ?? 0,
    pf1: json["pf1"] ?? '',
    f2Id: json["f2_id"] ?? 0,
    pf2: json["pf2"] ?? '',
    cartOffer: json["cart_offer"] ?? 0,
  );
}

class Offer {
  Offer({
    required this.id,
    required this.shop,
    required this.customer,
    required this.oId,
    required this.value,
    required this.type,
    required this.qty,
    required this.slug,
    required this.price,
    required this.deliveryFees,
    required this.buyAmount,
    required this.getAmount,
    required this.name,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.bannerPath,
    required this.nameEn,
    required this.nameAr,
    required this.products,
  });

  int? id;
  int? shop;
  int? customer;
  int? oId;
  String? value;
  String? type;
  int? qty;
  String? slug;
  String? price;
  String? deliveryFees;
  String? buyAmount;
  String? getAmount;
  String? name;
  String? status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  String? image;
  String? bannerPath;
  String? nameEn;
  String? nameAr;
  List<OfferProduct> products;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"] ?? 0,
    shop: json["shop"] ?? 0,
    customer: json["customer"] ?? 0,
    oId: json["o_id"] ?? 0,
    value: json["value"] ?? '',
    type: json["type"] ?? '',
    qty: json["qty"] ?? 0,
    slug: json["slug"] ?? '',
    price: json["price"] ?? '',
    deliveryFees: json["delivery_fees"] ?? '',
    buyAmount: json["buy_amount"] ?? '',
    getAmount: json["get_amount"] ?? '',
    name: json["name"] ?? '',
    status: json["status"] ?? '',
    deletedAt: json["deleted_at"] ?? '',
    createdAt: json["created_at"] ?? '',
    //DateTime.parse(json["created_at"] ?? ''),
    updatedAt:json["updated_at"] ?? '',
    //DateTime.parse(json["updated_at"] ?? ''),
    image: json["image"] ?? '',
    bannerPath: json["banner_path"] ?? '',
    nameEn: json["name_en"] ?? '',
    nameAr: json["name_ar"] ?? '',
    products: List<OfferProduct>.from(
        json["products"].map((x) => OfferProduct.fromJson(x))),
  );
}

class Shop {
  Shop({
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
    required this.admin,
    required this.rate,
    required this.logoPath,
    required this.bannerPath,
    required this.commercial1Path,
    required this.commercial2Path,
    required this.vat1Path,
    required this.vat2Path,
    required this.ratings,
    required this.categories,
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
  String? commercial1;
  String? commercial2;
  String? vat1;
  String? vat2;
  String? merchantType;
  dynamic createdAt;
  dynamic updatedAt;
  String? slug;
  dynamic admin;
  String? rate;
  String? logoPath;
  String? bannerPath;
  String? commercial1Path;
  String? commercial2Path;
  String? vat1Path;
  String? vat2Path;
  List<Rating>? ratings;
  List<Category> categories;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
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
    createdAt: json["created_at"] ?? '',
    //DateTime.parse(json["created_at"] ?? ''),
    updatedAt:json["updated_at"] ?? '',
    //DateTime.parse(json["updated_at"] ?? ''),
    slug: json["slug"] ?? '',
    admin: json["admin"] ?? '',
    rate: json["rate"] ?? '',
    logoPath: json["logo_path"] ?? '',
    bannerPath: json["banner_path"] ?? '',
    commercial1Path: json["commercial1_path"] ?? '',
    commercial2Path: json["commercial2_path"] ?? '',
    vat1Path: json["vat1_path"] ?? '',
    vat2Path: json["vat2_path"] ?? '',
    ratings: json["ratings"] == null
        ? []
        : List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
    categories: List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x))),
  );
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
  String? banner;
  String? slug;
  int? isDeal;
  int? parent;
  int? percentage;
  String? bannerPath;
  CategoryPivot? pivot;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? 0,
    createdAt: json["created_at"] ?? '',
    //DateTime.parse(json["created_at"] ?? ''),
    updatedAt: json["updated_at"] ?? '',
    //DateTime.parse(json["updated_at"] ?? ''),
    deletedAt: json["deleted_at"] ?? '',
    name: json["name"] ?? '',
    banner: json["banner"] ?? '',
    slug: json["slug"] ?? '',
    isDeal: json["isDeal"] ?? 0,
    parent: json["parent"] ?? 0,
    percentage: json["percentage"] ?? 0,
    bannerPath: json["banner_path"] ?? '',
    pivot: json["pivot"] == null
        ? null
        : CategoryPivot.fromJson(json["pivot"]),
  );
}

class CategoryPivot {
  CategoryPivot({
    required this.shop,
    required this.category,
  });

  int? shop;
  int? category;

  factory CategoryPivot.fromJson(Map<String, dynamic> json) => CategoryPivot(
    shop: json["shop"] ?? 0,
    category: json["category"] ?? 0,
  );
}

class Rating {
  Rating({
    required this.id,
    required this.username,
    required this.email,
    required this.mobile,
    required this.whatsMobile,
    required this.emailVerifiedAt,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.shop,
    required this.provider,
    required this.providerId,
    required this.gender,
    required this.image,
    required this.imagePath,
    required this.pivot,
  });

  int? id;
  String? username;
  String? email;
  String? mobile;
  String? whatsMobile;
  dynamic emailVerifiedAt;
  String? type;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic shop;
  dynamic provider;
  dynamic providerId;
  String? gender;
  dynamic image;
  String? imagePath;
  RatingPivot? pivot;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"] ?? 0,
    username: json["username"] ?? '',
    email: json["email"] ?? '',
    mobile: json["mobile"] ?? '',
    whatsMobile: json["whats_mobile"] ?? '',
    emailVerifiedAt: json["email_verified_at"] ?? '',
    //DateTime.parse(json["email_verified_at"] ?? ''),
    type: json["type"] ?? '',
    createdAt:json["created_at"] ?? '',
    //DateTime.parse(json["created_at"] ?? ''),
    updatedAt: json["updated_at"] ?? '',
    //DateTime.parse(json["updated_at"] ?? ''),
    deletedAt: json["deleted_at"] ?? '',
    shop: json["shop"] ?? '',
    provider: json["provider"] ?? '',
    providerId: json["provider_id"] ?? '',
    gender: json["gender"] ?? '',
    image: json["image"] ?? '',
    imagePath: json["image_path"] ?? '',
    pivot:
    json["pivot"] == null ? null : RatingPivot.fromJson(json["pivot"]),
  );
}

class RatingPivot {
  RatingPivot({
    required this.shop,
    required this.user,
  });

  int? shop;
  int? user;

  factory RatingPivot.fromJson(Map<String, dynamic> json) => RatingPivot(
    shop: json["shop"] ?? 0,
    user: json["user"] ?? 0,
  );
}

