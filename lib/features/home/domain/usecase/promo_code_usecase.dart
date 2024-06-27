import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_offer_to_cart_entity.dart';
import '../entities/promo_code_entity.dart';
import '../entities/update_cart_offer_entity.dart';
import '../entities/update_cart_product_entity.dart';
import '../repository/home_base_rebository.dart';

class PromoCodeUseCase implements UseCase<PromoCodeEntity, PromoCodeParams> {
  final HomeBaseRepository repository;

  PromoCodeUseCase(this.repository);

  @override
  Future<Either<Failure, PromoCodeEntity>> call(PromoCodeParams params) async {
    return await repository.promoCode(
      shop: params.shop,
      promo: params.promo,
      minAmount: params.minAmount,
    );
  }
}

class PromoCodeParams extends Equatable {

  final int? shop;
  final String? promo;
  final String? minAmount;

  const  PromoCodeParams({
    required this.shop,
    required this.promo,
    required this.minAmount,
  });

  @override
  List<Object> get props => [];
}
