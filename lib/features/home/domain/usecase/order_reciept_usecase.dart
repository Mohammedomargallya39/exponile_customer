import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/account_data_entity.dart';
import '../entities/order_reciept_entity.dart';
import '../repository/home_base_rebository.dart';

class OrderReceiptUseCase implements UseCase<OrderReceiptEntity, OrderReceiptParams> {
  final HomeBaseRepository repository;

  OrderReceiptUseCase(this.repository);

  @override
  Future<Either<Failure, OrderReceiptEntity>> call(OrderReceiptParams params) async {
    return await repository.orderReceipt(
      purchaseOrderNumber: params.purchaseOrderNumber,
    );
  }
}

class OrderReceiptParams extends Equatable {

  final String? purchaseOrderNumber;

  const  OrderReceiptParams({
    required this.purchaseOrderNumber,
  });

  @override
  List<Object> get props => [];
}