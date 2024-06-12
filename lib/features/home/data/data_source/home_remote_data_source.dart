import 'package:dio/dio.dart';
import 'package:exponile_customer/features/home/data/models/add_favourite_model.dart';
import '../../../../../core/network/remote/api_endpoints.dart';
import '../../../../../core/network/remote/dio_helper.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../models/about_exponile_model.dart';
import '../models/account_data_model.dart';
import '../models/add_location_model.dart';
import '../models/add_offer_to_cart_model.dart';
import '../models/add_to_cart_model.dart';
import '../models/app_info_model.dart';
import '../models/areasModel.dart';
import '../models/best_sellers_stores_model.dart';
import '../models/best_selling_products_model.dart';
import '../models/categories_model.dart';
import '../models/cities_model.dart';
import '../models/delete_account_model.dart';
import '../models/delete_address_model.dart';
import '../models/discover_new_stores_model.dart';
import '../models/favourite_products_model.dart';
import '../models/favourite_stores_model.dart';
import '../models/get_location_model.dart';
import '../models/home_favourite_stores_model.dart';
import '../models/hot_deals_model.dart';
import '../models/landing_model.dart';
import '../models/main_search_product_model.dart';
import '../models/main_search_shop_model.dart';
import '../models/most_offers_model.dart';
import '../models/new_arrivals_model.dart';
import '../models/product_data_model.dart';
import '../models/product_details_model.dart';
import '../models/recently_viewed_model.dart';
import '../models/reset_password_model.dart';
import '../models/shop_data_model.dart';
import '../models/shop_location_model.dart';
import '../models/store_offer_details_model.dart';
import '../models/store_offers_model.dart';
import '../models/submit_complain_model.dart';
import '../models/top_categories_model.dart';

abstract class HomeBaseRemoteDataSource {
  Future<AppInfoModel> appInfo();
  Future<MainSearchProductModel> mainSearchProduct({
    required String searchText,
  });
  Future<MainSearchShopModel> mainSearchShop({
    required String searchText,
  });
  Future<ProductDetailsModel> productDetails({
    required int? productID,
  });
  Future<ProductDataModel> productData({
    required int? productID,
  });
  Future<AddFavouriteModel> addFavourite({
    required int? itemID,
    required String? itemType,
  });
  Future<AddToCartModel> addToCart({
    required int? featureID,
    required String? featureImage,
    required int? qty,
    required String? featureSlug,
  });
  Future<ShopDataModel> shopData({
    required int? shopID,
    required List? category,
    required List? subCategory,
    required String? from,
    required String? to,
  });
  Future<StoreOffersModel> storeOffers({
    required int? storeID,
  });
  Future<StoreOfferDetailsModel> storeOfferDetails({
    required int? offerID,
  });
  Future<AddOfferToCartModel> addOfferToCart({
    required List? offerProducts,
    required int? qty,
    required String? offerSlug,
  });
  Future<DeleteAccountModel> deleteAccount({
    required String password,
  });
  Future<ResetPasswordSModel> resetPasswordS({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  });
  Future<AboutExponileModel> aboutExponile();
  Future<SubmitComplainModel> submitComplain({
    required String name,
    required String email,
    required String phone,
    required String complain,
  });
  Future<FavouriteStoresModel> favouriteStores({
    required String? itemType,
  });
  Future<FavouriteProductsModel> favouriteProducts({
    required String? itemType,
  });
  Future<AccountDataModel> accountData();
  Future<DeleteAddressModel> deleteAddress({
    required int? addressID,
});
  Future<CitiesModel> cities();
  Future<AreasModel> areas({
    required int cityID,
  });
  Future<LocationModel> location({
    required String? address,
  });
  Future<GetLocationModel> getLocation({
    required double? lat,
    required double? long,
  });
  Future<AddLocationModel> addLocation({
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
  Future<LandingModel> landing();
  Future<CategoriesModel> categories();
  Future<MostOffersModel> mostOffers();
  Future<HomeFavouriteStoresModel> homeFavouriteStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
  });
  Future<DiscoverNewStoresModel> discoverNewStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
  });
  Future<BestSellersStoresModel> bestSellersStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
  });
  Future<NewArrivalsModel> newArrivals({
    required int? pageNumber,
    required List<String>? productCategories,
    required List<String>? storeCategories,
  });
  Future<HotDealsModel> hotDeals({
    required int? pageNumber,
    required List<String>? productCategories,
    required List<String>? storeCategories,
  });
  Future<List<BestSellingProductsModel>> bestSellingProducts();
  Future<TopCategoriesModel> topCategories();
  Future<List<RecentlyViewedModel>> recentlyViewed();

}

class HomeRemoteDataSourceImpl
    implements HomeBaseRemoteDataSource {
  final DioHelper dioHelper;

  HomeRemoteDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<AppInfoModel> appInfo() async {
    final Response f = await dioHelper.get(
        url: versionURL,
        token: token
    );
    return AppInfoModel.fromJson(f.data);
  }

  @override
  Future<MainSearchProductModel> mainSearchProduct({
    required String searchText,
}) async {
    final Response f = await dioHelper.get(
        url: mainSearchURL,
        token: token,
        query: {
          "lang": isRTL==true ? 'ar' : 'en',
          "term": searchText,
          "type": 'product',
          "suggestion": 10,
        }
    );
    return MainSearchProductModel.fromJson(f.data);
  }

  @override
  Future<MainSearchShopModel> mainSearchShop({
    required String searchText,
}) async {
    final Response f = await dioHelper.get(
        url: mainSearchURL,
        token: token,
        query: {
          "lang": isRTL==true ? 'ar' : 'en',
          "term": searchText,
          "type": 'store',
          "suggestion": 10,
        }
    );
    return MainSearchShopModel.fromJson(f.data);
  }

  @override
  Future<ProductDetailsModel> productDetails(
      {
        required int? productID,
      }) async {

    final Response f = await dioHelper.get(
      url: productDetailsURL,
      token: token,
      query: {
        "lang": isRTL==true ? 'ar' : 'en',
        "id": productID,
      },
    );
    return ProductDetailsModel.fromJson(f.data);
  }

  @override
  Future<ProductDataModel> productData(
      {
        required int? productID,
      }) async {

    final Response f = await dioHelper.get(
      url: productDataURL,
      token: token,
      query: {
        "lang": isRTL==true ? 'ar' : 'en',
        "product_id": productID,
      },
    );
    return ProductDataModel.fromJson(f.data);
  }


  @override
  Future<AddFavouriteModel> addFavourite(
      {
        required int? itemID,
        required String? itemType,
      }) async {

    final Response f = await dioHelper.post(
      url: favouriteURL,
      token: token,
      data: {
        "lang": isRTL==true ? 'ar' : 'en',
        "id": itemID,
        "type": itemType,
      },
    );
    return AddFavouriteModel.fromJson(f.data);
  }


  @override
  Future<AddToCartModel> addToCart(
      {
        required int? featureID,
        required String? featureImage,
        required int? qty,
        required String? featureSlug,
      }) async {

    final Response f = await dioHelper.post(
      url: addToCartURL,
      token: token,
      data: {
        "lang": isRTL==true ? 'ar' : 'en',
        "feature": featureID,
        "qty": qty,
        "image": featureImage,
        "slug": featureSlug,
      },
    );
    return AddToCartModel.fromJson(f.data);
  }

  @override
  Future<ShopDataModel> shopData(
      {
        required int? shopID,
        required List? category,
        required List? subCategory,
        required String? from,
        required String? to,
      }) async {

    final Response f = await dioHelper.get(
      url: shopDataURL,
      token: token,
      query: {
        "lang": isRTL==true ? 'ar' : 'en',
        "id": shopID,
        "category[]": category,
        "subcategory[]": subCategory,
        "from": from,
        "to": to,
      },
    );
    return ShopDataModel.fromJson(f.data);
  }

  @override
  Future<StoreOffersModel> storeOffers(
      {
        required int? storeID,
      }) async {

    final Response f = await dioHelper.get(
      url: storeOffersURL,
      token: token,
      query: {
        "lang": isRTL==true ? 'ar' : 'en',
        "id": storeID,
      },
    );
    return StoreOffersModel.fromJson(f.data);
  }

  @override
  Future<StoreOfferDetailsModel> storeOfferDetails(
      {
        required int? offerID,
      }) async {

    final Response f = await dioHelper.get(
      url: storeOfferDetailsURL,
      token: token,
      query: {
        "lang": isRTL==true ? 'ar' : 'en',
        "id": offerID,
      },
    );
    return StoreOfferDetailsModel.fromJson(f.data);
  }

  @override
  Future<AddOfferToCartModel> addOfferToCart(
      {
        required List? offerProducts,
        required int? qty,
        required String? offerSlug,
      }) async {

    final Response f = await dioHelper.post(
      url: addOfferToCartURL,
      token: token,
      data: {
        "lang": isRTL==true ? 'ar' : 'en',
        "offer_products": offerProducts,
        "qty": qty,
        "offer_slug": offerSlug,
      },
    );
    return AddOfferToCartModel.fromJson(f.data);
  }

  @override
  Future<DeleteAccountModel> deleteAccount({
    required String password,
  }) async {
    final Response f = await dioHelper.post(
        url: deleteAccountURL,
        token: token,
        data: {
          "lang": isRTL==true ? 'ar' : 'en',
          "password": password,
        }
    );
    return DeleteAccountModel.fromJson(f.data);
  }


  @override
  Future<ResetPasswordSModel> resetPasswordS({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final Response f = await dioHelper.post(
        url: resetPasswordURL,
        token: token,
        data: {
          "lang": isRTL==true ? 'ar' : 'en',
          "old_password": oldPassword,
          "password": newPassword,
          "password_confirmation": confirmNewPassword,
        }
    );
    return ResetPasswordSModel.fromJson(f.data);
  }


  @override
  Future<AboutExponileModel> aboutExponile() async {
    final Response f = await dioHelper.get(
        url: aboutExponileURL,
        token: token,
        query: {
          "lang": isRTL==true ? 'ar' : 'en',
        }
    );
    return AboutExponileModel.fromJson(f.data);
  }

  @override
  Future<SubmitComplainModel> submitComplain({
    required String name,
    required String email,
    required String phone,
    required String complain,
  }) async {
    final Response f = await dioHelper.post(
        url: submitComplainURL,
        token: token,
        data: {
          "lang": isRTL==true ? 'ar' : 'en',
          "name": name,
          "email": email,
          "phone": phone,
          "message": complain,
        }
    );
    return SubmitComplainModel.fromJson(f.data);
  }


  @override
  Future<FavouriteStoresModel> favouriteStores(
      {
        required String? itemType,
      }) async {

    final Response f = await dioHelper.post(
      url: favouritesURL,
      token: token,
      query: {
        "lang": isRTL==true ? 'ar' : 'en',
        "type": itemType,
      },
    );
    return FavouriteStoresModel.fromJson(f.data);
  }


  @override
  Future<FavouriteProductsModel> favouriteProducts(
      {
        required String? itemType,
      }) async {

    final Response f = await dioHelper.post(
      url: favouritesURL,
      token: token,
      query: {
        "lang": isRTL==true ? 'ar' : 'en',
        "type": itemType,
      },
    );
    return FavouriteProductsModel.fromJson(f.data);
  }

  @override
  Future<AccountDataModel> accountData() async {

    final Response f = await dioHelper.get(
      url: accountDataURL,
      token: token,
      query: {
        "lang": isRTL==true ? 'ar' : 'en',
      },
    );
    return AccountDataModel.fromJson(f.data);
  }


  @override
  Future<DeleteAddressModel> deleteAddress({
    required int? addressID,
}) async {

    final Response f = await dioHelper.post(
      url: deleteAddressURL,
      token: token,
      data: {
        "lang": isRTL==true ? 'ar' : 'en',
        "id": addressID,
      },
    );
    return DeleteAddressModel.fromJson(f.data);
  }


  @override
  Future<CitiesModel> cities() async {
    final Response f = await dioHelper.get(
      url: citiesURL,
      query: {
        'lang': isRTL == true ? 'ar' : 'en',
      },
    );
    return CitiesModel.fromJson(f.data);
  }


  @override
  Future<AreasModel> areas({
    required int cityID,
  }) async {
    final Response f = await dioHelper.get(
        url: areasURL,
        query: {
          'lang': isRTL == true ? 'ar' : 'en',
          'city': cityID,
        }
    );
    return AreasModel.fromJson(f.data);
  }

  @override
  Future<LocationModel> location(
      {
        required String? address,
      }) async {

    final Response f = await dioHelper.get(
      url: locationURL,
      token: token,
      query: {
        "lang": isRTL==true ? 'ar' : 'en',
        "address": address,
      },
    );
    return LocationModel.fromJson(f.data);
  }


  @override
  Future<GetLocationModel> getLocation(
      {
        required double? lat,
        required double? long,
      }) async {
    final Response f = await dioHelper.get(
      url: getLocationURL,
      token: token,
      query: {
        "lang": isRTL==true ? 'ar' : 'en',
        "lat": lat,
        "lng": long,
      },
    );
    return GetLocationModel.fromJson(f.data);
  }


  @override
  Future<AddLocationModel> addLocation(
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
    final Response f = await dioHelper.post(
      url: addLocationURL,
      token: token,
      data: {
        "lang": isRTL==true ? 'ar' : 'en',
        "area": area,
        "governorate": governorate,
        "lat": late,
        "long": long,
        "street_name": streetName,
        "building_name": buildingName,
        "landmark": landmark,
        "floor_no": floorNo,
        "apt_no": aptNo,
        "type": type,
        "mobile": null,
      },
    );
    return AddLocationModel.fromJson(f.data);
  }

  @override
  Future<LandingModel> landing() async {
    final Response f = await dioHelper.get(
      url: landingURL,
      query: {
        'lang': isRTL == true ? 'ar' : 'en',
      },
    );
    return LandingModel.fromJson(f.data);
  }

  @override
  Future<CategoriesModel> categories() async {
    final Response f = await dioHelper.get(
      url: categoriesURL,
      query: {
        'lang': isRTL == true ? 'ar' : 'en',
      },
    );
    return CategoriesModel.fromJson(f.data);
  }


  @override
  Future<MostOffersModel> mostOffers() async {
    final Response f = await dioHelper.get(
      url: mostOffersUrl,
      query: {
        'lang': isRTL == true ? 'ar' : 'en',
        'limit': 4,
      },
    );
    return MostOffersModel.fromJson(f.data);
  }


  @override
  Future<HomeFavouriteStoresModel> homeFavouriteStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
}) async {
    Map<String,dynamic> query= {
      'lang': isRTL == true ? 'ar' : 'en',
      'page': pageNumber,
    };
    if(storeCategory != null){
      query['store_category[0]'] = storeCategory;
    }

    if(storeCategory != null){
      query['offer[0]'] = offerType;
    }

    if(sortedBy != null){
      query['sort_by[0]'] = sortedBy;
    }

    final Response f = await dioHelper.get(
      url: homeFavouriteStoresUrl,
      query: query,
    );
    return HomeFavouriteStoresModel.fromJson(f.data);
  }


  @override
  Future<DiscoverNewStoresModel> discoverNewStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
  }) async {
    Map<String,dynamic> query= {
      'lang': isRTL == true ? 'ar' : 'en',
      'page': pageNumber,
    };
    if(storeCategory != null){
      query['store_category[0]'] = storeCategory;
    }

    if(storeCategory != null){
      query['offer[0]'] = offerType;
    }

    if(sortedBy != null){
      query['sort_by[0]'] = sortedBy;
    }

    final Response f = await dioHelper.get(
      url: discoverNewStoresUrl,
      query: query,
    );
    return DiscoverNewStoresModel.fromJson(f.data);
  }

  @override
  Future<BestSellersStoresModel> bestSellersStores({
    required int? pageNumber,
    required String? storeCategory,
    required String? offerType,
    required String? sortedBy,
  }) async {
    Map<String,dynamic> query= {
      'lang': isRTL == true ? 'ar' : 'en',
      'page': pageNumber,
    };
    if(storeCategory != null){
      query['store_category[0]'] = storeCategory;
    }

    if(storeCategory != null){
      query['offer[0]'] = offerType;
    }

    if(sortedBy != null){
      query['sort_by[0]'] = sortedBy;
    }

    final Response f = await dioHelper.get(
      url: bestSellerStoresUrl,
      query: query,
    );
    return BestSellersStoresModel.fromJson(f.data);
  }


  @override
  Future<NewArrivalsModel> newArrivals({
    required int? pageNumber,
    required List<String>? productCategories,
    required List<String>? storeCategories,
  }) async {
    Map<String,dynamic> query= {
      'lang': isRTL == true ? 'ar' : 'en',
      'page': pageNumber,
    };
    if(productCategories != null){
      query['category[0]'] = productCategories;
    }

    if(storeCategories != null){
      query['store_category[0]'] = storeCategories;
    }

    final Response f = await dioHelper.get(
      url: newArrivalsUrl,
      query: query,
    );
    return NewArrivalsModel.fromJson(f.data);
  }



  @override
  Future<HotDealsModel> hotDeals({
    required int? pageNumber,
    required List<String>? productCategories,
    required List<String>? storeCategories,
  }) async {
    Map<String,dynamic> query= {
      'lang': isRTL == true ? 'ar' : 'en',
      'page': pageNumber,
    };
    if(productCategories != null){
      query['category[0]'] = productCategories;
    }

    if(storeCategories != null){
      query['store_category[0]'] = storeCategories;
    }

    final Response f = await dioHelper.get(
      url: hotDealsUrl,
      query: query,
    );
    return HotDealsModel.fromJson(f.data);
  }


  @override
  Future<List<BestSellingProductsModel>> bestSellingProducts() async {
    final Response f = await dioHelper.get(
      url: '$bestSellingProductsUrl/${isRTL == true ? 'ar' : 'en'}',
    );
    return List<BestSellingProductsModel>.from(
        (f.data as List).map((e) => BestSellingProductsModel.fromJson(e))
    );
  }


  @override
  Future<TopCategoriesModel> topCategories() async {
    final Response f = await dioHelper.get(
      url: topCategoriesUrl,
      query: {
        'lang': isRTL == true ? 'ar' : 'en',
      }
    );
    return TopCategoriesModel.fromJson(f.data);

  }


  @override
  Future<List<RecentlyViewedModel>> recentlyViewed() async {
    final Response f = await dioHelper.get(
        url: recentlyViewedURL,
        query: {
          'lang': isRTL == true ? 'ar' : 'en',
        }    );
    return List<RecentlyViewedModel>.from(
        (f.data as List).map((e) => RecentlyViewedModel.fromJson(e))
    );
  }


}

