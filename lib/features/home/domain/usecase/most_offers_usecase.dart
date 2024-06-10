import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/app_info_entity.dart';
import '../entities/landing_entity.dart';
import '../entities/most_deals_entity.dart';
import '../repository/home_base_rebository.dart';

class MostOffersUseCase implements UseCase<MostOffersEntity, NoParams> {
  final HomeBaseRepository repository;

  MostOffersUseCase(this.repository);

  @override
  Future<Either<Failure, MostOffersEntity>> call(NoParams params) async {
    return await repository.mostOffers();
  }
}