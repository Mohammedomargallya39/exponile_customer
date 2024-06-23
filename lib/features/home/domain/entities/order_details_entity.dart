import 'package:equatable/equatable.dart';

class OrderDetailsEntity extends Equatable {
  final int? success;
  final String? message;
  final Data? data;

  const OrderDetailsEntity({
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
  Order? order;
  QuickComments? quickComments;

  Data({
    this.order,
    this.quickComments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    quickComments: json["quickComments"] == null ? null : QuickComments.fromJson(json["quickComments"]),
  );
}

class Order {
  int? id;
  int? customer;
  int? address;
  String? orderNumber;
  String? totalAmount;
  String? subTotal;
  String? shippingAmount;
  dynamic promoCode;
  dynamic promoAmount;
  dynamic discountValue;
  dynamic productsSubtotal;
  dynamic transactionNumber;
  dynamic expectedDeliveryTime;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? purchaseOrderNumber;
  Method? paymentMethod;
  Method? deliveryMethod;
  dynamic employeeId;
  String? orderWeight;
  String? totalAmountAfterDiscount;
  int? warehouseMethod;
  dynamic orderComplains;
  List<OrderDetail>? orderDetails;
  OrderCurrentEntStatus? orderCurrentPaymentStatus;
  OrderCurrentEntStatus? orderCurrentStatus;
  dynamic getShop;
  UserAddress? userAddress;
  String? name;
  String? shopName;

  Order({
    this.id,
    this.customer,
    this.address,
    this.orderNumber,
    this.totalAmount,
    this.subTotal,
    this.shippingAmount,
    this.promoCode,
    this.promoAmount,
    this.discountValue,
    this.productsSubtotal,
    this.transactionNumber,
    this.expectedDeliveryTime,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.purchaseOrderNumber,
    this.paymentMethod,
    this.deliveryMethod,
    this.employeeId,
    this.orderWeight,
    this.totalAmountAfterDiscount,
    this.warehouseMethod,
    this.orderComplains,
    this.orderDetails,
    this.orderCurrentPaymentStatus,
    this.orderCurrentStatus,
    this.getShop,
    this.userAddress,
    this.name,
    this.shopName,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    customer: json["customer"],
    address: json["address"],
    orderNumber: json["order_number"],
    totalAmount: json["total_amount"],
    subTotal: json["sub_total"],
    shippingAmount: json["shipping_amount"],
    promoCode: json["promo_code"],
    promoAmount: json["promo_amount"],
    discountValue: json["discount_value"],
    productsSubtotal: json["products_subtotal"],
    transactionNumber: json["transaction_number"],
    expectedDeliveryTime: json["expected_delivery_time"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    purchaseOrderNumber: json["purchase_order_number"],
    paymentMethod: json["payment_method"] == null ? null : Method.fromJson(json["payment_method"]),
    deliveryMethod: json["delivery_method"] == null ? null : Method.fromJson(json["delivery_method"]),
    employeeId: json["employee_id"],
    orderWeight: json["order_weight"],
    totalAmountAfterDiscount: json["total_amount_after_discount"],
    warehouseMethod: json["warehouse_method"],
    orderComplains: json["order_complains"],
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
    orderCurrentPaymentStatus: json["order_current_payment_status"] == null ? null : OrderCurrentEntStatus.fromJson(json["order_current_payment_status"]),
    orderCurrentStatus: json["order_current_status"] == null ? null : OrderCurrentEntStatus.fromJson(json["order_current_status"]),
    getShop: json["get_shop"],
    userAddress: json["user_address"] == null ? null : UserAddress.fromJson(json["user_address"]),
    name: json["name"],
    shopName: json["shop_name"],
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
  dynamic cashOnDelivery;
  dynamic maxAmount;

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
    this.cashOnDelivery,
    this.maxAmount,
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
    cashOnDelivery: json["cash_on_delivery"],
    maxAmount: json["max_amount"],
  );
}

class OrderCurrentEntStatus {
  int? id;
  int? order;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderCurrentEntStatus({
    this.id,
    this.order,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderCurrentEntStatus.fromJson(Map<String, dynamic> json) => OrderCurrentEntStatus(
    id: json["id"],
    order: json["order"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}

class OrderDetail {
  int? id;
  int? order;
  int? offer;
  int? itemId;
  String? itemType;
  String? name;
  String? slug;
  String? price;
  String? oldPrice;
  dynamic deliveryFees;
  int? quantity;
  dynamic itemStatus;
  dynamic productType;
  String? image;
  String? feature1Name;
  String? feature2Name;
  dynamic subFeature1Name;
  dynamic subFeature2Name;
  dynamic offerValue;
  dynamic offerType;
  String? buyAmount;
  String? getAmount;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? subfeatureDetailsId;
  String? shop;
  String? discount;
  String? sku;
  List<OrderOfferDetail>? orderOfferDetails;
  GetProduct? getItemProduct;
  GetItemOffer? getItemOffer;

  OrderDetail({
    this.id,
    this.order,
    this.offer,
    this.itemId,
    this.itemType,
    this.name,
    this.slug,
    this.price,
    this.oldPrice,
    this.deliveryFees,
    this.quantity,
    this.itemStatus,
    this.productType,
    this.image,
    this.feature1Name,
    this.feature2Name,
    this.subFeature1Name,
    this.subFeature2Name,
    this.offerValue,
    this.offerType,
    this.buyAmount,
    this.getAmount,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.subfeatureDetailsId,
    this.shop,
    this.discount,
    this.sku,
    this.orderOfferDetails,
    this.getItemProduct,
    this.getItemOffer,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    order: json["order"],
    offer: json["offer"],
    itemId: json["item_id"],
    itemType: json["item_type"],
    name: json["name"],
    slug: json["slug"],
    price: json["price"],
    oldPrice: json["old_price"],
    deliveryFees: json["delivery_fees"],
    quantity: json["quantity"],
    itemStatus: json["item_status"],
    productType: json["product_type"],
    image: json["image"],
    feature1Name: json["feature_1_name"],
    feature2Name: json["feature_2_name"],
    subFeature1Name: json["sub_feature_1_name"],
    subFeature2Name: json["sub_feature_2_name"],
    offerValue: json["offer_value"],
    offerType: json["offer_type"],
    buyAmount: json["buy_amount"],
    getAmount: json["get_amount"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subfeatureDetailsId: json["subfeature_details_id"],
    shop: json["shop"],
    discount: json["discount"],
    sku: json["sku"],
    orderOfferDetails: json["order_offer_details"] == null ? [] : List<OrderOfferDetail>.from(json["order_offer_details"]!.map((x) => OrderOfferDetail.fromJson(x))),
    getItemProduct: json["get_item_product"] == null ? null : GetProduct.fromJson(json["get_item_product"]),
    getItemOffer: json["get_item_offer"] == null ? null : GetItemOffer.fromJson(json["get_item_offer"]),
  );
}

class GetItemOffer {
  int? id;
  int? shop;
  int? type;
  String? name;
  String? startDate;
  String? endDate;
  String? status;
  String? banner;
  String? setupType;
  dynamic value;
  dynamic minAmount;
  dynamic promoCode;
  int? buyAmount;
  int? getAmount;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? slug;
  int? category;
  int? shopBranchesDeliveryMethodsId;
  int? shopBranchesWarehouseMethodsId;
  String? bannerPath;
  GetCategory? getCategory;

  GetItemOffer({
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
    this.shopBranchesDeliveryMethodsId,
    this.shopBranchesWarehouseMethodsId,
    this.bannerPath,
    this.getCategory,
  });

  factory GetItemOffer.fromJson(Map<String, dynamic> json) => GetItemOffer(
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
    shopBranchesDeliveryMethodsId: json["shop_branches_delivery_methods_id"],
    shopBranchesWarehouseMethodsId: json["shop_branches_warehouse_methods_id"],
    bannerPath: json["banner_path"],
    getCategory: json["get_category"] == null ? null : GetCategory.fromJson(json["get_category"]),
  );
}

class GetCategory {
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

class GetProduct {
  int? id;
  dynamic deletedAt;
  int? shop;
  int? category;
  int? subCategory;
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
  GetCategory? getCategory;
  List<dynamic>? ratings;

  GetProduct({
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
    this.getCategory,
    this.ratings,
  });

  factory GetProduct.fromJson(Map<String, dynamic> json) => GetProduct(
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
    getCategory: json["get_category"] == null ? null : GetCategory.fromJson(json["get_category"]),
    ratings: json["ratings"] == null ? [] : List<dynamic>.from(json["ratings"]!.map((x) => x)),
  );
}

class OrderOfferDetail {
  int? id;
  int? orderDetails;
  int? product;
  String? name;
  dynamic slug;
  String? price;
  String? oldPrice;
  int? quantity;
  dynamic productType;
  String? image;
  String? feature1Name;
  String? feature2Name;
  dynamic subFeature1Name;
  dynamic subFeature2Name;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? subfeatureDetailsId;
  String? skuCode;
  GetProduct? getProduct;

  OrderOfferDetail({
    this.id,
    this.orderDetails,
    this.product,
    this.name,
    this.slug,
    this.price,
    this.oldPrice,
    this.quantity,
    this.productType,
    this.image,
    this.feature1Name,
    this.feature2Name,
    this.subFeature1Name,
    this.subFeature2Name,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.subfeatureDetailsId,
    this.skuCode,
    this.getProduct,
  });

  factory OrderOfferDetail.fromJson(Map<String, dynamic> json) => OrderOfferDetail(
    id: json["id"],
    orderDetails: json["order_details"],
    product: json["product"],
    name: json["name"],
    slug: json["slug"],
    price: json["price"],
    oldPrice: json["old_price"],
    quantity: json["quantity"],
    productType: json["product_type"],
    image: json["image"],
    feature1Name: json["feature_1_name"],
    feature2Name: json["feature_2_name"],
    subFeature1Name: json["sub_feature_1_name"],
    subFeature2Name: json["sub_feature_2_name"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subfeatureDetailsId: json["subfeature_details_id"],
    skuCode: json["sku_code"],
    getProduct: json["get_product"] == null ? null : GetProduct.fromJson(json["get_product"]),
  );
}

class UserAddress {
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

  UserAddress({
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
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
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
  );
}

class QuickComments {
  String? the1;
  String? the2;
  String? the3;
  String? the4;
  String? empty;

  QuickComments({
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.empty,
  });

  factory QuickComments.fromJson(Map<String, dynamic> json) => QuickComments(
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    empty: json[""],
  );
}