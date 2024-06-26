import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_offer_to_cart_entity.dart';
import '../entities/update_cart_product_entity.dart';
import '../repository/home_base_rebository.dart';

class UpdateCartProductUseCase implements UseCase<UpdateCartProductEntity, UpdateCartProductParams> {
  final HomeBaseRepository repository;

  UpdateCartProductUseCase(this.repository);

  @override
  Future<Either<Failure, UpdateCartProductEntity>> call(UpdateCartProductParams params) async {
    return await repository.updateCartProduct(
      shop: params.shop,
      item: params.item,
      f1: params.f1,
      f2: params.f2,
      qty: params.qty,
      action: params.action,
    );
  }
}

class UpdateCartProductParams extends Equatable {

  final int? shop;
  final int? item;
  final int? f1;
  final int? f2;
  final int? qty;
  final String? action;

  const  UpdateCartProductParams({
    required this.shop,
    required this.item,
    required this.f1,
    required this.f2,
    required this.qty,
    required this.action,
  });

  @override
  List<Object> get props => [];
}
