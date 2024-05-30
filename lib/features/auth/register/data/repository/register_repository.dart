import 'package:dartz/dartz.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/repository/register_base_rebository.dart';
import '../data_source/register_remote_data_source.dart';

typedef Call = Future<RegisterEntity> Function();

class RegisterRepoImplementation extends RegisterBaseRepository {
  final RegisterBaseRemoteDataSource remoteDataSource;

  RegisterRepoImplementation({
    required this.remoteDataSource,
  });

  Future<Either<Failure, RegisterEntity>> fetchData(
      Call mainMethod,
      ) async {
    try {
      final registerData = await mainMethod();
      return Right(registerData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register(
      {
        required String userName,
        required String email,
        required String password,
        required String passwordConfirmation,
        required String mobile,
        required String whatsMobile,
        required String gender,
        required int terms,
      }) async {
    return await fetchData(()
    {
      return remoteDataSource.register(
        userName: userName,
        gender: gender,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        mobile: mobile,
        whatsMobile: whatsMobile,
        terms: terms,
      );
    });
  }

}

