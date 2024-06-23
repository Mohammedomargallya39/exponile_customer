import 'package:dartz/dartz.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/about_exponile_entity.dart';
import '../../domain/entities/account_data_entity.dart';
import '../../domain/entities/add_address_entity.dart';
import '../../domain/entities/add_favourite_entity.dart';
import '../../domain/entities/add_offer_to_cart_entity.dart';
import '../../domain/entities/add_to_cart_entity.dart';
import '../../domain/entities/app_info_entity.dart';
import '../../domain/entities/areas_entity.dart';
import '../../domain/entities/best_sellers_store_entity.dart';
import '../../domain/entities/best_selling_products_entity.dart';
import '../../domain/entities/cancel_order_entity.dart';
import '../../domain/entities/categories_entity.dart';
import '../../domain/entities/cities_entity.dart';
import '../../domain/entities/delete_account_entity.dart';
import '../../domain/entities/delete_address_entity.dart';
import '../../domain/entities/discover_new_store_entity.dart';
import '../../domain/entities/favourite_products_entity.dart';
import '../../domain/entities/favourite_stores_entity.dart';
import '../../domain/entities/get_location_entity.dart';
import '../../domain/entities/home_favourite_store_entity.dart';
import '../../domain/entities/hot_deals_entity.dart';
import '../../domain/entities/landing_entity.dart';
import '../../domain/entities/main_search_product_entity.dart';
import '../../domain/entities/main_search_shop_entity.dart';
import '../../domain/entities/most_deals_entity.dart';
import '../../domain/entities/new_arrivals_entity.dart';
import '../../domain/entities/offers_entity.dart';
import '../../domain/entities/order_details_entity.dart';
import '../../domain/entities/orders_entity.dart';
import '../../domain/entities/payment_order_data_entity.dart';
import '../../domain/entities/product_data_entity.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/recently_viewed_entity.dart';
import '../../domain/entities/reset_password_entity.dart';
import '../../domain/entities/shop_data_entity.dart';
import '../../domain/entities/shop_location_entity.dart';
import '../../domain/entities/store_offer_details_entity.dart';
import '../../domain/entities/store_offers_entity.dart';
import '../../domain/entities/submit_complain_entity.dart';
import '../../domain/entities/top_categories_entity.dart';
import '../../domain/repository/home_base_rebository.dart';
import '../data_source/home_remote_data_source.dart';

typedef CallAppInfo = Future<AppInfoEntity> Function();
typedef CallMainSearchProduct = Future<MainSearchProductEntity> Function();
typedef CallMainSearchShop = Future<MainSearchShopEntity> Function();
typedef CallProductDetails= Future<ProductDetailsEntity> Function();
typedef CallProductData= Future<ProductDataEntity> Function();
typedef CallAddFavourite= Future<AddFavouriteEntity> Function();
typedef CallAddToCart = Future<AddToCartEntity> Function();
typedef CallShopData = Future<ShopDataEntity> Function();
typedef CallStoreOffers = Future<StoreOffersEntity> Function();
typedef CallStoreOfferDetails = Future<StoreOfferDetailsEntity> Function();
typedef CallOfferAddToCart = Future<AddOfferToCartEntity> Function();
typedef CallDeleteAccount = Future<DeleteAccountEntity> Function();
typedef CallResetPasswordS = Future<ResetPasswordSEntity> Function();
typedef CallAboutExponile = Future<AboutExponileEntity> Function();
typedef CallSubmitComplain = Future<SubmitComplainEntity> Function();
typedef CallFavouriteStores = Future<FavouriteStoresEntity> Function();
typedef CallFavouriteProducts = Future<FavouriteProductsEntity> Function();
typedef CallAccountData = Future<AccountDataEntity> Function();
typedef CallDeleteAddress = Future<DeleteAddressEntity> Function();
typedef CallCities = Future<CitiesEntity> Function();
typedef CallAreas = Future<AreasEntity> Function();
typedef CallLocation= Future<LocationEntity> Function();
typedef CallGetLocation= Future<GetLocationEntity> Function();
typedef CallAddLocation= Future<AddLocationEntity> Function();
typedef CallLanding= Future<LandingEntity> Function();
typedef CallCategories= Future<CategoriesEntity> Function();
typedef CallMostOffers= Future<MostOffersEntity> Function();
typedef CallHomeFavouriteStores= Future<HomeFavouriteStoresEntity> Function();
typedef CallDiscoverNewStores= Future<DiscoverNewStoresEntity> Function();
typedef CallBestSellersStores= Future<BestSellersStoresEntity> Function();
typedef CallNewArrivals= Future<NewArrivalsEntity> Function();
typedef CallHotDeals= Future<HotDealsEntity> Function();
typedef CallBestSellingProducts= Future<List<BestSellingProductsEntity>> Function();
typedef CallTopCategories= Future<TopCategoriesEntity> Function();
typedef CallRecentlyViewed= Future<List<RecentlyViewedEntity>> Function();
typedef CallOffers= Future<OffersEntity> Function();
typedef CallOrders= Future<OrdersEntity> Function();
typedef CallCancelOrder= Future<CancelOrderEntity> Function();
typedef CallOrderDetails= Future<OrderDetailsEntity> Function();
typedef CallPaymentOrderData= Future<PaymentOrderDataEntity> Function();


class HomeRepoImplementation extends HomeBaseRepository {
  final HomeBaseRemoteDataSource remoteDataSource;

  HomeRepoImplementation({
    required this.remoteDataSource,
  });

  Future<Either<Failure, AppInfoEntity>> fetchAppInfoData(
      CallAppInfo mainMethod,
      ) async {
    try {
      final appInfoData = await mainMethod();
      return Right(appInfoData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AppInfoEntity>> appInfo() async {
    return await fetchAppInfoData(()
    {
      return remoteDataSource.appInfo();
    });
  }


  Future<Either<Failure, MainSearchProductEntity>> fetchMainSearchProduct(
      CallMainSearchProduct mainMethod,
      ) async {
    try {
      final mainSearchProduct = await mainMethod();
      return Right(mainSearchProduct);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, MainSearchProductEntity>> mainSearchProduct({
    required String searchText,
  }) async {
    return await fetchMainSearchProduct(()
    {
      return remoteDataSource.mainSearchProduct(
        searchText: searchText,
      );
    });
  }


  Future<Either<Failure, MainSearchShopEntity>> fetchMainSearchShop(
      CallMainSearchShop mainMethod,
      ) async {
    try {
      final mainSearchShop = await mainMethod();
      return Right(mainSearchShop);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, MainSearchShopEntity>> mainSearchShop({
    required String searchText,
  }) async {
    return await fetchMainSearchShop(()
    {
      return remoteDataSource.mainSearchShop(
        searchText: searchText,
      );
    });
  }

  Future<Either<Failure, ProductDetailsEntity>> fetchProductDetails(
      CallProductDetails mainMethod,
      ) async {
    try {
      final productDetails = await mainMethod();
      return Right(productDetails);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, ProductDetailsEntity>> productDetails(
      {
        required int? productID,
      }) async {
    return await fetchProductDetails(()
    {
      return remoteDataSource.productDetails(
        productID : productID,
      );
    });
  }


  Future<Either<Failure, ProductDataEntity>> fetchProductData(
      CallProductData mainMethod,
      ) async {
    try {
      final productData = await mainMethod();
      return Right(productData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, ProductDataEntity>> productData(
      {
        required int? productID,
      }) async {
    return await fetchProductData(()
    {
      return remoteDataSource.productData(
        productID : productID,
      );
    });
  }


  Future<Either<Failure, AddFavouriteEntity>> fetchAddFavourite(
      CallAddFavourite mainMethod,
      ) async {
    try {
      final addFavourite = await mainMethod();
      return Right(addFavourite);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AddFavouriteEntity>> addFavourite(
      {
        required int? itemID,
        required String? itemType,
      }) async {
    return await fetchAddFavourite(()
    {
      return remoteDataSource.addFavourite(
        itemID : itemID,
        itemType : itemType,
      );
    });
  }


  Future<Either<Failure, AddToCartEntity>> fetchAddToCart(
      CallAddToCart mainMethod,
      ) async {
    try {
      final addToCart = await mainMethod();
      return Right(addToCart);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AddToCartEntity>> addToCart(
      {
        required int? featureID,
        required String? featureImage,
        required int? qty,
        required String? featureSlug,
      }) async {
    return await fetchAddToCart(()
    {
      return remoteDataSource.addToCart(
        featureID : featureID,
        featureImage : featureImage,
        qty : qty,
        featureSlug : featureSlug,
      );
    });
  }



  Future<Either<Failure, ShopDataEntity>> fetchShopData(
      CallShopData mainMethod,
      ) async {
    try {
      final shopData = await mainMethod();
      return Right(shopData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, ShopDataEntity>> shopData(
      {
        required int? shopID,
        required List? category,
        required List? subCategory,
        required String? from,
        required String? to,
      }) async {
    return await fetchShopData(()
    {
      return remoteDataSource.shopData(
        shopID : shopID,
        category : category,
        subCategory : subCategory,
        from : from,
        to : to,
      );
    });
  }



  Future<Either<Failure, StoreOffersEntity>> fetchStoreOffers(
      CallStoreOffers mainMethod,
      ) async {
    try {
      final storeOffers = await mainMethod();
      return Right(storeOffers);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, StoreOffersEntity>> storeOffers(
      {
        required int? storeID,
      }) async {
    return await fetchStoreOffers(()
    {
      return remoteDataSource.storeOffers(
        storeID : storeID,
      );
    });
  }


  Future<Either<Failure, StoreOfferDetailsEntity>> fetchStoreOfferDetails(
      CallStoreOfferDetails mainMethod,
      ) async {
    try {
      final storeOfferDetails = await mainMethod();
      return Right(storeOfferDetails);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, StoreOfferDetailsEntity>> storeOfferDetails(
      {
        required int? offerID,
      }) async {
    return await fetchStoreOfferDetails(()
    {
      return remoteDataSource.storeOfferDetails(
        offerID : offerID,
      );
    });
  }


  Future<Either<Failure, AddOfferToCartEntity>> fetchAddOfferToCart(
      CallOfferAddToCart mainMethod,
      ) async {
    try {
      final addOfferToCart = await mainMethod();
      return Right(addOfferToCart);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AddOfferToCartEntity>> addOfferToCart(
      {
        required List? offerProducts,
        required int? qty,
        required String? offerSlug,
      }) async {
    return await fetchAddOfferToCart(()
    {
      return remoteDataSource.addOfferToCart(
        offerProducts : offerProducts,
        qty : qty,
        offerSlug : offerSlug,
      );
    });
  }



  Future<Either<Failure, DeleteAccountEntity>> fetchDeleteAccount(
      CallDeleteAccount mainMethod,
      ) async {
    try {
      final deleteAccount = await mainMethod();
      return Right(deleteAccount);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, DeleteAccountEntity>> deleteAccount({
    required String password
  }) async {
    return await fetchDeleteAccount(()
    {
      return remoteDataSource.deleteAccount(
          password: password
      );
    });
  }


  Future<Either<Failure, ResetPasswordSEntity>> fetchResetPasswordS(
      CallResetPasswordS mainMethod,
      ) async {
    try {
      final resetPasswordS = await mainMethod();
      return Right(resetPasswordS);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordSEntity>> resetPasswordS({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword
  }) async {
    return await fetchResetPasswordS(()
    {
      return remoteDataSource.resetPasswordS(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
    });
  }


  Future<Either<Failure, AboutExponileEntity>> fetchAboutExponile(
      CallAboutExponile mainMethod,
      ) async {
    try {
      final aboutExponile = await mainMethod();
      return Right(aboutExponile);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AboutExponileEntity>> aboutExponile() async {
    return await fetchAboutExponile(()
    {
      return remoteDataSource.aboutExponile();
    });
  }


  Future<Either<Failure, SubmitComplainEntity>> fetchSubmitComplain(
      CallSubmitComplain mainMethod,
      ) async {
    try {
      final submitComplain = await mainMethod();
      return Right(submitComplain);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, SubmitComplainEntity>> submitComplain({
    required String name,
    required String email,
    required String phone,
    required String complain,
  }) async {
    return await fetchSubmitComplain(()
    {
      return remoteDataSource.submitComplain(
        name: name,
        email: email,
        phone: phone,
        complain: complain,
      );
    });
  }

  Future<Either<Failure, FavouriteStoresEntity>> fetchFavouriteStores(
      CallFavouriteStores mainMethod,
      ) async {
    try {
      final favouriteStores = await mainMethod();
      return Right(favouriteStores);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, FavouriteStoresEntity>> favouriteStores(
      {
        required String? itemType,
      }) async {
    return await fetchFavouriteStores(()
    {
      return remoteDataSource.favouriteStores(
        itemType : itemType,
      );
    });
  }


  Future<Either<Failure, FavouriteProductsEntity>> fetchFavouriteProducts(
      CallFavouriteProducts mainMethod,
      ) async {
    try {
      final favouriteProducts = await mainMethod();
      return Right(favouriteProducts);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, FavouriteProductsEntity>> favouriteProducts(
      {
        required String? itemType,
      }) async {
    return await fetchFavouriteProducts(()
    {
      return remoteDataSource.favouriteProducts(
        itemType : itemType,
      );
    });
  }


  Future<Either<Failure, AccountDataEntity>> fetchAccountData(
      CallAccountData mainMethod,
      ) async {
    try {
      final accountData = await mainMethod();
      return Right(accountData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AccountDataEntity>> accountData() async {
    return await fetchAccountData(()
    {
      return remoteDataSource.accountData();
    });
  }


  Future<Either<Failure, DeleteAddressEntity>> fetchDeleteAddress(
      CallDeleteAddress mainMethod,
      ) async {
    try {
      final deleteAddress = await mainMethod();
      return Right(deleteAddress);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, DeleteAddressEntity>> deleteAddress({
    required int? addressID,
}) async {
    return await fetchDeleteAddress(()
    {
      return remoteDataSource.deleteAddress(
        addressID : addressID,
      );
    });
  }


  Future<Either<Failure, CitiesEntity>> fetchCities(
      CallCities mainMethod,
      ) async {
    try {
      final citiesData = await mainMethod();
      return Right(citiesData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, CitiesEntity>> cities() async {
    return await fetchCities(()
    {
      return remoteDataSource.cities();
    });
  }



  Future<Either<Failure, AreasEntity>> fetchAreas(
      CallAreas mainMethod,
      ) async {
    try {
      final areasData = await mainMethod();
      return Right(areasData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AreasEntity>> areas(
      {
        required int cityID,
      }) async {
    return await fetchAreas(()
    {
      return remoteDataSource.areas(
        cityID: cityID,
      );
    });
  }


  Future<Either<Failure, LocationEntity>> fetchLocation(
      CallLocation mainMethod,
      ) async {
    try {
      final location = await mainMethod();
      return Right(location);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> location(
      {
        required String? address,
      }) async {
    return await fetchLocation(()
    {
      return remoteDataSource.location(
        address : address,
      );
    });
  }


  Future<Either<Failure, GetLocationEntity>> fetchGetLocation(
      CallGetLocation mainMethod,
      ) async {
    try {
      final getLocation = await mainMethod();
      return Right(getLocation);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, GetLocationEntity>> getLocation(
      {
        required double? lat,
        required double? long,
      }) async {
    return await fetchGetLocation(()
    {
      return remoteDataSource.getLocation(
        lat : lat,
        long : long,
      );
    });
  }


  Future<Either<Failure, AddLocationEntity>> fetchAddLocation(
      CallAddLocation mainMethod,
      ) async {
    try {
      final addLocation = await mainMethod();
      return Right(addLocation);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AddLocationEntity>> addLocation(
      {
        required int? area,
        required int? governorate,
        required String? late,
        required String? long,
        required String? streetName,
        required String? buildingName,
        required String? landmark,
        required int? floorNo,
        required int? aptNo,
        required String? type,
      }) async {
    return await fetchAddLocation(()
    {
      return remoteDataSource.addLocation(
        area : area,
        governorate : governorate,
        late : late,
        long : long,
        streetName : streetName,
        buildingName : buildingName,
        landmark : landmark,
        floorNo : floorNo,
        aptNo : aptNo,
        type : type,
      );
    });
  }


  Future<Either<Failure, LandingEntity>> fetchLanding(
      CallLanding mainMethod,
      ) async {
    try {
      final landing = await mainMethod();
      return Right(landing);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, LandingEntity>> landing() async {
    return await fetchLanding(()
    {
      return remoteDataSource.landing();
    });
  }


  Future<Either<Failure, CategoriesEntity>> fetchCategories(
      CallCategories mainMethod,
      ) async {
    try {
      final categories = await mainMethod();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, CategoriesEntity>> categories() async {
    return await fetchCategories(()
    {
      return remoteDataSource.categories();
    });
  }


  Future<Either<Failure, MostOffersEntity>> fetchMostOffers(
      CallMostOffers mainMethod,
      ) async {
    try {
      final mostOffers = await mainMethod();
      return Right(mostOffers);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, MostOffersEntity>> mostOffers() async {
    return await fetchMostOffers(()
    {
      return remoteDataSource.mostOffers();
    });
  }


  Future<Either<Failure, HomeFavouriteStoresEntity>> fetchHomeFavouriteStores(
      CallHomeFavouriteStores mainMethod,
      ) async {
    try {
      final homeFavouriteStores = await mainMethod();
      return Right(homeFavouriteStores);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, HomeFavouriteStoresEntity>> homeFavouriteStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
}) async {
    return await fetchHomeFavouriteStores(()
    {
      return remoteDataSource.homeFavouriteStores(
        pageNumber: pageNumber,
        storeCategory: storeCategory,
        offerType: offerType,
        sortedBy: sortedBy,
      );
    });
  }


  Future<Either<Failure, DiscoverNewStoresEntity>> fetchDiscoverNewStores(
      CallDiscoverNewStores mainMethod,
      ) async {
    try {
      final discoverNewStores = await mainMethod();
      return Right(discoverNewStores);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, DiscoverNewStoresEntity>> discoverNewStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
}) async {
    return await fetchDiscoverNewStores(()
    {
      return remoteDataSource.discoverNewStores(
        pageNumber: pageNumber,
        storeCategory: storeCategory,
        offerType: offerType,
        sortedBy: sortedBy,
      );
    });
  }



  Future<Either<Failure, BestSellersStoresEntity>> fetchBestSellersStores(
      CallBestSellersStores mainMethod,
      ) async {
    try {
      final bestSellers = await mainMethod();
      return Right(bestSellers);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, BestSellersStoresEntity>> bestSellersStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
  }) async {
    return await fetchBestSellersStores(()
    {
      return remoteDataSource.bestSellersStores(
        pageNumber: pageNumber,
        storeCategory: storeCategory,
        offerType: offerType,
        sortedBy: sortedBy,
      );
    });
  }


  Future<Either<Failure, NewArrivalsEntity>> fetchNewArrivals(
      CallNewArrivals mainMethod,
      ) async {
    try {
      final newArrivals = await mainMethod();
      return Right(newArrivals);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, NewArrivalsEntity>> newArrivals({
    required int? pageNumber,
    required List<String>? productCategories,
    required List<String>? storeCategories,
  }) async {
    return await fetchNewArrivals(()
    {
      return remoteDataSource.newArrivals(
        pageNumber: pageNumber,
        productCategories: productCategories,
        storeCategories: storeCategories,
      );
    });
  }



  Future<Either<Failure, HotDealsEntity>> fetchHotDeals(
      CallHotDeals mainMethod,
      ) async {
    try {
      final hotDeals = await mainMethod();
      return Right(hotDeals);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, HotDealsEntity>> hotDeals({
    required int? pageNumber,
    required List<String>? productCategories,
    required List<String>? storeCategories,
  }) async {
    return await fetchHotDeals(()
    {
      return remoteDataSource.hotDeals(
        pageNumber: pageNumber,
        productCategories: productCategories,
        storeCategories: storeCategories,
      );
    });
  }


  Future<Either<Failure, List<BestSellingProductsEntity>>> fetchBestSellingProducts(
      CallBestSellingProducts mainMethod,
      ) async {
    try {
      final bestSellingProducts = await mainMethod();
      return Right(bestSellingProducts);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<BestSellingProductsEntity>>> bestSellingProducts() async {
    return await fetchBestSellingProducts(()
    {
      return remoteDataSource.bestSellingProducts();
    });
  }



  Future<Either<Failure, TopCategoriesEntity>> fetchTopCategories(
      CallTopCategories mainMethod,
      ) async {
    try {
      final topCategories = await mainMethod();
      return Right(topCategories);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, TopCategoriesEntity>> topCategories() async {
    return await fetchTopCategories(()
    {
      return remoteDataSource.topCategories();
    });
  }


  Future<Either<Failure, List<RecentlyViewedEntity>>> fetchRecentlyViewed(
      CallRecentlyViewed mainMethod,
      ) async {
    try {
      final recentlyViewed = await mainMethod();
      return Right(recentlyViewed);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<RecentlyViewedEntity>>> recentlyViewed() async {
    return await fetchRecentlyViewed(()
    {
      return remoteDataSource.recentlyViewed();
    });
  }



  Future<Either<Failure, OffersEntity>> fetchOffers(
      CallOffers mainMethod,
      ) async {
    try {
      final offers = await mainMethod();
      return Right(offers);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, OffersEntity>> offers({
    required int? pageNumber,
    required List<String>? productCategories,
    required List<String>? storeCategories,
}) async {
    return await fetchOffers(()
    {
      return remoteDataSource.offers(
        pageNumber: pageNumber,
        productCategories: productCategories,
        storeCategories: storeCategories,
      );
    });
  }



  Future<Either<Failure, OrdersEntity>> fetchOrders(
      CallOrders mainMethod,
      ) async {
    try {
      final orders = await mainMethod();
      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, OrdersEntity>> orders({
    required int? pageNumber,
    required String? status,
}) async {
    return await fetchOrders(()
    {
      return remoteDataSource.orders(
        pageNumber: pageNumber,
        status: status,
      );
    });
  }


  Future<Either<Failure, CancelOrderEntity>> fetchCancelOrder(
      CallCancelOrder mainMethod,
      ) async {
    try {
      final cancelOrder = await mainMethod();
      return Right(cancelOrder);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, CancelOrderEntity>> cancelOrder({
    required String? orderNumber,
  }) async {
    return await fetchCancelOrder(()
    {
      return remoteDataSource.cancelOrder(
        orderNumber: orderNumber,
      );
    });
  }


  Future<Either<Failure, OrderDetailsEntity>> fetchOrderDetails(
      CallOrderDetails mainMethod,
      ) async {
    try {
      final orderDetails = await mainMethod();
      return Right(orderDetails);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, OrderDetailsEntity>> orderDetails({
    required String? orderNumber,
  }) async {
    return await fetchOrderDetails(()
    {
      return remoteDataSource.orderDetails(
        orderNumber: orderNumber,
      );
    });
  }



  Future<Either<Failure, PaymentOrderDataEntity>> fetchPaymentOrderData(
      CallPaymentOrderData mainMethod,
      ) async {
    try {
      final paymentOrderData = await mainMethod();
      return Right(paymentOrderData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, PaymentOrderDataEntity>> paymentOrderData({
    required String? poNumber,
  }) async {
    return await fetchPaymentOrderData(()
    {
      return remoteDataSource.paymentOrderData(
        poNumber: poNumber,
      );
    });
  }





}

