import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/areas_entity.dart';
import '../entities/cancel_order_entity.dart';
import '../entities/order_details_entity.dart';
import '../repository/home_base_rebository.dart';

class OrderDetailsUseCase implements UseCase<OrderDetailsEntity, OrderDetailsParams> {
  final HomeBaseRepository repository;

  OrderDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, OrderDetailsEntity>> call(OrderDetailsParams params) async {
    return await repository.orderDetails(
      orderNumber: params.orderNumber,
    );
  }
}

class OrderDetailsParams extends Equatable {

  final String orderNumber;

  const  OrderDetailsParams({
    required this.orderNumber,

  });

  @override
  List<Object> get props => [

  ];
}
