import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/areas_entity.dart';
import '../entities/cancel_order_entity.dart';
import '../repository/home_base_rebository.dart';

class CancelOrderUseCase implements UseCase<CancelOrderEntity, CancelOrderParams> {
  final HomeBaseRepository repository;

  CancelOrderUseCase(this.repository);

  @override
  Future<Either<Failure, CancelOrderEntity>> call(CancelOrderParams params) async {
    return await repository.cancelOrder(
      orderNumber: params.orderNumber,
    );
  }
}

class CancelOrderParams extends Equatable {

  final String orderNumber;

  const  CancelOrderParams({
    required this.orderNumber,

  });

  @override
  List<Object> get props => [

  ];
}
