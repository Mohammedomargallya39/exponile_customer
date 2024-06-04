import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_favourite_entity.dart';
import '../entities/add_to_cart_entity.dart';
import '../entities/product_details_entity.dart';
import '../repository/home_base_rebository.dart';

class AddToCartUseCase implements UseCase<AddToCartEntity, AddToCartParams> {
  final HomeBaseRepository repository;

  AddToCartUseCase(this.repository);

  @override
  Future<Either<Failure, AddToCartEntity>> call(AddToCartParams params) async {
    return await repository.addToCart(
      featureID: params.featureID,
      featureImage: params.featureImage,
      qty: params.qty,
      featureSlug: params.featureSlug,
    );
  }
}

class AddToCartParams extends Equatable {

  final int? featureID;
  final String? featureImage;
  final int? qty;
  final String? featureSlug;

  const  AddToCartParams({
    required this.featureID,
    required this.featureImage,
    required this.qty,
    required this.featureSlug,
  });

  @override
  List<Object> get props => [];
}
