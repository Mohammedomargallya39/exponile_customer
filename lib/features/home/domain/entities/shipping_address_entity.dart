import 'package:equatable/equatable.dart';

class GetShippingAddressFeesEntity extends Equatable {
  final int? success;
  final String? message;
  final Data data;

  const GetShippingAddressFeesEntity({
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
  ShopsCart? shopsCart;

  Data({
    this.shopsCart,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    shopsCart: json["shopsCart"] == null ? null : ShopsCart.fromJson(json["shopsCart"]),
  );
}

class ShopsCart {
  dynamic storesSubtotal;
  dynamic storesDiscounts;
  dynamic storesPromoAmount;
  dynamic totalCarts;
  dynamic totalShipping;
  dynamic cartTotalWithShipping;
  NotAvailableItems? notAvailableItems;

  ShopsCart({
    this.storesSubtotal,
    this.storesDiscounts,
    this.storesPromoAmount,
    this.totalCarts,
    this.totalShipping,
    this.cartTotalWithShipping,
    this.notAvailableItems,
  });

  factory ShopsCart.fromJson(Map<String, dynamic> json) => ShopsCart(
    storesSubtotal: json["stores_subtotal"],
    storesDiscounts: json["stores_discounts"],
    storesPromoAmount: json["stores_promo_amount"],
    totalCarts: json["totalCarts"],
    totalShipping: json["totalShipping"],
    cartTotalWithShipping: json["cartTotalWithShipping"],
    notAvailableItems: json["notAvailableItems"] == null ? null : NotAvailableItems.fromJson(json["notAvailableItems"]),
  );
}

class NotAvailableItems {
  List<dynamic>? products;
  List<dynamic>? offers;

  NotAvailableItems({
    this.products,
    this.offers,
  });

  factory NotAvailableItems.fromJson(Map<String, dynamic> json) => NotAvailableItems(
    products: json["products"] == null ? [] : List<dynamic>.from(json["products"]!.map((x) => x)),
    offers: json["offers"] == null ? [] : List<dynamic>.from(json["offers"]!.map((x) => x)),
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

class Product {
  int? id;
  int? shop;
  int? customer;
  int? pId;
  dynamic oId;
  String? pType;
  int? cat;
  String? image;
  String? slug;
  int? qty;
  String? f1;
  String? f2;
  String? price;
  String? oldPrice;
  dynamic promoCode;
  dynamic promoAmountDiscount;
  dynamic oValue;
  dynamic oType;
  String? name;
  String? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? cartId;
  int? shopBranchesDeliveryMethodsId;
  int? warehouseId;
  int? deliveryMethodId;
  String? skuCode;
  String? weight;
  int? featureId;
  int? shopBranchesWarehouseMethodsId;
  int? f1Id;
  String? pf1;
  int? f2Id;
  String? pf2;
  int? productSubtotal;
  String? imagePath;

  Product({
    this.id,
    this.shop,
    this.customer,
    this.pId,
    this.oId,
    this.pType,
    this.cat,
    this.image,
    this.slug,
    this.qty,
    this.f1,
    this.f2,
    this.price,
    this.oldPrice,
    this.promoCode,
    this.promoAmountDiscount,
    this.oValue,
    this.oType,
    this.name,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.cartId,
    this.shopBranchesDeliveryMethodsId,
    this.warehouseId,
    this.deliveryMethodId,
    this.skuCode,
    this.weight,
    this.featureId,
    this.shopBranchesWarehouseMethodsId,
    this.f1Id,
    this.pf1,
    this.f2Id,
    this.pf2,
    this.productSubtotal,
    this.imagePath,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    shop: json["shop"],
    customer: json["customer"],
    pId: json["p_id"],
    oId: json["o_id"],
    pType: json["p_type"],
    cat: json["cat"],
    image: json["image"],
    slug: json["slug"],
    qty: json["qty"],
    f1: json["f1"],
    f2: json["f2"],
    price: json["price"],
    oldPrice: json["old_price"],
    promoCode: json["promo_code"],
    promoAmountDiscount: json["promo_amount_discount"],
    oValue: json["o_value"],
    oType: json["o_type"],
    name: json["name"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    cartId: json["cart_id"],
    shopBranchesDeliveryMethodsId: json["shop_branches_delivery_methods_id"],
    warehouseId: json["warehouse_id"],
    deliveryMethodId: json["delivery_method_id"],
    skuCode: json["sku_code"],
    weight: json["weight"],
    featureId: json["feature_id"],
    shopBranchesWarehouseMethodsId: json["shop_branches_warehouse_methods_id"],
    f1Id: json["f1_id"],
    pf1: json["pf1"],
    f2Id: json["f2_id"],
    pf2: json["pf2"],
    productSubtotal: json["ProductSubtotal"],
    imagePath: json["image_path"],
  );
}

