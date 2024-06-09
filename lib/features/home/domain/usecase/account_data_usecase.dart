import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/account_data_entity.dart';
import '../repository/home_base_rebository.dart';

class AccountDataUseCase implements UseCase<AccountDataEntity, NoParams> {
  final HomeBaseRepository repository;

  AccountDataUseCase(this.repository);

  @override
  Future<Either<Failure, AccountDataEntity>> call(NoParams params) async {
    return await repository.accountData();
  }
}