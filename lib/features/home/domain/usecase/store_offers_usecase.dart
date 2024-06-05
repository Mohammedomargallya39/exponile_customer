import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_favourite_entity.dart';
import '../entities/product_details_entity.dart';
import '../entities/store_offers_entity.dart';
import '../repository/home_base_rebository.dart';

class StoreOffersUseCase implements UseCase<StoreOffersEntity, StoreOffersParams> {
  final HomeBaseRepository repository;

  StoreOffersUseCase(this.repository);

  @override
  Future<Either<Failure, StoreOffersEntity>> call(StoreOffersParams params) async {
    return await repository.storeOffers(
      storeID: params.storeID,
    );
  }
}

class StoreOffersParams extends Equatable {

  final int? storeID;

  const  StoreOffersParams({
    required this.storeID,
  });

  @override
  List<Object> get props => [];
}
