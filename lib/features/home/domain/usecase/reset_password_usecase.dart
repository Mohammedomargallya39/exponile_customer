import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/reset_password_entity.dart';
import '../repository/home_base_rebository.dart';

class ResetPasswordSUseCase implements UseCase<ResetPasswordSEntity, ResetPasswordSParams> {
  final HomeBaseRepository repository;

  ResetPasswordSUseCase(this.repository);

  @override
  Future<Either<Failure, ResetPasswordSEntity>> call(ResetPasswordSParams params) async {
    return await repository.resetPasswordS(
      oldPassword: params.oldPassword,
      newPassword: params.newPassword,
      confirmNewPassword: params.confirmNewPassword,
    );
  }
}

class ResetPasswordSParams extends Equatable {

  final String oldPassword;
  final String newPassword;
  final String confirmNewPassword;

  const  ResetPasswordSParams({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,

  });

  @override
  List<Object> get props => [

  ];
}
