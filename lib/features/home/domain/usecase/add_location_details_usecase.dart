import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_address_entity.dart';
import '../repository/home_base_rebository.dart';

class AddLocationUseCase implements UseCase<AddLocationEntity, AddLocationParams> {
  final HomeBaseRepository repository;

  AddLocationUseCase(this.repository);

  @override
  Future<Either<Failure, AddLocationEntity>> call(AddLocationParams params) async {
    return await repository.addLocation(
      area: params.area,
      governorate: params.governorate,
      late: params.late,
      long: params.long,
      streetName: params.streetName,
      buildingName: params.buildingName,
      landmark: params.landmark,
      floorNo: params.floorNo,
      aptNo: params.aptNo,
      type: params.type,
    );
  }
}

class AddLocationParams extends Equatable {

  final int? area;
  final int? governorate;
  final String? late;
  final String? long;
  final String? streetName;
  final String? buildingName;
  final String? landmark;
  final int? floorNo;
  final int? aptNo;
  final String? type;

  const  AddLocationParams({
    required this.area,
    required this.governorate,
    required this.late,
    required this.long,
    required this.streetName,
    required this.buildingName,
    required this.landmark,
    required this.floorNo,
    required this.aptNo,
    required this.type,
  });

  @override
  List<Object> get props => [];
}
