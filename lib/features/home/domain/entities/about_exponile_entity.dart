import 'package:equatable/equatable.dart';

class AboutExponileEntity extends Equatable {
  final int? success;
  final String? message;
  final Data? data;

  const AboutExponileEntity({
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
    required this.address,
    required this.email,
    required this.phone,
  });

  String? address;
  String? email;
  String? phone;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    address: json["address"] ?? '',
    email: json["email"] ?? '',
    phone: json["phone"] ?? '',
  );
}