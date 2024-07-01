import 'package:equatable/equatable.dart';

class OrderReceiptEntity extends Equatable {
  final int? success;
  final String? message;
  final Data data;

  const OrderReceiptEntity({
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
  String? available;

  Data({
    required this.available,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    available: json["available"] ?? '',
  );
//
// Map<String, dynamic> toJson() => {
//       "available": available,
//     };
}


