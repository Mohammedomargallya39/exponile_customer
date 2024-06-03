import 'package:dartz/dartz.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/app_info_entity.dart';
import '../../domain/entities/main_search_entity.dart';
import '../../domain/repository/home_base_rebository.dart';
import '../data_source/home_remote_data_source.dart';

typedef CallAppInfo = Future<AppInfoEntity> Function();
typedef CallMainSearchProduct = Future<MainSearchProductEntity> Function();


class HomeRepoImplementation extends HomeBaseRepository {
  final HomeBaseRemoteDataSource remoteDataSource;

  HomeRepoImplementation({
    required this.remoteDataSource,
  });

  Future<Either<Failure, AppInfoEntity>> fetchAppInfoData(
      CallAppInfo mainMethod,
      ) async {
    try {
      final appInfoData = await mainMethod();
      return Right(appInfoData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AppInfoEntity>> appInfo() async {
    return await fetchAppInfoData(()
    {
      return remoteDataSource.appInfo();
    });
  }


  Future<Either<Failure, MainSearchProductEntity>> fetchMainSearchProduct(
      CallMainSearchProduct mainMethod,
      ) async {
    try {
      final mainSearchProduct = await mainMethod();
      return Right(mainSearchProduct);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, MainSearchProductEntity>> mainSearchProduct({
    required String searchText,
  }) async {
    return await fetchMainSearchProduct(()
    {
      return remoteDataSource.mainSearchProduct(
        searchText: searchText,
      );
    });
  }



}

