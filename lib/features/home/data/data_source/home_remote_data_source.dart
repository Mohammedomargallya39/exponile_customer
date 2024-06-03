import 'package:dio/dio.dart';
import '../../../../../core/network/remote/api_endpoints.dart';
import '../../../../../core/network/remote/dio_helper.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../models/app_info_model.dart';
import '../models/main_search_product_model.dart';

abstract class HomeBaseRemoteDataSource {
  Future<AppInfoModel> appInfo();
  Future<MainSearchProductModel> mainSearchProduct({
    required String searchText,
  });
}

class HomeRemoteDataSourceImpl
    implements HomeBaseRemoteDataSource {
  final DioHelper dioHelper;

  HomeRemoteDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<AppInfoModel> appInfo() async {
    final Response f = await dioHelper.get(
        url: versionURL,
        token: token
    );
    return AppInfoModel.fromJson(f.data);
  }

  @override
  Future<MainSearchProductModel> mainSearchProduct({
    required String searchText,
}) async {
    final Response f = await dioHelper.get(
        url: mainSearchURL,
        token: token,
        query: {
          "lang": isRTL==true ? 'ar' : 'en',
          "term": searchText,
          "type": 'product',
          "suggestion": 10,
        }
    );
    return MainSearchProductModel.fromJson(f.data);
  }

}

