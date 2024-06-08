import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/delete_address_entity.dart';
import '../repository/home_base_rebository.dart';

class DeleteAddressUseCase implements UseCase<DeleteAddressEntity, DeleteAddressParams> {
  final HomeBaseRepository repository;

  DeleteAddressUseCase(this.repository);

  @override
  Future<Either<Failure, DeleteAddressEntity>> call(DeleteAddressParams params) async {
    return await repository.deleteAddress(
      addressID: params.addressID,
    );
  }
}

class DeleteAddressParams extends Equatable {

  final int? addressID;

  const  DeleteAddressParams({
    required this.addressID,
  });

  @override
  List<Object> get props => [];
}
