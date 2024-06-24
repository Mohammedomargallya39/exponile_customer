
import '../../domain/entities/add_rate_entity.dart';

class AddRateModel extends AddRateEntity {
  const AddRateModel({
    required super.message,
  });

  factory AddRateModel.fromJson(Map<String, dynamic> json) {
    return AddRateModel(
      message: json['message'],
    );
  }
}
