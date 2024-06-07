import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/about_exponile_entity.dart';
import '../entities/add_favourite_entity.dart';
import '../entities/add_offer_to_cart_entity.dart';
import '../entities/add_to_cart_entity.dart';
import '../entities/app_info_entity.dart';
import '../entities/delete_account_entity.dart';
import '../entities/main_search_product_entity.dart';
import '../entities/main_search_shop_entity.dart';
import '../entities/product_data_entity.dart';
import '../entities/product_details_entity.dart';
import '../entities/reset_password_entity.dart';
import '../entities/shop_data_entity.dart';
import '../entities/store_offer_details_entity.dart';
import '../entities/store_offers_entity.dart';
import '../entities/submit_complain_entity.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, AppInfoEntity>> appInfo();
  Future<Either<Failure, MainSearchProductEntity>> mainSearchProduct({
    required String searchText,
  });
  Future<Either<Failure, MainSearchShopEntity>> mainSearchShop({
    required String searchText,
  });
  Future<Either<Failure, ProductDetailsEntity>> productDetails({
    required int? productID,
  });
  Future<Either<Failure, ProductDataEntity>> productData({
    required int? productID,
  });
  Future<Either<Failure, AddFavouriteEntity>> addFavourite({
    required int? itemID,
    required String? itemType,
  });
  Future<Either<Failure, AddToCartEntity>> addToCart({
    required int? featureID,
    required String? featureImage,
    required int? qty,
    required String? featureSlug,
  });

  Future<Either<Failure, AddOfferToCartEntity>> addOfferToCart({
    required List? offerProducts,
    required int? qty,
    required String? offerSlug,
  });

  Future<Either<Failure, ShopDataEntity>> shopData({
    required int? shopID,
    required List? category,
    required List? subCategory,
    required String? from,
    required String? to,
  });

  Future<Either<Failure, StoreOffersEntity>> storeOffers({
    required int? storeID,
  });

  Future<Either<Failure, StoreOfferDetailsEntity>> storeOfferDetails({
    required int? offerID,
  });

  Future<Either<Failure, DeleteAccountEntity>> deleteAccount({
    required String password,
  });

  Future<Either<Failure, ResetPasswordSEntity>> resetPasswordS({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  });

  Future<Either<Failure, AboutExponileEntity>> aboutExponile();

  Future<Either<Failure, SubmitComplainEntity>> submitComplain({
    required String name,
    required String email,
    required String phone,
    required String complain,
  });

}