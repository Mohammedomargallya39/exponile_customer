import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_offer_to_cart_entity.dart';
import '../entities/update_cart_product_entity.dart';
import '../repository/home_base_rebository.dart';

class DeleteCartItemUseCase implements UseCase<DeleteCartItemEntity, DeleteCartItemParams> {
  final HomeBaseRepository repository;

  DeleteCartItemUseCase(this.repository);

  @override
  Future<Either<Failure, DeleteCartItemEntity>> call(DeleteCartItemParams params) async {
    return await repository.deleteCartItem(
      shop: params.shop,
      item: params.item,
      item: params.type,
    );
  }
}

class DeleteCartItemParams extends Equatable {

  final int? shop;
  final int? item;
  final String? type;

  const  DeleteCartItemParams({
    required this.shop,
    required this.item,
    required this.type,
  });

  @override
  List<Object> get props => [];
}