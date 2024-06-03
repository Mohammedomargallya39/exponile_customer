import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/app_info_entity.dart';
import '../repository/home_base_rebository.dart';

class AppInfoUseCase implements UseCase<AppInfoEntity, NoParams> {
  final HomeBaseRepository repository;

  AppInfoUseCase(this.repository);

  @override
  Future<Either<Failure, AppInfoEntity>> call(
      NoParams params) async {
    return await repository.appInfo();
  }
}