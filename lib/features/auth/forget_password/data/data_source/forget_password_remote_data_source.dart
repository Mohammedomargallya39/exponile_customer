import 'package:dio/dio.dart';
import 'package:exponile_customer/features/auth/forget_password/data/model/send_otp_model.dart';
import '../../../../../core/network/remote/api_endpoints.dart';
import '../../../../../core/network/remote/dio_helper.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../model/forget_password_model.dart';
import '../model/reset_password_model.dart';

abstract class ForgetPasswordBaseRemoteDataSource {
  Future<ForgetPasswordModel> forgetPassword({
    required String email,
  });

  Future<SendOTPModel> sendOTP({
    required String email,
    required String otp,
  });

  Future<ResetPasswordModel> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  });
}

class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordBaseRemoteDataSource {
  final DioHelper dioHelper;

  ForgetPasswordRemoteDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<ForgetPasswordModel> forgetPassword({
    required String email,
  }) async {
    final Response f = await dioHelper.post(
        url: forgetURL,
        data: {
          'email':email.replaceAll(' ', ''),
          'lang': isRTL == true ? 'ar' : 'en',
        }
    );
    return ForgetPasswordModel.fromJson(f.data);
  }


  @override
  Future<SendOTPModel> sendOTP({
    required String email,
    required String otp,
  }) async {
    final Response f = await dioHelper.post(
        url: verifyURL,
        data: {
          'email': email.replaceAll(' ', ''),
          'code': otp,
          'lang': isRTL == true ? 'ar' : 'en',
        }
    );
    return SendOTPModel.fromJson(f.data);
  }


  @override
  Future<ResetPasswordModel> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final Response f = await dioHelper.post(
        url: verifyURL,
        data: {
          'email': email.replaceAll(' ', ''),
          'password': password,
          'password_confirmation': confirmPassword,
          'lang': isRTL == true ? 'ar' : 'en',
        }
    );
    return ResetPasswordModel.fromJson(f.data);
  }
}