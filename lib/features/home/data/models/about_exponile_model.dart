import '../../domain/entities/about_exponile_entity.dart';

class AboutExponileModel extends AboutExponileEntity {
  const AboutExponileModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory AboutExponileModel.fromJson(Map<String, dynamic> json) {
    return AboutExponileModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
