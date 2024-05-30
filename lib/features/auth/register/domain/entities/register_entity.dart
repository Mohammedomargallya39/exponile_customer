import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final int success;
  final String message;
  final RegisterData? data;

  const RegisterEntity({
    required this.success,
    required this.message,
    required this.data
  });

  @override
  List<Object?> get props => [
      ];
}


class RegisterData extends Equatable {

  final List<String>? emailValidation;
  final List<String>? fullName;
  final List<String>? username;
  final List<String>? password;
  final List<String>? passwordConfirmation;
  final List<String>? mobile;
  final List<String>? whatsMobile;
  final List<String>? shopName;
  final List<String>? shopWhatsMobile;
  final List<String>? city;
  final List<String>? category;
  final List<String>? area;
  final List<String>? terms;
  final List<String>? shopMobile;

  const RegisterData({
    required this.emailValidation,
    required this.fullName,
    required this.username,
    required this.password,
    required this.passwordConfirmation,
    required this.mobile,
    required this.whatsMobile,
    required this.shopName,
    required this.shopWhatsMobile,
    required this.city,
    required this.category,
    required this.area,
    required this.terms,
    required this.shopMobile,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('email')) {
      json['email'] = null;
    }
    if (!json.containsKey('full_name')) {
      json['full_name'] = null;
    }
    if (!json.containsKey('username')) {
      json['username'] = null;
    }
    if (!json.containsKey('password')) {
      json['password'] = null;
    }
    if (!json.containsKey('password_confirmation')) {
      json['password_confirmation'] = null;
    }
    if (!json.containsKey('mobile')) {
      json['mobile'] = null;
    }
    if (!json.containsKey('whats_mobile')) {
      json['whats_mobile'] = null;
    }
    if (!json.containsKey('shop_name')) {
      json['shop_name'] = null;
    }
    if (!json.containsKey('shop_whats_mobile')) {
      json['shop_whats_mobile'] = null;
    }
    if (!json.containsKey('city')) {
      json['city'] = null;
    }
    if (!json.containsKey('category')) {
      json['category'] = null;
    }
    if (!json.containsKey('area')) {
      json['area'] = null;
    }
    if (!json.containsKey('terms')) {
      json['terms'] = null;
    }
    if (!json.containsKey('shop_mobile')) {
      json['shop_mobile'] = null;
    }
    return RegisterData(
      emailValidation: json['email'] != null ? List<String>.from(json['email']) : null,
      fullName: json['full_name'] != null ? List<String>.from(json['full_name']) : null,
      username: json['username'] != null ? List<String>.from(json['username']) : null,
      password: json['password'] != null ? List<String>.from(json['password']) : null,
      passwordConfirmation: json['password_confirmation'] != null ? List<String>.from(json['password_confirmation']) : null,
      mobile: json['mobile'] != null ? List<String>.from(json['mobile']) : null,
      whatsMobile: json['whats_mobile'] != null ? List<String>.from(json['whats_mobile']) : null,
      shopName: json['shop_name'] != null ? List<String>.from(json['shop_name']) : null,
      shopWhatsMobile: json['shop_whats_mobile'] != null ? List<String>.from(json['shop_whats_mobile']) : null,
      city: json['city'] != null ? List<String>.from(json['city']) : null,
      category: json['category'] != null ? List<String>.from(json['category']) : null,
      area: json['area'] != null ? List<String>.from(json['area']) : null,
      terms: json['terms'] != null ? List<String>.from(json['terms']) : null,
      shopMobile: json['shop_mobile'] != null ? List<String>.from(json['shop_mobile']) : null,
    );
  }

  @override
  List<Object?> get props => [
    emailValidation,
  ];
}
