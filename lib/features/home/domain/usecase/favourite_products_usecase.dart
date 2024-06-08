import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/favourite_products_entity.dart';
import '../repository/home_base_rebository.dart';

class FavouriteProductsUseCase implements UseCase<FavouriteProductsEntity, FavouriteProductsParams> {
  final HomeBaseRepository repository;

  FavouriteProductsUseCase(this.repository);

  @override
  Future<Either<Failure, FavouriteProductsEntity>> call(FavouriteProductsParams params) async {
    return await repository.favouriteProducts(
      itemType: params.itemType,
    );
  }
}

class FavouriteProductsParams extends Equatable {

  final String? itemType;

  const  FavouriteProductsParams({
    required this.itemType,
  });

  @override
  List<Object> get props => [];
}
