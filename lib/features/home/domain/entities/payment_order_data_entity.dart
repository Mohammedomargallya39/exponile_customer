import 'package:equatable/equatable.dart';

class PaymentOrderDataEntity extends Equatable {
  final int? success;
  final String? message;
  final Data? data;

  const PaymentOrderDataEntity({
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
  PaymentRequest? paymentRequest;

  Data({
    this.paymentRequest,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      paymentRequest: json["paymentRequest"] == null ? null : PaymentRequest.fromJson(json["paymentRequest"]),
    );
  }
}

class PaymentRequest {
  String? merchantCode;
  String? merchantRefNum;
  String? customerMobile;
  String? customerEmail;
  String? customerName;
  String? paymentExpiry;
  String? customerProfileId;
  String? language;
  List<ChargeItem>? chargeItems;
  String? paymentMethod;
  String? returnUrl;
  String? signature;

  PaymentRequest({
    this.merchantCode,
    this.merchantRefNum,
    this.customerMobile,
    this.customerEmail,
    this.customerName,
    this.paymentExpiry,
    this.customerProfileId,
    this.language,
    this.chargeItems,
    this.paymentMethod,
    this.returnUrl,
    this.signature,
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
    merchantCode: json["merchantCode"],
    merchantRefNum: json["merchantRefNum"],
    customerMobile: json["customerMobile"],
    customerEmail: json["customerEmail"],
    customerName: json["customerName"],
    paymentExpiry: json["paymentExpiry"],
    customerProfileId: json["customerProfileId"],
    language: json["language"],
    chargeItems: json["chargeItems"] == null ? [] : List<ChargeItem>.from(json["chargeItems"]!.map((x) => ChargeItem.fromJson(x))),
    paymentMethod: json["paymentMethod"],
    returnUrl: json["returnUrl"],
    signature: json["signature"],
  );
}

class ChargeItem {
  String? itemId;
  String? description;
  String? price;
  int? quantity;

  ChargeItem({
    this.itemId,
    this.description,
    this.price,
    this.quantity,
  });

  factory ChargeItem.fromJson(Map<String, dynamic> json) => ChargeItem(
    itemId: json["itemId"],
    description: json["description"],
    price: json["price"],
    quantity: json["quantity"],
  );
}