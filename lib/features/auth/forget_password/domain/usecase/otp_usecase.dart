import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/otp_entity.dart';
import '../repository/forget_password_base_repository.dart';

class OTPUseCase implements UseCase<OTPEntity, OTPParams> {
  final ForgetPasswordBaseRepository repository;

  OTPUseCase(this.repository);

  @override
  Future<Either<Failure, OTPEntity>> call(
      OTPParams params) async {
    return await repository.sendOTP(
      otp: params.otp,
      email: params.email,
    );
  }
}

class OTPParams extends Equatable {
  final String email;
  final String otp;

  const OTPParams({
    required this.email,
    required this.otp,
  });

  @override
  List<Object> get props => [
    email,
    otp,
  ];
}
