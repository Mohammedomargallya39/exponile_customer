import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/hot_deals_entity.dart';
import '../repository/home_base_rebository.dart';

class HotDealsUseCase implements UseCase<HotDealsEntity, HotDealsParams> {
  final HomeBaseRepository repository;

  HotDealsUseCase(this.repository);

  @override
  Future<Either<Failure, HotDealsEntity>> call(HotDealsParams params) async {
    return await repository.hotDeals(
      pageNumber: params.pageNumber,
      productCategories: params.productCategories,
      storeCategories: params.storeCategories,
    );
  }
}

class HotDealsParams extends Equatable {

  final int pageNumber;
  final List<String>? productCategories;
  final List<String>? storeCategories;

  const  HotDealsParams({
    required this.pageNumber,
    required this.productCategories,
    required this.storeCategories,

  });

  @override
  List<Object> get props => [

  ];
}
