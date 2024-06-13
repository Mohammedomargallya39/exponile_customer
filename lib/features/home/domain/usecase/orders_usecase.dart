import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/orders_entity.dart';
import '../repository/home_base_rebository.dart';

class OrdersUseCase implements UseCase<OrdersEntity, OrdersParams> {
  final HomeBaseRepository repository;

  OrdersUseCase(this.repository);

  @override
  Future<Either<Failure, OrdersEntity>> call(OrdersParams params) async {
    return await repository.orders(
      pageNumber: params.pageNumber,
      status: params.status,
    );
  }
}

class OrdersParams extends Equatable {

  final int pageNumber;
  final String? status;

  const  OrdersParams({
    required this.pageNumber,
    required this.status,
  });

  @override
  List<Object> get props => [

  ];
}
