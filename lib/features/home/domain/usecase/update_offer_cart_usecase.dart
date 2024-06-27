import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_offer_to_cart_entity.dart';
import '../entities/update_cart_offer_entity.dart';
import '../entities/update_cart_product_entity.dart';
import '../repository/home_base_rebository.dart';

class UpdateCartOfferUseCase implements UseCase<UpdateCartOfferEntity, UpdateCartOfferParams> {
  final HomeBaseRepository repository;

  UpdateCartOfferUseCase(this.repository);

  @override
  Future<Either<Failure, UpdateCartOfferEntity>> call(UpdateCartOfferParams params) async {
    return await repository.updateCartOffer(
      shop: params.shop,
      item: params.item,
      qty: params.qty,
      action: params.action,
    );
  }
}

class UpdateCartOfferParams extends Equatable {

  final int? shop;
  final int? item;
  final int? qty;
  final String? action;

  const  UpdateCartOfferParams({
    required this.shop,
    required this.item,
    required this.qty,
    required this.action,
  });

  @override
  List<Object> get props => [];
}
