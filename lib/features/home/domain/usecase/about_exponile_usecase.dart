import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../entities/about_exponile_entity.dart';
import '../entities/app_info_entity.dart';
import '../repository/home_base_rebository.dart';

class AboutExponileUseCase implements UseCase<AboutExponileEntity, NoParams> {
  final HomeBaseRepository repository;

  AboutExponileUseCase(this.repository);

  @override
  Future<Either<Failure, AboutExponileEntity>> call(
      NoParams params) async {
    return await repository.aboutExponile();
  }
}