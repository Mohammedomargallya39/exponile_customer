import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/get_location_entity.dart';
import '../repository/home_base_rebository.dart';

class GetLocationUseCase implements UseCase<GetLocationEntity, GetLocationParams> {
  final HomeBaseRepository repository;

  GetLocationUseCase(this.repository);

  @override
  Future<Either<Failure, GetLocationEntity>> call(GetLocationParams params) async {
    return await repository.getLocation(
      lat: params.lat,
      long: params.long,
    );
  }
}

class GetLocationParams extends Equatable {

  final double lat;
  final double long;

  const  GetLocationParams({
    required this.lat,
    required this.long,

  });

  @override
  List<Object> get props => [
    lat,
    long,
  ];
}
