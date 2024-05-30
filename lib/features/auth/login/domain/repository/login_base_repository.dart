import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/log_in_entity.dart';

abstract class LogInBaseRepository {
  Future<Either<Failure, LoginEntity>> login({
    required String userName,
    required String password,
  });
}
