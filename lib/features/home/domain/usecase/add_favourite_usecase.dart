import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_favourite_entity.dart';
import '../repository/home_base_rebository.dart';

class AddFavouriteUseCase implements UseCase<AddFavouriteEntity, AddFavouriteParams> {
  final HomeBaseRepository repository;

  AddFavouriteUseCase(this.repository);

  @override
  Future<Either<Failure, AddFavouriteEntity>> call(AddFavouriteParams params) async {
    return await repository.addFavourite(
      itemID: params.itemID,
      itemType: params.itemType,
    );
  }
}

class AddFavouriteParams extends Equatable {

  final int? itemID;
  final String? itemType;

  const  AddFavouriteParams({
    required this.itemID,
    required this.itemType,
  });

  @override
  List<Object> get props => [];
}
