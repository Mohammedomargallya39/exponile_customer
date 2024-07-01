import 'package:equatable/equatable.dart';

class FawryPaymentEntity extends Equatable {
  final int? success;
  final String? message;
  final Data data;

  const FawryPaymentEntity({
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
  String? paymentStatus;
  String? purchaseOrderNumber;

  Data({
    required this.paymentStatus,
    required this.purchaseOrderNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paymentStatus: json["payment_status"] ?? '',
    purchaseOrderNumber: json["purchase_order_number"] ?? '',
  );
}


