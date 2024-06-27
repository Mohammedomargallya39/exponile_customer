import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/get_payment_method_entity.dart';
import '../entities/shipping_address_entity.dart';
import '../repository/home_base_rebository.dart';

class GetPaymentMethodUseCase implements UseCase<GetPaymentMethodEntity, GetPaymentMethodParams> {
  final HomeBaseRepository repository;

  GetPaymentMethodUseCase(this.repository);

  @override
  Future<Either<Failure, GetPaymentMethodEntity>> call(GetPaymentMethodParams params) async {
    return await repository.getPaymentMethod(
      paymentID: params.paymentID,
    );
  }
}

class GetPaymentMethodParams extends Equatable {

  final int? paymentID;

  const  GetPaymentMethodParams({
    required this.paymentID,
  });

  @override
  List<Object> get props => [];
}
