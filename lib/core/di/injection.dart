import 'package:exponile_customer/features/auth/forget_password/domain/usecase/forget_password_usecase.dart';
import 'package:exponile_customer/features/auth/forget_password/presentation/controller/forget_password_cubit.dart';
import 'package:exponile_customer/features/home/domain/usecase/app_info_usecase.dart';
import 'package:exponile_customer/features/home/domain/usecase/best_sellers_stores_usecase.dart';
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
import '../../features/home/data/data_source/home_remote_data_source.dart';
import '../../features/home/data/repository/home_repository.dart';
import '../../features/home/domain/repository/home_base_rebository.dart';
import '../../features/home/domain/usecase/about_exponile_usecase.dart';
import '../../features/home/domain/usecase/account_data_usecase.dart';
import '../../features/home/domain/usecase/add_favourite_usecase.dart';
import '../../features/home/domain/usecase/add_location_details_usecase.dart';
import '../../features/home/domain/usecase/add_offer_to_cart_usecase.dart';
import '../../features/home/domain/usecase/add_rate_usecase.dart';
import '../../features/home/domain/usecase/add_to_cart_usecase.dart';
import '../../features/home/domain/usecase/areas_usecase.dart';
import '../../features/home/domain/usecase/best_selling_products_usecase.dart';
import '../../features/home/domain/usecase/cancel_order_usecase.dart';
import '../../features/home/domain/usecase/categories_usecase.dart';
import '../../features/home/domain/usecase/cities_usecase.dart';
import '../../features/home/domain/usecase/delete_account_usecase.dart';
import '../../features/home/domain/usecase/delete_address_usecase.dart';
import '../../features/home/domain/usecase/discover_new_stores_usecase.dart';
import '../../features/home/domain/usecase/favourite_products_usecase.dart';
import '../../features/home/domain/usecase/favourite_stores_usecase.dart';
import '../../features/home/domain/usecase/get_location_usecase.dart';
import '../../features/home/domain/usecase/get_payment_order_usecase.dart';
import '../../features/home/domain/usecase/home_favourite_stores_usecase.dart';
import '../../features/home/domain/usecase/hot_deals_usecase.dart';
import '../../features/home/domain/usecase/landing_usecase.dart';
import '../../features/home/domain/usecase/location_usecase.dart';
import '../../features/home/domain/usecase/main_search_product_usecase.dart';
import '../../features/home/domain/usecase/main_search_shop_usecase.dart';
import '../../features/home/domain/usecase/most_offers_usecase.dart';
import '../../features/home/domain/usecase/new_arrivals_usecase.dart';
import '../../features/home/domain/usecase/offers_usecase.dart';
import '../../features/home/domain/usecase/order_details_usecase.dart';
import '../../features/home/domain/usecase/orders_usecase.dart';
import '../../features/home/domain/usecase/product_data_usecase.dart';
import '../../features/home/domain/usecase/product_details_usecase.dart';
import '../../features/home/domain/usecase/recently_viewed_usecase.dart';
import '../../features/home/domain/usecase/reset_password_usecase.dart';
import '../../features/home/domain/usecase/shop_data_usecase.dart';
import '../../features/home/domain/usecase/store_offer_details_usecase.dart';
import '../../features/home/domain/usecase/store_offers_usecase.dart';
import '../../features/home/domain/usecase/submit_complain_usecase.dart';
import '../../features/home/domain/usecase/top_categories_usecase.dart';
import '/core/network/local/cache_helper.dart';
import '/core/network/remote/dio_helper.dart';
import '/core/network/repository.dart';
import '/core/util/cubit/cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerLazySingleton(
        () => AppBloc(
      appInfoUseCase: sl(),
    ),
  );

  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(logInUseCase: sl()));
  sl.registerLazySingleton<ForgetPasswordCubit>(() => ForgetPasswordCubit(
    forgetPasswordUseCase: sl(),
    otpUseCase: sl(),
    resetPasswordUseCase: sl(),
  ));

  sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit(
    registerUseCase: sl(),
  ));

  sl.registerLazySingleton(
        () => HomeCubit(
          mainSearchProductUseCase: sl(),
          mainSearchShopUseCase: sl(),
          productDetailsUseCase: sl(),
          productDataUseCase: sl(),
          addFavouriteUseCase: sl(),
          addToCartUseCase: sl(),
          addOfferToCartUseCase: sl(),
          shopDataUseCase: sl(),
          storeOffersUseCase: sl(),
          storeOfferDetailsUseCase: sl(),
          deleteAccountUseCase: sl(),
          resetPasswordSUseCase: sl(),
          aboutExponileUseCase: sl(),
          submitComplainUseCase: sl(),
          favouriteStoresUseCase: sl(),
          favouriteProductsUseCase: sl(),
          accountDataUseCase: sl(),
          deleteAddressUseCase: sl(),
          citiesUseCase: sl(),
          areasUseCase: sl(),
          locationUseCase: sl(),
          getLocationUseCase: sl(),
          addLocationUseCase: sl(),
          landingUseCase: sl(),
          categoriesUseCase: sl(),
          mostOffersUseCase: sl(),
          homeFavouriteStoresUseCase: sl(),
          discoverNewStoresUseCase: sl(),
          bestSellersStoresUseCase: sl(),
          newArrivalsUseCase: sl(),
          hotDealsUseCase: sl(),
          bestSellingProductsUseCase: sl(),
          topCategoriesUseCase: sl(),
          recentlyViewedUseCase: sl(),
          offersUseCase: sl(),
          ordersUseCase: sl(),
          cancelOrderUseCase: sl(),
          paymentOrderDataUseCase: sl(),
          orderDetailsUseCase: sl(),
          addRateUseCase: sl(),
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

  sl.registerLazySingleton<HomeBaseRepository>(
        () => HomeRepoImplementation(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => AppInfoUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => OTPUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => MainSearchProductUseCase(sl()));
  sl.registerLazySingleton(() => MainSearchShopUseCase(sl()));
  sl.registerLazySingleton(() => ProductDetailsUseCase(sl()));
  sl.registerLazySingleton(() => ProductDataUseCase(sl()));
  sl.registerLazySingleton(() => AddFavouriteUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => AddOfferToCartUseCase(sl()));
  sl.registerLazySingleton(() => ShopDataUseCase(sl()));
  sl.registerLazySingleton(() => StoreOffersUseCase(sl()));
  sl.registerLazySingleton(() => StoreOfferDetailsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordSUseCase(sl()));
  sl.registerLazySingleton(() => AboutExponileUseCase(sl()));
  sl.registerLazySingleton(() => SubmitComplainUseCase(sl()));
  sl.registerLazySingleton(() => FavouriteStoresUseCase(sl()));
  sl.registerLazySingleton(() => FavouriteProductsUseCase(sl()));
  sl.registerLazySingleton(() => AccountDataUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAddressUseCase(sl()));
  sl.registerLazySingleton(() => CitiesUseCase(sl()));
  sl.registerLazySingleton(() => AreasUseCase(sl()));
  sl.registerLazySingleton(() => LocationUseCase(sl()));
  sl.registerLazySingleton(() => GetLocationUseCase(sl()));
  sl.registerLazySingleton(() => AddLocationUseCase(sl()));
  sl.registerLazySingleton(() => LandingUseCase(sl()));
  sl.registerLazySingleton(() => CategoriesUseCase(sl()));
  sl.registerLazySingleton(() => MostOffersUseCase(sl()));
  sl.registerLazySingleton(() => HomeFavouriteStoresUseCase(sl()));
  sl.registerLazySingleton(() => DiscoverNewStoresUseCase(sl()));
  sl.registerLazySingleton(() => BestSellersStoresUseCase(sl()));
  sl.registerLazySingleton(() => NewArrivalsUseCase(sl()));
  sl.registerLazySingleton(() => HotDealsUseCase(sl()));
  sl.registerLazySingleton(() => BestSellingProductsUseCase(sl()));
  sl.registerLazySingleton(() => TopCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => RecentlyViewedUseCase(sl()));
  sl.registerLazySingleton(() => OffersUseCase(sl()));
  sl.registerLazySingleton(() => OrdersUseCase(sl()));
  sl.registerLazySingleton(() => CancelOrderUseCase(sl()));
  sl.registerLazySingleton(() => PaymentOrderDataUseCase(sl()));
  sl.registerLazySingleton(() => OrderDetailsUseCase(sl()));
  sl.registerLazySingleton(() => AddRateUseCase(sl()));

  sl.registerLazySingleton<LogInBaseRemoteDataSource>(
        () => LogInRemoteDataSourceImpl(dioHelper: sl()),
  );

  sl.registerLazySingleton<ForgetPasswordBaseRemoteDataSource>(
        () => ForgetPasswordRemoteDataSourceImpl(dioHelper: sl()),
  );

  sl.registerLazySingleton<RegisterBaseRemoteDataSource>(
        () => RegisterRemoteDataSourceImpl(dioHelper: sl()),
  );

  sl.registerLazySingleton<HomeBaseRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(dioHelper: sl()),
  );

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

