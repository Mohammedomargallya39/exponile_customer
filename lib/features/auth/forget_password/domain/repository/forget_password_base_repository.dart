import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/forget_password_entity.dart';
import '../entities/otp_entity.dart';
import '../entities/reset_password_entity.dart';

abstract class ForgetPasswordBaseRepository {
  Future<Either<Failure, ForgetPasswordEntity>> forgetPassword({
    required String email,
  });

  Future<Either<Failure, OTPEntity>> sendOTP({
    required String email,
    required String otp,
  });


  Future<Either<Failure, ResetPasswordEntity>> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  });
}
