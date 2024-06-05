import 'package:equatable/equatable.dart';

class AddOfferToCartEntity extends Equatable {
  final int? success;
  final String? message;
  final String? data;

  const AddOfferToCartEntity({
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