import 'package:equatable/equatable.dart';

class OrdersEntity extends Equatable {
  final int success;
  final String message;
  final Data data;

  const OrdersEntity({
    required this.success,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
  ];
}

class Data {
  Orders? orders;
  String? status;
  String? fawryId;

  Data({
    this.orders,
    this.status,
    this.fawryId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
    status: json["status"],
    fawryId: json["fawry_id"],
  );
}

class Orders {
  int? currentPage;
  Map<String, List<Datum>>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Orders({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    currentPage: json["current_page"],
    data: Map.from(json["data"]!).map((k, v) => MapEntry<String, List<Datum>>(k, List<Datum>.from(v.map((x) => Datum.fromJson(x))))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );
}

class Datum {
  int? id;
  int? customer;
  int? address;
  String? orderNumber;
  String? totalAmount;
  String? subTotal;
  String? shippingAmount;
  dynamic promoCode;
  dynamic promoAmount;
  String? discountValue;
  String? productsSubtotal;
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
  String? status;
  DateTime? statusDate;
  OrderCurrentPaymentStatus? orderCurrentPaymentStatus;
  dynamic getShop;
  List<dynamic>? ratings;
  String? name;
  String? shopName;

  Datum({
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
    this.status,
    this.statusDate,
    this.orderCurrentPaymentStatus,
    this.getShop,
    this.ratings,
    this.name,
    this.shopName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    status: json["status"]!,
    statusDate: json["status_date"] == null ? null : DateTime.parse(json["status_date"]),
    orderCurrentPaymentStatus: json["order_current_payment_status"] == null ? null : OrderCurrentPaymentStatus.fromJson(json["order_current_payment_status"]),
    getShop: json["get_shop"],
    ratings: json["ratings"] == null ? [] : List<dynamic>.from(json["ratings"]!.map((x) => x)),
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
    name: json["name"]!,
    allowedCompany: json["allowed_company"],
    allowedFreelance: json["allowed_freelance"],
    defaultCompany: json["default_company"],
    defaultFreelance: json["default_freelance"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    logo: json["logo"]!,
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

class OrderCurrentPaymentStatus {
  int? id;
  int? order;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderCurrentPaymentStatus({
    this.id,
    this.order,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderCurrentPaymentStatus.fromJson(Map<String, dynamic> json) => OrderCurrentPaymentStatus(
    id: json["id"],
    order: json["order"],
    status: json["status"]!,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );
}
