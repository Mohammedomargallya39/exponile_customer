import 'package:equatable/equatable.dart';

class CheckOutViewEntity extends Equatable {
  final int? success;
  final String? message;
  final Data data;

  const CheckOutViewEntity({
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
  Map<String, dynamic>? shopsCart;
  List<Address>? addresses;
  dynamic currentAddress;
  List<CustomerPaymentMethods>? customerPaymentMethods;
  dynamic storesSubtotal;
  dynamic storesDiscounts;
  dynamic storesPromoAmount;
  dynamic totalCarts;
  dynamic subtotal;

  Data({
    this.shopsCart,
    this.addresses,
    this.currentAddress,
    this.customerPaymentMethods,
    this.storesSubtotal,
    this.storesDiscounts,
    this.storesPromoAmount,
    this.totalCarts,
    this.subtotal,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    bool containsNumber(String input) {
      return RegExp(r'\d').hasMatch(input);
    }

    return Data(
      shopsCart: Map.from(json["shopsCart"]).map((k, v) {
        if (!containsNumber(k)) {
          return MapEntry<String, dynamic>(k, v);
        } else {
          return MapEntry<String, ShopsData>(k, ShopsData.fromJson(v));
        }
      }),
      addresses: json["addresses"] == null ? [] : List<Address>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
      currentAddress: json["currentAddress"],
      customerPaymentMethods: json["customerPaymentMethods"] == null ? [] : List<CustomerPaymentMethods>.from(json["customerPaymentMethods"]!.map((x) => CustomerPaymentMethods.fromJson(x))),
      storesSubtotal: json["stores_subtotal"],
      storesDiscounts: json["stores_discounts"],
      storesPromoAmount: json["stores_promo_amount"],
      totalCarts: json["totalCarts"],
      subtotal: json["subtotal"],
    );
  }
}

class ShopsData {
  int? orderWeight;
  List<Product>? products;
  Map<String,dynamic>? warehouseMethod;
  Map<String,dynamic>? deliveryMethod;
  List<Offer>? offers;

  ShopsData({
    this.orderWeight,
    this.products,
    this.warehouseMethod,
    this.deliveryMethod,
    this.offers,
  });

  factory ShopsData.fromJson(Map<String, dynamic> json) {
    final offersJson = json["offers"];
    List<Offer>? offersList;
    if (offersJson != null && offersJson is List) {
      offersList = List<Offer>.from(offersJson.map((x) => Offer.fromJson(x)));
    }
    return ShopsData(
      orderWeight: json["order_weight"],
      products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
      offers: offersList,
      warehouseMethod: json["warehouseMethod"],
      deliveryMethod: json["deliveryMethod"],
    );
  }
}

class Address {
  int? id;
  dynamic deletedAt;
  int? user;
  int? governorate;
  int? area;
  String? governorateName;
  String? areaName;
  String? lat;
  String? long;
  String? streetName;
  String? buildingName;
  String? landmark;
  int? floorNo;
  int? aptNo;
  dynamic postalNo;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  GetArea? getArea;
  GetGovernorate? getGovernorate;

  Address({
    this.id,
    this.deletedAt,
    this.user,
    this.governorate,
    this.area,
    this.governorateName,
    this.areaName,
    this.lat,
    this.long,
    this.streetName,
    this.buildingName,
    this.landmark,
    this.floorNo,
    this.aptNo,
    this.postalNo,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.getArea,
    this.getGovernorate,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    deletedAt: json["deleted_at"],
    user: json["user"],
    governorate: json["governorate"],
    area: json["area"],
    governorateName: json["governorate_name"],
    areaName: json["area_name"],
    lat: json["lat"],
    long: json["long"],
    streetName: json["street_name"],
    buildingName: json["building_name"],
    landmark: json["landmark"],
    floorNo: json["floor_no"],
    aptNo: json["apt_no"],
    postalNo: json["postal_no"],
    type: json["type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    getArea: json["get_area"] == null ? null : GetArea.fromJson(json["get_area"]),
    getGovernorate: json["get_governorate"] == null ? null : GetGovernorate.fromJson(json["get_governorate"]),
  );
}

class GetArea {
  int? id;
  String? name;
  String? areaId;
  String? areaDeliveryHubCode;
  String? areaPickupHubCode;
  int? showAsPickupArea;
  int? showAsDropoffArea;
  int? city;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? lat;
  String? long;

  GetArea({
    this.id,
    this.name,
    this.areaId,
    this.areaDeliveryHubCode,
    this.areaPickupHubCode,
    this.showAsPickupArea,
    this.showAsDropoffArea,
    this.city,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.lat,
    this.long,
  });

  factory GetArea.fromJson(Map<String, dynamic> json) => GetArea(
    id: json["id"],
    name: json["name"],
    areaId: json["area_id"],
    areaDeliveryHubCode: json["area_delivery_hub_code"],
    areaPickupHubCode: json["area_pickup_hub_code"],
    showAsPickupArea: json["show_as_pickup_area"],
    showAsDropoffArea: json["show_as_dropoff_area"],
    city: json["city"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    lat: json["lat"],
    long: json["long"],
  );
}

class GetGovernorate {
  int? id;
  String? name;
  String? govId;
  String? govDeliveryHubCode;
  String? govPickupHubCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  GetGovernorate({
    this.id,
    this.name,
    this.govId,
    this.govDeliveryHubCode,
    this.govPickupHubCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory GetGovernorate.fromJson(Map<String, dynamic> json) => GetGovernorate(
    id: json["id"],
    name: json["name"],
    govId: json["gov_id"],
    govDeliveryHubCode: json["gov_delivery_hub_code"],
    govPickupHubCode: json["gov_pickup_hub_code"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );
}

class Method {
  int? id;
  String? name;
  int? isExponile;
  int? allowedMerchantWarehouse;
  int? isActive;
  String? link;
  int? isDelivery;
  int? isUnique;
  int? requiredCompany;
  int? requiredFreelance;
  int? allowedCompany;
  int? allowedFreelance;
  int? defaultCompany;
  int? defaultFreelance;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? logo;
  String? logoPath;



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
    this.requiredCompany,
    this.requiredFreelance,
    this.link,
    this.isActive,
    this.logoPath,
    this.isDelivery,
    this.isUnique,
    this.isExponile,
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
    requiredCompany: json["required_company"],
    requiredFreelance: json["required_freelance"],
    link: json["link"],
    isActive: json["is_active"],
    logoPath: json["logo_path"],
    isDelivery: json["is_delivery"],
    isUnique: json["is_unique"],
    isExponile: json["is_exponile"],
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
  dynamic productSubtotal;
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

  dynamic id;
  dynamic shop;
  dynamic customer;
  dynamic pId;
  dynamic oId;
  dynamic pType;
  dynamic cat;
  dynamic image;
  dynamic imagePath;
  dynamic slug;
  dynamic qty;
  dynamic f1;
  dynamic f2;
  dynamic price;
  dynamic oldPrice;
  dynamic oValue;
  dynamic oType;
  dynamic deliveryFees;
  dynamic name;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic nameEn;
  dynamic nameAr;
  dynamic f1Id;
  dynamic pf1;
  dynamic f2Id;
  dynamic pf2;
  dynamic cartOffer;
  factory OfferProduct.fromJson(Map<String, dynamic> json) => OfferProduct(
    id: json["id"],
    shop: json["shop"],
    customer: json["customer"],
    pId: json["p_id"],
    oId: json["o_id"],
    pType: json["p_type"],
    cat: json["cat"],
    image: json["image"],
    imagePath: json["image_path"],
    slug: json["slug"],
    qty: json["qty"],
    f1: json["f1"],
    f2: json["f2"],
    price: json["price"],
    oldPrice: json["old_price"],
    oValue: json["o_value"],
    oType: json["o_type"],
    deliveryFees: json["delivery_fees"],
    name: json["name"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    nameEn: json["name_en"],
    nameAr: json["name_ar"],
    f1Id: json["f1_id"],
    pf1: json["pf1"],
    f2Id: json["f2_id"],
    pf2: json["pf2"],
    cartOffer: json["cart_offer"],
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

  dynamic id;
  dynamic shop;
  dynamic customer;
  dynamic oId;
  dynamic value;
  dynamic type;
  dynamic qty;
  dynamic slug;
  dynamic price;
  dynamic deliveryFees;
  dynamic buyAmount;
  dynamic getAmount;
  dynamic name;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic image;
  dynamic bannerPath;
  dynamic nameEn;
  dynamic nameAr;
  List<OfferProduct> products;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    shop: json["shop"],
    customer: json["customer"],
    oId: json["o_id"],
    value: json["value"],
    type: json["type"],
    qty: json["qty"],
    slug: json["slug"],
    price: json["price"],
    deliveryFees: json["delivery_fees"],
    buyAmount: json["buy_amount"],
    getAmount: json["get_amount"],
    name: json["name"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    image: json["image"],
    bannerPath: json["banner_path"],
    nameEn: json["name_en"],
    nameAr: json["name_ar"],
    products: List<OfferProduct>.from(
        json["products"].map((x) => OfferProduct.fromJson(x))),
  );
}

class CustomerPaymentMethods {
  int? id;
  int? allowedCompany;
  int? allowedFreelance;
  int? defaultCompany;
  int? defaultFreelance;
  int? requiredCompany;
  int? requiredFreelance;
  int? isActive;
  String? name;
  String? logo;
  String? link;
  String? logoPath;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic cashOnDelivery;
  dynamic maxAmount;

  CustomerPaymentMethods({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.logoPath,
    this.maxAmount,
    this.cashOnDelivery,
    this.logo,
    this .link,
    this.allowedCompany,
    this.allowedFreelance,
    this.defaultCompany,
    this.defaultFreelance,
    this.isActive,
    this.requiredCompany,
    this.requiredFreelance
  });

  factory CustomerPaymentMethods.fromJson(Map<String, dynamic> json) => CustomerPaymentMethods(
    id: json["id"],
    name: json["name"],
    maxAmount: json["max_amount"],
    cashOnDelivery: json["cash_on_delivery"],
    logoPath: json["logo_path"],
    allowedCompany: json["allowed_company"],
    allowedFreelance: json["allowed_freelance"],
    defaultCompany: json["default_company"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    defaultFreelance: json["default_freelance"],
    isActive: json["is_active"],
    link: json["link"],
    logo: json["logo"],
    requiredCompany: json["required_company"],
    requiredFreelance: json["required_freelance"],
  );
}

