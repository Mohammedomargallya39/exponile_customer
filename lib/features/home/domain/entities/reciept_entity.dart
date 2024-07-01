import 'package:equatable/equatable.dart';

class ReceiptEntity extends Equatable {
  final UserAddress? userAddress;
  final PaymentMethod? paymentMethod;
  final Customer? customer;
  final List<Order>? orders;
  final String? purchaseOrderNumber;
  final DateTime? date;

  const ReceiptEntity({
    required this.userAddress,
    required this.paymentMethod,
    required this.customer,
    required this.orders,
    required this.purchaseOrderNumber,
    required this.date,
  });

  @override
  List<Object?> get props => [
    userAddress,
    paymentMethod,
    customer,
    orders,
    purchaseOrderNumber,
    date,
      ];
}

class Customer {
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? mobile;
  String? whatsMobile;
  DateTime? emailVerifiedAt;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? shop;
  dynamic provider;
  dynamic providerId;
  dynamic gender;
  dynamic image;
  int? mobileVerification;
  dynamic otp;
  String? wallet;
  dynamic emailWaiting;
  String? imagePath;

  Customer({
    this.id,
    this.username,
    this.fullName,
    this.email,
    this.mobile,
    this.whatsMobile,
    this.emailVerifiedAt,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.shop,
    this.provider,
    this.providerId,
    this.gender,
    this.image,
    this.mobileVerification,
    this.otp,
    this.wallet,
    this.emailWaiting,
    this.imagePath,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    username: json["username"],
    fullName: json["full_name"],
    email: json["email"],
    mobile: json["mobile"],
    whatsMobile: json["whats_mobile"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    type: json["type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    shop: json["shop"],
    provider: json["provider"],
    providerId: json["provider_id"],
    gender: json["gender"],
    image: json["image"],
    mobileVerification: json["mobile_verification"],
    otp: json["otp"],
    wallet: json["wallet"],
    emailWaiting: json["email_waiting"],
    imagePath: json["image_path"],
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
  PaymentMethod? paymentMethod;
  int? deliveryMethod;
  dynamic employeeId;
  String? orderWeight;
  String? totalAmountAfterDiscount;
  int? warehouseMethod;
  List<OrderDetail>? orderDetails;
  OrderCurrentEntStatus? orderCurrentPaymentStatus;
  OrderCurrentEntStatus? orderCurrentStatus;
  dynamic getShop;
  UserAddress? userAddress;
  Customer? getCustomer;
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
    this.orderDetails,
    this.orderCurrentPaymentStatus,
    this.orderCurrentStatus,
    this.getShop,
    this.userAddress,
    this.getCustomer,
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
    paymentMethod: json["payment_method"] == null ? null : PaymentMethod.fromJson(json["payment_method"]),
    deliveryMethod: json["delivery_method"],
    employeeId: json["employee_id"],
    orderWeight: json["order_weight"],
    totalAmountAfterDiscount: json["total_amount_after_discount"],
    warehouseMethod: json["warehouse_method"],
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
    orderCurrentPaymentStatus: json["order_current_payment_status"] == null ? null : OrderCurrentEntStatus.fromJson(json["order_current_payment_status"]),
    orderCurrentStatus: json["order_current_status"] == null ? null : OrderCurrentEntStatus.fromJson(json["order_current_status"]),
    getShop: json["get_shop"],
    userAddress: json["user_address"] == null ? null : UserAddress.fromJson(json["user_address"]),
    getCustomer: json["get_customer"] == null ? null : Customer.fromJson(json["get_customer"]),
    name: json["name"],
    shopName: json["shop_name"],
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
  );
}

class PaymentMethod {
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
  int? requiredCompany;
  int? requiredFreelance;
  String? link;
  int? isActive;
  dynamic cashOnDelivery;
  dynamic maxAmount;
  String? logoPath;

  PaymentMethod({
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
    this.cashOnDelivery,
    this.maxAmount,
    this.logoPath,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
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
    cashOnDelivery: json["cash_on_delivery"],
    maxAmount: json["max_amount"],
    logoPath: json["logo_path"],
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


