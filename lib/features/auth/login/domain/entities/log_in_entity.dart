import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final int? success;
  final String? message;
  final Data? data;

  const LoginEntity({
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


class Data extends Equatable {

  final User? user;
  final String? token;
  final List? permissions;

  const Data({
    required this.user,
    required this.token,
    required this.permissions,
  });

  factory Data.fromJson(Map<String,dynamic> json){
    return Data(
      user: User.fromJson(json['user']),
      token: json['token'],
      permissions: json['permissions'],
    );
  }

  @override
  List<Object?> get props => [
    user,
    token,
    permissions
  ];
}

class User extends Equatable {

  final int? id;
  final String? username;
  final String? fullName;
  final String? email;
  final String? mobile;
  final String? whatsMobile;
  final String? emailVerifiedAt;
  final String? type;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;
  final int? shopID;
  final dynamic provider;
  final int? providerId;
  final dynamic gender;
  final String? image;
  final int? mobileVerification;
  final String? otp;
  final String? wallet;
  final String? emailWaiting;
  final String? imagePath;
  final Shop? shop;

  const User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.mobile,
    required this.email,
    required this.imagePath,
    required this.image,
    required this.shop,
    required this.provider,
    required this.createdAt,
    required this.deletedAt,
    required this.emailVerifiedAt,
    required this.emailWaiting,
    required this.gender,
    required this.mobileVerification,
    required this.otp,
    required this.providerId,
    required this.shopID,
    required this.type,
    required this.updatedAt,
    required this.wallet,
    required this.whatsMobile,

  });

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      id: json['id'],
      username: json['username'],
      fullName: json['full_name'],
      createdAt: json['created_at'],
      shopID: json['shop'],
      shop: Shop.fromJson(json['get_shop']),
      whatsMobile: json['whats_mobile'],
      deletedAt: json['deleted_at'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      emailWaiting: json['email_waiting'],
      gender: json['gender'],
      image: json['image'],
      imagePath: json['image_path'],
      mobile: json['mobile'],
      mobileVerification: json['mobile_verification'],
      otp: json['otp'],
      provider: json['provider'],
      providerId: json['provider_id'],
      type: json['type'],
      updatedAt: json['updated_at'],
      wallet: json['wallet'],

    );
  }

  @override
  List<Object?> get props => [
  ];
}


class Shop extends Equatable {

  final int? shopID;
  final dynamic deletedAt;
  final dynamic createdAt;
  final dynamic updatedAt;
  final int? userID;
  final String? shopName;
  final String? email;
  final String? mobile;
  final String? whatsMobile;
  final String? logo;
  final String? banner;
  final String? merchantType;
  final String? slug;
  final int? admin;
  final int? firstUpdate;
  final int? deliveryBoy;
  final String? commercial;
  final String? vat;
  final int? percentageOnline;
  final int? maxValueOnline;
  final int? minValueOnline;
  final int? fixedAmountOnline;
  final int? percentageCod;
  final int? maxValueCod;
  final int? minValueCod;
  final int? fixedAmountCod;
  final int? campaign;
  final String? rate;
  final String? logoPath;
  final String? bannerPath;
  final String? commercialPath;
  final String? vatPath;
  final List? ratings;



  const Shop({
    required this.whatsMobile,
    required this.shopID,
    required this.updatedAt,
    required this.deletedAt,
    required this.createdAt,
    required this.email,
    required this.mobile,
    required this.shopName,
    required this.bannerPath,
    required this.rate,
    required this.admin,
    required this.banner,
    required this.campaign,
    required this.commercial,
    required this.commercialPath,
    required this.deliveryBoy,
    required this.firstUpdate,
    required this.fixedAmountCod,
    required this.fixedAmountOnline,
    required this.logo,
    required this.logoPath,
    required this.maxValueCod,
    required this.maxValueOnline,
    required this.merchantType,
    required this.minValueCod,
    required this.minValueOnline,
    required this.percentageCod,
    required this.percentageOnline,
    required this.ratings,
    required this.slug,
    required this.userID,
    required this.vat,
    required this.vatPath,
  });

  factory Shop.fromJson(Map<String,dynamic> json){
    return Shop(
        updatedAt: json['updated_at'],
        ratings: json['ratings'],
        percentageCod: json['percentage_cod'],
        minValueOnline: json['min_value_online'],
        minValueCod: json['min_value_cod'],
        merchantType: json['merchant_type'],
        maxValueOnline: json['min_value_online'],
        maxValueCod: json['max_value_cod'],
        logoPath: json['logo_path'],
        logo: json['logo'],
        fixedAmountOnline: json['fixed_amount_online'],
        fixedAmountCod: json['fixed_amount_cod'],
        firstUpdate: json['first_update'],
        commercialPath: json['commercial_path'],
        deliveryBoy: json['delivery_boy'],
        commercial: json['commercial'],
        campaign: json['campaign'],
        banner: json['banner'],
        admin: json['admin'],
        rate: json['rate'],
        vatPath: json['vat_path'],
        bannerPath: json['banner_path'],
        vat: json['vat'],
        userID: json['user'],
        slug: json['slug'],
        percentageOnline: json['percentage_online'],
        shopName: json['shop_name'],
        mobile: json['mobile'],
        email: json['email'],
        createdAt: json['created_at'],
        deletedAt: json['deleted_at'],
        shopID: json['id'],
        whatsMobile:json['whats_mobile'] ,
    );
  }

  @override
  List<Object?> get props => [

  ];
}


