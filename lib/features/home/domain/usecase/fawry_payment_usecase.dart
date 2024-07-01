import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/fawry_payment_entity.dart';
import '../repository/home_base_rebository.dart';

class FawryPaymentUseCase implements UseCase<FawryPaymentEntity, FawryPaymentParams> {
  final HomeBaseRepository repository;

  FawryPaymentUseCase(this.repository);

  @override
  Future<Either<Failure, FawryPaymentEntity>> call(FawryPaymentParams params) async {
    return await repository.fawryPayment(
        params: params
    );
  }
}

class FawryPaymentParams extends Equatable {

  final String? purchaseNumber;
  final String? expirationTime;
  final dynamic fawryFees;
  final String? orderAmount;
  final String? orderStatus;
  final String? paymentAmount;
  final String? paymentMethod;
  final dynamic referenceNumber;
  final dynamic shippingFees;
  final dynamic taxes;

  const FawryPaymentParams({
    required this.purchaseNumber,
    required this.expirationTime,
    required this.fawryFees,
    required this.orderAmount,
    required this.orderStatus,
    required this.paymentAmount,
    required this.paymentMethod,
    required this.referenceNumber,
    required this.shippingFees,
    required this.taxes,
  });

  @override
  List<Object> get props => [];
}