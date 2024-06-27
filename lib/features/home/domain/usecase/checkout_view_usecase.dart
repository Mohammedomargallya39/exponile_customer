import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/about_exponile_entity.dart';
import '../entities/app_info_entity.dart';
import '../entities/cart_entity.dart';
import '../entities/check_out_view_entity.dart';
import '../repository/home_base_rebository.dart';

class CheckOutViewUseCase implements UseCase<CheckOutViewEntity, NoParams> {
  final HomeBaseRepository repository;

  CheckOutViewUseCase(this.repository);

  @override
  Future<Either<Failure, CheckOutViewEntity>> call(
      NoParams params) async {
    return await repository.checkOutView();
  }
}