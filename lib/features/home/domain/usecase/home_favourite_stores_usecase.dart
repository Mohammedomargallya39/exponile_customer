import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/areas_entity.dart';
import '../entities/home_favourite_store_entity.dart';
import '../repository/home_base_rebository.dart';

class HomeFavouriteStoresUseCase implements UseCase<HomeFavouriteStoresEntity, HomeFavouriteStoresParams> {
  final HomeBaseRepository repository;

  HomeFavouriteStoresUseCase(this.repository);

  @override
  Future<Either<Failure, HomeFavouriteStoresEntity>> call(HomeFavouriteStoresParams params) async {
    return await repository.homeFavouriteStores(
      pageNumber: params.pageNumber,
      storeCategory: params.storeCategory,
      offerType: params.offerType,
      sortedBy: params.sortedBy,
    );
  }
}

class HomeFavouriteStoresParams extends Equatable {

  final int pageNumber;
  final String? storeCategory;
  final String? offerType;
  final String? sortedBy;

  const  HomeFavouriteStoresParams({
    required this.pageNumber,
    required this.storeCategory,
    required this.offerType,
    required this.sortedBy,

  });

  @override
  List<Object> get props => [

  ];
}
