import 'package:dio/dio.dart';
import '../../../../../core/network/remote/api_endpoints.dart';
import '../../../../../core/network/remote/dio_helper.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../models/register_model.dart';

abstract class RegisterBaseRemoteDataSource {
  Future<RegisterModel> register({
    required String userName,
    required String gender,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String mobile,
    required String whatsMobile,
    required int terms,
  });

}

class RegisterRemoteDataSourceImpl
    implements RegisterBaseRemoteDataSource {
  final DioHelper dioHelper;

  RegisterRemoteDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<RegisterModel> register({
    required String userName,
    required String gender,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String mobile,
    required String whatsMobile,
    required int terms,
  }) async {
    final Response f = await dioHelper.post(
        url: signUpURL,
        data: {
          'lang': isRTL == true ? 'ar' : 'en',
          'gender': gender,
          'username': userName,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'mobile': mobile,
          'whats_mobile': whatsMobile,
          'terms': terms,
        }
    );
    return RegisterModel.fromJson(f.data);
  }

}

