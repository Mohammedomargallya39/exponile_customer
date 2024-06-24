import 'package:equatable/equatable.dart';

class AddRateEntity extends Equatable {
  final String? message;

  const AddRateEntity({
    required this.message,
  });

  @override
  List<Object?> get props => [
    message,
      ];
}

