import 'package:equatable/equatable.dart';

class AppInfoEntity extends Equatable {
  final String? merchantVersion;
  final String? merchantAndroidLink;
  final String? merchantIosLink;
  final String? merchantRequired;
  final String? customerVersion;
  final String? customerAndroidLink;
  final String? customerIosLink;
  final String? customerRequired;

  const AppInfoEntity({
    required this.customerAndroidLink,
    required this.customerIosLink,
    required this.customerRequired,
    required this.customerVersion,
    required this.merchantAndroidLink,
    required this.merchantIosLink,
    required this.merchantRequired,
    required this.merchantVersion,
  });

  @override
  List<Object?> get props => [
    customerAndroidLink,
    customerIosLink,
    customerRequired,
    customerVersion,
    merchantAndroidLink,
    merchantIosLink,
    merchantRequired,
    merchantVersion,
      ];
}


