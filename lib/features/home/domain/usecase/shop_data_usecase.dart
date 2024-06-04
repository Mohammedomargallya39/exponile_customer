import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_favourite_entity.dart';
import '../entities/product_details_entity.dart';
import '../entities/shop_data_entity.dart';
import '../repository/home_base_rebository.dart';

class ShopDataUseCase implements UseCase<ShopDataEntity, ShopDataParams> {
  final HomeBaseRepository repository;

  ShopDataUseCase(this.repository);

  @override
  Future<Either<Failure, ShopDataEntity>> call(ShopDataParams params) async {
    return await repository.shopData(
      shopID: params.shopID,
      category: params.category,
      subCategory: params.subCategory,
      from: params.from,
      to: params.to,
    );
  }
}

class ShopDataParams extends Equatable {

  final int? shopID;
  final List? category;
  final List? subCategory;
  final String? from;
  final String? to;

  const ShopDataParams({
    required this.shopID,
    required this.category,
    required this.subCategory,
    required this.from,
    required this.to,
  });

  @override
  List<Object> get props => [];
}
