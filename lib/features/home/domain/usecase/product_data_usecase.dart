import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/product_data_entity.dart';
import '../repository/home_base_rebository.dart';

class ProductDataUseCase implements UseCase<ProductDataEntity, ProductDataParams> {
  final HomeBaseRepository repository;

  ProductDataUseCase(this.repository);

  @override
  Future<Either<Failure, ProductDataEntity>> call(ProductDataParams params) async {
    return await repository.productData(
      productID: params.productID,
    );
  }
}

class ProductDataParams extends Equatable {

  final int? productID;

  const  ProductDataParams({
    required this.productID,
  });

  @override
  List<Object> get props => [];
}
