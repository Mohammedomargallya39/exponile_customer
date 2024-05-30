import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/forget_password_entity.dart';
import '../repository/forget_password_base_repository.dart';

class ForgetPasswordUseCase implements UseCase<ForgetPasswordEntity, ForgetPasswordParams> {
  final ForgetPasswordBaseRepository repository;

  ForgetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, ForgetPasswordEntity>> call(
      ForgetPasswordParams params) async {
    return await repository.forgetPassword(
      email: params.email,
    );
  }
}

class ForgetPasswordParams extends Equatable {
  final String email;

  const ForgetPasswordParams({
    required this.email,
  });

  @override
  List<Object> get props => [
    email,
  ];
}
