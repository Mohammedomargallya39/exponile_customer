import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/product_details_entity.dart';
import '../repository/home_base_rebository.dart';

class ProductDetailsUseCase implements UseCase<ProductDetailsEntity, ProductDetailsParams> {
  final HomeBaseRepository repository;

  ProductDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductDetailsEntity>> call(ProductDetailsParams params) async {
    return await repository.productDetails(
      productID: params.productID,
    );
  }
}

class ProductDetailsParams extends Equatable {

  final int? productID;

  const  ProductDetailsParams({
    required this.productID,
  });

  @override
  List<Object> get props => [];
}
