import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/new_arrivals_entity.dart';
import '../repository/home_base_rebository.dart';

class NewArrivalsUseCase implements UseCase<NewArrivalsEntity, NewArrivalsParams> {
  final HomeBaseRepository repository;

  NewArrivalsUseCase(this.repository);

  @override
  Future<Either<Failure, NewArrivalsEntity>> call(NewArrivalsParams params) async {
    return await repository.newArrivals(
      pageNumber: params.pageNumber,
      productCategories: params.productCategories,
      storeCategories: params.storeCategories,
    );
  }
}

class NewArrivalsParams extends Equatable {

  final int pageNumber;
  final List<String>? productCategories;
  final List<String>? storeCategories;

  const  NewArrivalsParams({
    required this.pageNumber,
    required this.productCategories,
    required this.storeCategories,

  });

  @override
  List<Object> get props => [

  ];
}
