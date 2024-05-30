import 'package:exponile_customer/features/auth/forget_password/domain/usecase/forget_password_usecase.dart';
import 'package:exponile_customer/features/auth/forget_password/presentation/controller/forget_password_cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/forget_password/data/data_source/forget_password_remote_data_source.dart';
import '../../features/auth/forget_password/data/repository/forget_password_repository.dart';
import '../../features/auth/forget_password/domain/repository/forget_password_base_repository.dart';
import '../../features/auth/forget_password/domain/usecase/otp_usecase.dart';
import '../../features/auth/forget_password/domain/usecase/reset_password_usecase.dart';
import '../../features/auth/login/data/data_source/login_remote_data_source.dart';
import '../../features/auth/login/data/repository/login_repository.dart';
import '../../features/auth/login/domain/repository/login_base_repository.dart';
import '../../features/auth/login/domain/usecase/login_usecase.dart';
import '../../features/auth/login/presentation/controller/login_cubit.dart';
import '../../features/auth/register/data/data_source/register_remote_data_source.dart';
import '../../features/auth/register/data/repository/register_repository.dart';
import '../../features/auth/register/domain/repository/register_base_rebository.dart';
import '../../features/auth/register/domain/usecase/register_usecase.dart';
import '../../features/auth/register/presentation/controller/register_cubit.dart';
import '/core/network/local/cache_helper.dart';
import '/core/network/remote/dio_helper.dart';
import '/core/network/repository.dart';
import '/core/util/cubit/cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerLazySingleton(
        () => AppBloc(
          // appInfoUseCase: sl(),
        ),
  );

  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(logInUseCase: sl()));
  sl.registerLazySingleton<ForgetPasswordCubit>(() => ForgetPasswordCubit(
      forgetPasswordUseCase: sl(),
      otpUseCase: sl(),
      resetPasswordUseCase: sl(),
  ),
  );

  sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit(
    registerUseCase: sl(),
  ));


  sl.registerLazySingleton(
        () => HomeCubit(

        ),
  );

  sl.registerLazySingleton<Repository>(
        () => RepoImplementation(
      dioHelper: sl(),
      cacheHelper: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<LogInBaseRepository>(
        () => LoginRepoImplementation(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<ForgetPasswordBaseRepository>(
        () => ForgetPasswordImplementation(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<RegisterBaseRepository>(
        () => RegisterRepoImplementation(remoteDataSource: sl()),
  );

  // sl.registerLazySingleton<HomeBaseRepository>(
  //       () => HomeRepoImplementation(remoteDataSource: sl()),
  // );


  //Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => OTPUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));




  sl.registerLazySingleton<LogInBaseRemoteDataSource>(
        () => LogInRemoteDataSourceImpl(dioHelper: sl()),
  );

  sl.registerLazySingleton<ForgetPasswordBaseRemoteDataSource>(
        () => ForgetPasswordRemoteDataSourceImpl(dioHelper: sl()),
  );


  sl.registerLazySingleton<RegisterBaseRemoteDataSource>(
        () => RegisterRemoteDataSourceImpl(dioHelper: sl()),
  );

  // sl.registerLazySingleton<HomeBaseRemoteDataSource>(
  //       () => HomeRemoteDataSourceImpl(dioHelper: sl()),
  // );

  // Core
  sl.registerLazySingleton<DioHelper>(
        () => DioImpl(),
  );

  sl.registerLazySingleton<CacheHelper>(
        () => CacheImpl(
      sl(),
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}