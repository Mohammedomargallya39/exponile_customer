import 'package:equatable/equatable.dart';

class AddFavouriteEntity extends Equatable {
  final int? success;
  final String? message;
  final String? data;

  const AddFavouriteEntity({
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