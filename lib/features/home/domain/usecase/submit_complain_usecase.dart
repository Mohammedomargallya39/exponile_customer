import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/submit_complain_entity.dart';
import '../repository/home_base_rebository.dart';

class SubmitComplainUseCase implements UseCase<SubmitComplainEntity, SubmitComplainParams> {
  final HomeBaseRepository repository;

  SubmitComplainUseCase(this.repository);

  @override
  Future<Either<Failure, SubmitComplainEntity>> call(SubmitComplainParams params) async {
    return await repository.submitComplain(
      name: params.name,
      email: params.email,
      phone: params.phone,
      complain: params.complain,
    );
  }
}

class SubmitComplainParams extends Equatable {

  final String name;
  final String email;
  final String phone;
  final String complain;

  const  SubmitComplainParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.complain,

  });

  @override
  List<Object> get props => [

  ];
}
