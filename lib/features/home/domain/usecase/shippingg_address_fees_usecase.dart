import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/shipping_address_entity.dart';
import '../repository/home_base_rebository.dart';

class GetShippingAddressFeesUseCase implements UseCase<GetShippingAddressFeesEntity, GetShippingAddressFeesParams> {
  final HomeBaseRepository repository;

  GetShippingAddressFeesUseCase(this.repository);

  @override
  Future<Either<Failure, GetShippingAddressFeesEntity>> call(GetShippingAddressFeesParams params) async {
    return await repository.getShippingAddressFees(
      city: params.city,
      addressID: params.addressID,
    );
  }
}

class GetShippingAddressFeesParams extends Equatable {

  final int? city;
  final int? addressID;

  const  GetShippingAddressFeesParams({
    required this.city,
    required this.addressID,
  });

  @override
  List<Object> get props => [];
}
