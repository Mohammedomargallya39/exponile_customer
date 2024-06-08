import 'package:dartz/dartz.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/about_exponile_entity.dart';
import '../../domain/entities/account_data_entity.dart';
import '../../domain/entities/add_favourite_entity.dart';
import '../../domain/entities/add_offer_to_cart_entity.dart';
import '../../domain/entities/add_to_cart_entity.dart';
import '../../domain/entities/app_info_entity.dart';
import '../../domain/entities/delete_account_entity.dart';
import '../../domain/entities/delete_address_entity.dart';
import '../../domain/entities/favourite_products_entity.dart';
import '../../domain/entities/favourite_stores_entity.dart';
import '../../domain/entities/main_search_product_entity.dart';
import '../../domain/entities/main_search_shop_entity.dart';
import '../../domain/entities/product_data_entity.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/reset_password_entity.dart';
import '../../domain/entities/shop_data_entity.dart';
import '../../domain/entities/store_offer_details_entity.dart';
import '../../domain/entities/store_offers_entity.dart';
import '../../domain/entities/submit_complain_entity.dart';
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



}

