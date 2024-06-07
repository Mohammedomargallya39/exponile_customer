import 'package:dio/dio.dart';
import 'package:exponile_customer/features/home/data/models/add_favourite_model.dart';
import '../../../../../core/network/remote/api_endpoints.dart';
import '../../../../../core/network/remote/dio_helper.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../models/about_exponile_model.dart';
import '../models/add_offer_to_cart_model.dart';
import '../models/add_to_cart_model.dart';
import '../models/app_info_model.dart';
import '../models/delete_account_model.dart';
import '../models/main_search_product_model.dart';
import '../models/main_search_shop_model.dart';
import '../models/product_data_model.dart';
import '../models/product_details_model.dart';
import '../models/reset_password_model.dart';
import '../models/shop_data_model.dart';
import '../models/store_offer_details_model.dart';
import '../models/store_offers_model.dart';
import '../models/submit_complain_model.dart';

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


}

