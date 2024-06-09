import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/main_search_shop_entity.dart';
import '../repository/home_base_rebository.dart';

class MainSearchShopUseCase implements UseCase<MainSearchShopEntity, MainSearchShopParams> {
  final HomeBaseRepository repository;

  MainSearchShopUseCase(this.repository);

  @override
  Future<Either<Failure, MainSearchShopEntity>> call(MainSearchShopParams params) async {
    return await repository.mainSearchShop(
      searchText: params.searchText!,
    );
  }
}

class MainSearchShopParams extends Equatable {

  final String? searchText;

  const  MainSearchShopParams({
    required this.searchText,

  });

  @override
  List<Object> get props => [];
}
