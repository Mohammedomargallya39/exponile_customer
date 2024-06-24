import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/add_rate_entity.dart';
import '../repository/home_base_rebository.dart';

class AddRateUseCase implements UseCase<AddRateEntity, AddRateParams> {
  final HomeBaseRepository repository;

  AddRateUseCase(this.repository);

  @override
  Future<Either<Failure, AddRateEntity>> call(AddRateParams params) async {
    return await repository.addRate(
      id: params.id,
      type: params.type,
      rating: params.rating,
      review: params.review,
      orderID: params.orderID,
    );
  }
}

class AddRateParams extends Equatable {

  final int id;
  final String type;
  final double rating;
  final String review;
  final int orderID;



  const  AddRateParams({
    required this.id,
    required this.type,
    required this.rating,
    required this.review,
    required this.orderID,
  });

  @override
  List<Object> get props => [

  ];
}
