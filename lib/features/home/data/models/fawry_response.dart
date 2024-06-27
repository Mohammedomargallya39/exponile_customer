import 'dart:convert';

FawryResponse fawryResponseFromJson(String str) => FawryResponse.fromJson(json.decode(str));


class FawryResponse {
  String? expirationTime;
  dynamic fawryFees;
  String? orderAmount;
  String? orderStatus;
  String? paymentAmount;
  String? paymentMethod;
  String? referenceNumber;
  dynamic shippingFees;
  dynamic taxes;

  FawryResponse({
    this.expirationTime,
    this.fawryFees,
    this.orderAmount,
    this.orderStatus,
    this.paymentAmount,
    this.paymentMethod,
    this.referenceNumber,
    this.shippingFees,
    this.taxes,
  });

  factory FawryResponse.fromJson(Map<String, dynamic> json) => FawryResponse(
    expirationTime: json["expirationTime"],
    fawryFees: json["fawryFees"],
    orderAmount: json["orderAmount"],
    orderStatus: json["orderStatus"],
    paymentAmount: json["paymentAmount"],
    paymentMethod: json["paymentMethod"],
    referenceNumber: json["referenceNumber"],
    shippingFees: json["shippingFees"],
    taxes: json["taxes"],
  );
}
