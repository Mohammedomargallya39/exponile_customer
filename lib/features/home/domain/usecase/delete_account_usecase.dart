import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/delete_account_entity.dart';
import '../repository/home_base_rebository.dart';

class DeleteAccountUseCase implements UseCase<DeleteAccountEntity, DeleteAccountParams> {
  final HomeBaseRepository repository;

  DeleteAccountUseCase(this.repository);

  @override
  Future<Either<Failure, DeleteAccountEntity>> call(DeleteAccountParams params) async {
    return await repository.deleteAccount(
      password: params.password,
    );
  }
}

class DeleteAccountParams extends Equatable {

  final String password;

  const  DeleteAccountParams({
    required this.password,

  });

  @override
  List<Object> get props => [

  ];
}
