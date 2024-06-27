import 'package:equatable/equatable.dart';

class GetPaymentMethodEntity extends Equatable {
  final int? success;
  final String? message;
  final Data data;

  const GetPaymentMethodEntity({
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
  dynamic fees;

  Data({
    this.fees,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fees: json["fees"],
  );
}
