import 'package:equatable/equatable.dart';

import '../../domain/entities/add_favourite_entity.dart';
import '../../domain/entities/add_to_cart_entity.dart';
import '../../domain/entities/main_search_product_entity.dart';
import '../../domain/entities/main_search_shop_entity.dart';
import '../../domain/entities/product_data_entity.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/shop_data_entity.dart';

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