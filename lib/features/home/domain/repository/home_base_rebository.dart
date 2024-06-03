import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/app_info_entity.dart';
import '../entities/main_search_entity.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, AppInfoEntity>> appInfo();
  Future<Either<Failure, MainSearchProductEntity>> mainSearchProduct({
    required String searchText,
});
}