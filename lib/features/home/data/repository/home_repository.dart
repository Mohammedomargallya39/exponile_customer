import 'package:dartz/dartz.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/add_favourite_entity.dart';
import '../../domain/entities/add_to_cart_entity.dart';
import '../../domain/entities/app_info_entity.dart';
import '../../domain/entities/main_search_product_entity.dart';
import '../../domain/entities/main_search_shop_entity.dart';
import '../../domain/entities/product_data_entity.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/shop_data_entity.dart';
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


}

