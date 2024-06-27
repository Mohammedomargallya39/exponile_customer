import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/checkout_entity.dart';
import '../entities/shipping_address_entity.dart';
import '../repository/home_base_rebository.dart';

class CheckoutUseCase implements UseCase<CheckoutEntity, CheckoutParams> {
  final HomeBaseRepository repository;

  CheckoutUseCase(this.repository);

  @override
  Future<Either<Failure, CheckoutEntity>> call(CheckoutParams params) async {
    return await repository.checkout(
      paymentID: params.paymentID,
      addressID: params.addressID,
    );
  }
}

class CheckoutParams extends Equatable {

  final int? paymentID;
  final int? addressID;

  const  CheckoutParams({
    required this.paymentID,
    required this.addressID,
  });

  @override
  List<Object> get props => [];
}
