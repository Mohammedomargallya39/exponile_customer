
import '../../domain/entities/app_info_entity.dart';

class AppInfoModel extends AppInfoEntity {
  const AppInfoModel({
    required super.customerAndroidLink,
    required super.customerIosLink,
    required super.customerRequired,
    required super.customerVersion,
    required super.merchantAndroidLink,
    required super.merchantIosLink,
    required super.merchantRequired,
    required super.merchantVersion,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) {
    return AppInfoModel(
      customerAndroidLink: json['customer_android_link'],
      customerIosLink: json['customer_ios_link'],
      customerRequired: json['customer_required'],
      customerVersion: json['customer_version'],
      merchantAndroidLink: json['merchant_android_link'],
      merchantIosLink: json['merchant_ios_link'],
      merchantRequired: json['merchant_required'],
      merchantVersion: json['merchant_version'],
    );
  }
}
