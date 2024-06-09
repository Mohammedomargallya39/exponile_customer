import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_offer_to_cart_entity.dart';
import '../repository/home_base_rebository.dart';

class AddOfferToCartUseCase implements UseCase<AddOfferToCartEntity, AddOfferToCartParams> {
  final HomeBaseRepository repository;

  AddOfferToCartUseCase(this.repository);

  @override
  Future<Either<Failure, AddOfferToCartEntity>> call(AddOfferToCartParams params) async {
    return await repository.addOfferToCart(
      offerProducts: params.offerProducts,
      qty: params.qty,
      offerSlug: params.offerSlug,
    );
  }
}

class AddOfferToCartParams extends Equatable {

  final List? offerProducts;
  final int? qty;
  final String? offerSlug;

  const  AddOfferToCartParams({
    required this.offerProducts,
    required this.qty,
    required this.offerSlug,
  });

  @override
  List<Object> get props => [];
}
