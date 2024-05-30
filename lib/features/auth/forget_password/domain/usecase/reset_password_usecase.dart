import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/reset_password_entity.dart';
import '../repository/forget_password_base_repository.dart';

class ResetPasswordUseCase implements UseCase<ResetPasswordEntity, ResetPasswordParams> {
  final ForgetPasswordBaseRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, ResetPasswordEntity>> call(
      ResetPasswordParams params) async {
    return await repository.resetPassword(
      email: params.email,
      password: params.password,
      confirmPassword: params.confirmPassword,
    );
  }
}

class ResetPasswordParams extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;

  const ResetPasswordParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [
    email,
    password,
    confirmPassword,
  ];
}
