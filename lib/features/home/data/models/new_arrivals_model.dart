import '../../domain/entities/new_arrivals_entity.dart';

class NewArrivalsModel extends NewArrivalsEntity {
  const NewArrivalsModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory NewArrivalsModel.fromJson(Map<String, dynamic> json) {
    return NewArrivalsModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
