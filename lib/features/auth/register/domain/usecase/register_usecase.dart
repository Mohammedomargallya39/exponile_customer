import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/register_entity.dart';
import '../repository/register_base_rebository.dart';

class RegisterUseCase
    implements UseCase<RegisterEntity, RegisterParams> {
  final RegisterBaseRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParams params) async {
    return await repository.register(
      userName: params.userName,
      email: params.email,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
      mobile: params.mobile,
      whatsMobile: params.whatsMobile,
      gender: params.gender,
      terms: params.terms,
    );
  }
}

class RegisterParams extends Equatable {

  final String userName;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String mobile;
  final String whatsMobile;
  final String gender;
  final int terms;

  const  RegisterParams({
    required this.userName,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.mobile,
    required this.terms,
    required this.gender,
    required this.whatsMobile
  });

  @override
  List<Object> get props => [

  ];
}
