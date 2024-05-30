import 'package:dio/dio.dart';
import '../../../../../core/network/remote/api_endpoints.dart';
import '../../../../../core/network/remote/dio_helper.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../model/login_model.dart';

abstract class LogInBaseRemoteDataSource {
  Future<LogInModel> logIn({
    required String userName,
    required String password,
  });
}

class LogInRemoteDataSourceImpl
    implements LogInBaseRemoteDataSource {
  final DioHelper dioHelper;

  LogInRemoteDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<LogInModel> logIn({
    required String userName,
    required String password,
  }) async {
    final Response f = await dioHelper.post(
        url: loginURL,
        data: {
          'email':userName.replaceAll(' ', ''),
          'password':password,
          'lang': isRTL == true ? 'ar' : 'en',
          'type':'customer',
        }
    );
    return LogInModel.fromJson(f.data);
  }
}