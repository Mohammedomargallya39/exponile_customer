import 'package:equatable/equatable.dart';

class PromoCodeEntity extends Equatable {
  final int? success;
  final String? message;
  final Data data;

  const PromoCodeEntity({
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
    required this.status,
    required this.message,
    required this.shop,
    required this.amount,
    required this.shipping,
    required this.subtotal,
    required this.totalWithShipping,
    required this.totalWithoutShipping,
  });

  String? status;
  String? message;
  int? shop;
  String? amount;
  String? shipping;
  String? subtotal;
  String? totalWithShipping;
  String? totalWithoutShipping;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"] ?? '',
    message: json["message"] ?? '',
    shop: json["shop"] ?? 0,
    amount: json["amount"] ?? '',
    shipping: json["shipping"] ?? '',
    subtotal: json["subtotal"] ?? '',
    totalWithShipping: json["total_with_shipping"] ?? '',
    totalWithoutShipping: json["total_without_shipping"] ?? '',
  );
}


