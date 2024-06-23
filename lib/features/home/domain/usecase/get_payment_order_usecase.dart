import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/areas_entity.dart';
import '../entities/cancel_order_entity.dart';
import '../entities/payment_order_data_entity.dart';
import '../repository/home_base_rebository.dart';

class PaymentOrderDataUseCase implements UseCase<PaymentOrderDataEntity, PaymentOrderDataParams> {
  final HomeBaseRepository repository;

  PaymentOrderDataUseCase(this.repository);

  @override
  Future<Either<Failure, PaymentOrderDataEntity>> call(PaymentOrderDataParams params) async {
    return await repository.paymentOrderData(
      poNumber: params.poNumber,
    );
  }
}

class PaymentOrderDataParams extends Equatable {

  final String poNumber;

  const  PaymentOrderDataParams({
    required this.poNumber,

  });

  @override
  List<Object> get props => [

  ];
}
