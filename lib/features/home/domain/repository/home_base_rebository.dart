import 'package:dartz/dartz.dart';
import 'package:exponile_customer/features/home/domain/entities/categories_entity.dart';
import '../../../../core/error/failures.dart';
import '../entities/about_exponile_entity.dart';
import '../entities/account_data_entity.dart';
import '../entities/add_address_entity.dart';
import '../entities/add_favourite_entity.dart';
import '../entities/add_offer_to_cart_entity.dart';
import '../entities/add_to_cart_entity.dart';
import '../entities/app_info_entity.dart';
import '../entities/areas_entity.dart';
import '../entities/best_sellers_store_entity.dart';
import '../entities/cities_entity.dart';
import '../entities/delete_account_entity.dart';
import '../entities/delete_address_entity.dart';
import '../entities/discover_new_store_entity.dart';
import '../entities/favourite_products_entity.dart';
import '../entities/favourite_stores_entity.dart';
import '../entities/get_location_entity.dart';
import '../entities/home_favourite_store_entity.dart';
import '../entities/landing_entity.dart';
import '../entities/main_search_product_entity.dart';
import '../entities/main_search_shop_entity.dart';
import '../entities/most_deals_entity.dart';
import '../entities/product_data_entity.dart';
import '../entities/product_details_entity.dart';
import '../entities/reset_password_entity.dart';
import '../entities/shop_data_entity.dart';
import '../entities/shop_location_entity.dart';
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

  Future<Either<Failure, FavouriteStoresEntity>> favouriteStores({
    required String? itemType,
  });

  Future<Either<Failure, FavouriteProductsEntity>> favouriteProducts({
    required String? itemType,
  });

  Future<Either<Failure, AccountDataEntity>> accountData();

  Future<Either<Failure, DeleteAddressEntity>> deleteAddress({
    required int? addressID,
  });
  Future<Either<Failure, CitiesEntity>> cities();

  Future<Either<Failure, AreasEntity>> areas({
    required int cityID,
  });
  Future<Either<Failure, LocationEntity>> location({
    required String address,
  });
  Future<Either<Failure, GetLocationEntity>> getLocation({
    required double? lat,
    required double? long,
  });
  Future<Either<Failure, AddLocationEntity>> addLocation({
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
  });
  Future<Either<Failure, LandingEntity>> landing();
  Future<Either<Failure, CategoriesEntity>> categories();
  Future<Either<Failure, MostOffersEntity>> mostOffers();
  Future<Either<Failure, HomeFavouriteStoresEntity>> homeFavouriteStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
});
  Future<Either<Failure, DiscoverNewStoresEntity>> discoverNewStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
});
  Future<Either<Failure, BestSellersStoresEntity>> bestSellersStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
});

}