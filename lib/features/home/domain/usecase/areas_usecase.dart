import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/areas_entity.dart';
import '../repository/home_base_rebository.dart';

class AreasUseCase implements UseCase<AreasEntity, AreasParams> {
  final HomeBaseRepository repository;

  AreasUseCase(this.repository);

  @override
  Future<Either<Failure, AreasEntity>> call(AreasParams params) async {
    return await repository.areas(
      cityID: params.cityId,
    );
  }
}

class AreasParams extends Equatable {

  final int cityId;

  const  AreasParams({
    required this.cityId,

  });

  @override
  List<Object> get props => [

  ];
}
