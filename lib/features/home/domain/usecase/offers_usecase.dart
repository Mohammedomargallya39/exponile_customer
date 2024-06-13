import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/hot_deals_entity.dart';
import '../entities/offers_entity.dart';
import '../repository/home_base_rebository.dart';

class OffersUseCase implements UseCase<OffersEntity, OffersParams> {
  final HomeBaseRepository repository;

  OffersUseCase(this.repository);

  @override
  Future<Either<Failure, OffersEntity>> call(OffersParams params) async {
    return await repository.offers(
      pageNumber: params.pageNumber,
      productCategories: params.productCategories,
      storeCategories: params.storeCategories,
    );
  }
}

class OffersParams extends Equatable {

  final int pageNumber;
  final List<String>? productCategories;
  final List<String>? storeCategories;

  const  OffersParams({
    required this.pageNumber,
    required this.productCategories,
    required this.storeCategories,

  });

  @override
  List<Object> get props => [

  ];
}
