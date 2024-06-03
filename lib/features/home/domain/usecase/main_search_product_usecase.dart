import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/main_search_entity.dart';
import '../repository/home_base_rebository.dart';

class MainSearchProductUseCase implements UseCase<MainSearchProductEntity, MainSearchProductParams> {
  final HomeBaseRepository repository;

  MainSearchProductUseCase(this.repository);

  @override
  Future<Either<Failure, MainSearchProductEntity>> call(MainSearchProductParams params) async {
    return await repository.mainSearchProduct(
      searchText: params.searchText!,
    );
  }
}

class MainSearchProductParams extends Equatable {

  final String? searchText;

  const  MainSearchProductParams({
    required this.searchText,

  });

  @override
  List<Object> get props => [];
}
