import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_favourite_entity.dart';
import '../entities/store_category_details_entity.dart';
import '../repository/home_base_rebository.dart';

class StoreCategoryDetailsUseCase implements UseCase<StoreCategoryDetailsEntity, StoreCategoryDetailsParams> {
  final HomeBaseRepository repository;

  StoreCategoryDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StoreCategoryDetailsEntity>> call(StoreCategoryDetailsParams params) async {
    return await repository.storeCategoryDetails(
      slug: params.slug,
    );
  }
}

class StoreCategoryDetailsParams extends Equatable {

  final String slug;

  const  StoreCategoryDetailsParams({
    required this.slug,
  });

  @override
  List<Object> get props => [];
}
