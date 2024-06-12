import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/best_selling_products_entity.dart';
import '../entities/recently_viewed_entity.dart';
import '../repository/home_base_rebository.dart';

class RecentlyViewedUseCase implements UseCase<List<RecentlyViewedEntity>, NoParams> {
  final HomeBaseRepository repository;

  RecentlyViewedUseCase(this.repository);

  @override
  Future<Either<Failure, List<RecentlyViewedEntity>>> call(
      NoParams params) async {
    return await repository.recentlyViewed();
  }
}