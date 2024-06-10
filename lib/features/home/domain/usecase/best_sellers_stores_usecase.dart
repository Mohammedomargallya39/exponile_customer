import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/areas_entity.dart';
import '../entities/best_sellers_store_entity.dart';
import '../entities/discover_new_store_entity.dart';
import '../entities/home_favourite_store_entity.dart';
import '../repository/home_base_rebository.dart';

class BestSellersStoresUseCase implements UseCase<BestSellersStoresEntity, BestSellersStoresParams> {
  final HomeBaseRepository repository;

  BestSellersStoresUseCase(this.repository);

  @override
  Future<Either<Failure, BestSellersStoresEntity>> call(BestSellersStoresParams params) async {
    return await repository.bestSellersStores(
      pageNumber: params.pageNumber,
      storeCategory: params.storeCategory,
      offerType: params.offerType,
      sortedBy: params.sortedBy,
    );
  }
}

class BestSellersStoresParams extends Equatable {

  final int pageNumber;
  final String? storeCategory;
  final String? offerType;
  final String? sortedBy;

  const  BestSellersStoresParams({
    required this.pageNumber,
    required this.storeCategory,
    required this.offerType,
    required this.sortedBy,

  });

  @override
  List<Object> get props => [

  ];
}
