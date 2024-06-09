import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/cities_entity.dart';
import '../repository/home_base_rebository.dart';

class CitiesUseCase implements UseCase<CitiesEntity, NoParams> {
  final HomeBaseRepository repository;

  CitiesUseCase(this.repository);

  @override
  Future<Either<Failure, CitiesEntity>> call(NoParams params) async {
    return await repository.cities();
  }
}