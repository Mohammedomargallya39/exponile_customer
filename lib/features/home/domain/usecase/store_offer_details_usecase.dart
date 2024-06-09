import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/store_offer_details_entity.dart';
import '../repository/home_base_rebository.dart';

class StoreOfferDetailsUseCase implements UseCase<StoreOfferDetailsEntity, StoreOfferDetailsParams> {
  final HomeBaseRepository repository;

  StoreOfferDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StoreOfferDetailsEntity>> call(StoreOfferDetailsParams params) async {
    return await repository.storeOfferDetails(
      offerID: params.offerID,
    );
  }
}

class StoreOfferDetailsParams extends Equatable {

  final int? offerID;

  const  StoreOfferDetailsParams({
    required this.offerID,
  });

  @override
  List<Object> get props => [];
}
