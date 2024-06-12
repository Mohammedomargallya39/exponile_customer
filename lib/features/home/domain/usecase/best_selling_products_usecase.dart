import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/best_selling_products_entity.dart';
import '../repository/home_base_rebository.dart';

class BestSellingProductsUseCase implements UseCase<List<BestSellingProductsEntity>, NoParams> {
  final HomeBaseRepository repository;

  BestSellingProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<BestSellingProductsEntity>>> call(
      NoParams params) async {
    return await repository.bestSellingProducts();
  }
}