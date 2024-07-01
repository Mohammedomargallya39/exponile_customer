import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/account_data_entity.dart';
import '../entities/order_reciept_entity.dart';
import '../entities/reciept_entity.dart';
import '../repository/home_base_rebository.dart';

class ReceiptUseCase implements UseCase<ReceiptEntity, ReceiptParams> {
  final HomeBaseRepository repository;

  ReceiptUseCase(this.repository);

  @override
  Future<Either<Failure, ReceiptEntity>> call(ReceiptParams params) async {
    return await repository.receipt(
      purchaseOrderNumber: params.purchaseOrderNumber,
    );
  }
}

class ReceiptParams extends Equatable {

  final String? purchaseOrderNumber;

  const  ReceiptParams({
    required this.purchaseOrderNumber,
  });

  @override
  List<Object> get props => [];
}