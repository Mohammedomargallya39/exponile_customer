import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/app_info_entity.dart';
import '../entities/landing_entity.dart';
import '../repository/home_base_rebository.dart';

class LandingUseCase implements UseCase<LandingEntity, NoParams> {
  final HomeBaseRepository repository;

  LandingUseCase(this.repository);

  @override
  Future<Either<Failure, LandingEntity>> call(
      NoParams params) async {
    return await repository.landing();
  }
}