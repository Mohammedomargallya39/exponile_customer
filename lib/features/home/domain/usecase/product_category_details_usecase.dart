import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_favourite_entity.dart';
import '../entities/product_category_details_entity.dart';
import '../entities/store_category_details_entity.dart';
import '../repository/home_base_rebository.dart';

class ProductCategoryDetailsUseCase implements UseCase<ProductCategoryDetailsEntity, ProductCategoryDetailsParams> {
  final HomeBaseRepository repository;

  ProductCategoryDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductCategoryDetailsEntity>> call(ProductCategoryDetailsParams params) async {
    return await repository.productCategoryDetails(
      slug: params.slug,
    );
  }
}

class ProductCategoryDetailsParams extends Equatable {

  final String slug;

  const  ProductCategoryDetailsParams({
    required this.slug,
  });

  @override
  List<Object> get props => [];
}
