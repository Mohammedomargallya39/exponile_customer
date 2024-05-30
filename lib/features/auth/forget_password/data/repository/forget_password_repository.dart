import 'package:dartz/dartz.dart';
import 'package:exponile_customer/features/auth/forget_password/domain/entities/otp_entity.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/forget_password_entity.dart';
import '../../domain/entities/reset_password_entity.dart';
import '../../domain/repository/forget_password_base_repository.dart';
import '../data_source/forget_password_remote_data_source.dart';


typedef Call = Future<ForgetPasswordEntity> Function();
typedef CallOTP = Future<OTPEntity> Function();
typedef CallResetPassword = Future<ResetPasswordEntity> Function();

class ForgetPasswordImplementation extends ForgetPasswordBaseRepository {
  final ForgetPasswordBaseRemoteDataSource remoteDataSource;

  ForgetPasswordImplementation({
    required this.remoteDataSource,
  });

  Future<Either<Failure, ForgetPasswordEntity>> fetchData(
      Call mainMethod,
      ) async {
    try {
      final forgetPasswordData = await mainMethod();
      return Right(forgetPasswordData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordEntity>> forgetPassword(
      {
        required String email,
      }) async {
    return await fetchData(()
    {
      return remoteDataSource.forgetPassword(
        email: email,
      );
    });
  }

  Future<Either<Failure, OTPEntity>> fetchOTPData(
      CallOTP mainMethod,
      ) async {
    try {
      final sendOTP = await mainMethod();
      return Right(sendOTP);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, OTPEntity>> sendOTP(
      {
        required String email,
        required String otp,
      }) async {
    return await fetchOTPData(()
    {
      return remoteDataSource.sendOTP(
        email: email,
        otp: otp,
      );
    });
  }



  Future<Either<Failure, ResetPasswordEntity>> fetchResetPassword(
      CallResetPassword mainMethod,
      ) async {
    try {
      final resetPassword = await mainMethod();
      return Right(resetPassword);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordEntity>> resetPassword(
      {
        required String email,
        required String password,
        required String confirmPassword,
      }) async {
    return await fetchResetPassword(()
    {
      return remoteDataSource.resetPassword(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
    });
  }
}