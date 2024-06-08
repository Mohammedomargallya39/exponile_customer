import 'package:equatable/equatable.dart';

import '../../domain/entities/about_exponile_entity.dart';
import '../../domain/entities/account_data_entity.dart';
import '../../domain/entities/add_favourite_entity.dart';
import '../../domain/entities/add_offer_to_cart_entity.dart';
import '../../domain/entities/add_to_cart_entity.dart';
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

abstract class HomeState extends Equatable{}

class Empty extends HomeState {
  @override
  List<Object?> get props => [];
}

class Loading extends HomeState {
  @override
  List<Object?> get props => [];
}

class Loaded extends HomeState {
  @override
  List<Object?> get props => [];
}

class InitState extends HomeState{
  @override
  List<Object?> get props => [];
}


class ChangeState extends HomeState{
  @override
  List<Object?> get props => [];
}

class FilterState extends HomeState{
  @override
  List<Object?> get props => [];
}


class HomeChangeNavBottomScreensState extends HomeState{
  @override
  List<Object?> get props => [];
}



class MainSearchProductsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class MainSearchProductsSuccessState extends HomeState {
  final MainSearchProductEntity mainSearchProductEntity;


  MainSearchProductsSuccessState({required this.mainSearchProductEntity});

  @override
  List<Object?> get props => [mainSearchProductEntity];
}

class MainSearchProductsErrorState extends HomeState {
  final String failure;

  MainSearchProductsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class MainSearchShopsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class MainSearchShopsSuccessState extends HomeState {
  final MainSearchShopEntity mainSearchShopEntity;


  MainSearchShopsSuccessState({required this.mainSearchShopEntity});

  @override
  List<Object?> get props => [mainSearchShopEntity];
}

class MainSearchShopsErrorState extends HomeState {
  final String failure;

  MainSearchShopsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class ProductDetailsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class ProductDetailsSuccessState extends HomeState {
  final ProductDetailsEntity productDetailsEntity;


  ProductDetailsSuccessState({required this.productDetailsEntity});

  @override
  List<Object?> get props => [productDetailsEntity];
}

class ProductDetailsErrorState extends HomeState {
  final String failure;

  ProductDetailsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class ProductDataLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class ProductDataSuccessState extends HomeState {
  final ProductDataEntity productDataEntity;


  ProductDataSuccessState({required this.productDataEntity});

  @override
  List<Object?> get props => [productDataEntity];
}

class ProductDataErrorState extends HomeState {
  final String failure;

  ProductDataErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class FavouriteLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class FavouriteSuccessState extends HomeState {
  final AddFavouriteEntity addFavouriteEntity;


  FavouriteSuccessState({required this.addFavouriteEntity});

  @override
  List<Object?> get props => [addFavouriteEntity];
}

class FavouriteErrorState extends HomeState {
  final String failure;

  FavouriteErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class AddToCartLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class AddToCartSuccessState extends HomeState {
  final AddToCartEntity addToCartEntity;


  AddToCartSuccessState({required this.addToCartEntity});

  @override
  List<Object?> get props => [addToCartEntity];
}

class AddToCartErrorState extends HomeState {
  final String failure;

  AddToCartErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class ShopDataLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class ShopDataSuccessState extends HomeState {
  final ShopDataEntity shopDataEntity;


  ShopDataSuccessState({required this.shopDataEntity});

  @override
  List<Object?> get props => [shopDataEntity];
}

class ShopDataErrorState extends HomeState {
  final String failure;

  ShopDataErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class StoreOffersLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class StoreOffersSuccessState extends HomeState {
  final StoreOffersEntity storeOffersEntity;


  StoreOffersSuccessState({required this.storeOffersEntity});

  @override
  List<Object?> get props => [storeOffersEntity];
}

class StoreOffersErrorState extends HomeState {
  final String failure;

  StoreOffersErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class StoreOfferDetailsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class StoreOfferDetailsSuccessState extends HomeState {
  final StoreOfferDetailsEntity storeOfferDetailsEntity;


  StoreOfferDetailsSuccessState({required this.storeOfferDetailsEntity});

  @override
  List<Object?> get props => [storeOfferDetailsEntity];
}

class StoreOfferDetailsErrorState extends HomeState {
  final String failure;

  StoreOfferDetailsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class AddOfferToCartLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class AddOfferToCartSuccessState extends HomeState {
  final AddOfferToCartEntity addOfferToCartEntity;


  AddOfferToCartSuccessState({required this.addOfferToCartEntity});

  @override
  List<Object?> get props => [addOfferToCartEntity];
}

class AddOfferToCartErrorState extends HomeState {
  final String failure;

  AddOfferToCartErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

class DeleteAccountLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class DeleteAccountSuccessState extends HomeState {
  final DeleteAccountEntity deleteAccountEntity;


  DeleteAccountSuccessState({required this.deleteAccountEntity});

  @override
  List<Object?> get props => [deleteAccountEntity];
}

class DeleteAccountErrorState extends HomeState {
  final String failure;

  DeleteAccountErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class ResetPasswordLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class ResetPasswordSuccessState extends HomeState {
  final ResetPasswordSEntity resetPasswordEntity;


  ResetPasswordSuccessState({required this.resetPasswordEntity});

  @override
  List<Object?> get props => [resetPasswordEntity];
}

class ResetPasswordErrorState extends HomeState {
  final String failure;

  ResetPasswordErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class AboutExponileLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class AboutExponileSuccessState extends HomeState {
  final AboutExponileEntity aboutExponileEntity;


  AboutExponileSuccessState({required this.aboutExponileEntity});

  @override
  List<Object?> get props => [aboutExponileEntity];
}

class AboutExponileErrorState extends HomeState {
  final String failure;

  AboutExponileErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class SubmitComplainLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class SubmitComplainSuccessState extends HomeState {
  final SubmitComplainEntity submitComplainEntity;


  SubmitComplainSuccessState({required this.submitComplainEntity});

  @override
  List<Object?> get props => [submitComplainEntity];
}

class SubmitComplainErrorState extends HomeState {
  final String failure;

  SubmitComplainErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class FavouriteStoresLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class FavouriteStoresSuccessState extends HomeState {
  final FavouriteStoresEntity favouriteStoresEntity;


   FavouriteStoresSuccessState({required this.favouriteStoresEntity});

  @override
  List<Object?> get props => [favouriteStoresEntity];
}

class FavouriteStoresErrorState extends HomeState {
  final String failure;

  FavouriteStoresErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class FavouriteProductsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class FavouriteProductsSuccessState extends HomeState {
  final FavouriteProductsEntity favouriteProductsEntity;


  FavouriteProductsSuccessState({required this.favouriteProductsEntity});

  @override
  List<Object?> get props => [favouriteProductsEntity];
}

class FavouriteProductsErrorState extends HomeState {
  final String failure;

  FavouriteProductsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class AccountDataLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class AccountDataSuccessState extends HomeState {
  final AccountDataEntity accountDataEntity;


  AccountDataSuccessState({required this.accountDataEntity});

  @override
  List<Object?> get props => [accountDataEntity];
}

class AccountDataErrorState extends HomeState {
  final String failure;

  AccountDataErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class DeleteAddressLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class DeleteAddressSuccessState extends HomeState {
  final DeleteAddressEntity deleteAddressEntity;


  DeleteAddressSuccessState({required this.deleteAddressEntity});

  @override
  List<Object?> get props => [deleteAddressEntity];
}

class DeleteAddressErrorState extends HomeState {
  final String failure;

  DeleteAddressErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
