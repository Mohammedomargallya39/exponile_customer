import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/shop_location_entity.dart';
import '../repository/home_base_rebository.dart';

class LocationUseCase implements UseCase<LocationEntity, LocationParams> {
  final HomeBaseRepository repository;

  LocationUseCase(this.repository);

  @override
  Future<Either<Failure, LocationEntity>> call(LocationParams params) async {
    return await repository.location(
      address: params.address,
    );
  }
}

class LocationParams extends Equatable {

  final String address;

  const  LocationParams({
    required this.address,

  });

  @override
  List<Object> get props => [

  ];
}
