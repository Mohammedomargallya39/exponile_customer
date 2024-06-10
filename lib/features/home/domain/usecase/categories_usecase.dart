import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/app_info_entity.dart';
import '../entities/categories_entity.dart';
import '../entities/landing_entity.dart';
import '../repository/home_base_rebository.dart';

class CategoriesUseCase implements UseCase<CategoriesEntity, NoParams> {
  final HomeBaseRepository repository;

  CategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, CategoriesEntity>> call(
      NoParams params) async {
    return await repository.categories();
  }
}