import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/favourite_stores_entity.dart';
import '../repository/home_base_rebository.dart';

class FavouriteStoresUseCase implements UseCase<FavouriteStoresEntity, FavouriteStoresParams> {
  final HomeBaseRepository repository;

  FavouriteStoresUseCase(this.repository);

  @override
  Future<Either<Failure, FavouriteStoresEntity>> call(FavouriteStoresParams params) async {
    return await repository.favouriteStores(
      itemType: params.itemType,
    );
  }
}

class FavouriteStoresParams extends Equatable {

  final String? itemType;

  const  FavouriteStoresParams({
    required this.itemType,
  });

  @override
  List<Object> get props => [];
}
