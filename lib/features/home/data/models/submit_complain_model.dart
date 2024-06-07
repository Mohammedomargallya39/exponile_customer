import '../../domain/entities/submit_complain_entity.dart';

class SubmitComplainModel extends SubmitComplainEntity {
  const SubmitComplainModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory SubmitComplainModel.fromJson(Map<String, dynamic> json) {
    return SubmitComplainModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
