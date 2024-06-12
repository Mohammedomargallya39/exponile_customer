import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/best_selling_products_entity.dart';
import '../entities/top_categories_entity.dart';
import '../repository/home_base_rebository.dart';

class TopCategoriesUseCase implements UseCase< TopCategoriesEntity, NoParams> {
  final HomeBaseRepository repository;

  TopCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, TopCategoriesEntity>> call(NoParams params) async {
    return await repository.topCategories();
  }
}