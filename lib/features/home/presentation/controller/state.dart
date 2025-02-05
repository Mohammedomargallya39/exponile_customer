import 'package:equatable/equatable.dart';
import 'package:exponile_customer/features/home/domain/entities/top_categories_entity.dart';
import '../../domain/entities/about_exponile_entity.dart';
import '../../domain/entities/account_data_entity.dart';
import '../../domain/entities/add_address_entity.dart';
import '../../domain/entities/add_favourite_entity.dart';
import '../../domain/entities/add_offer_to_cart_entity.dart';
import '../../domain/entities/add_rate_entity.dart';
import '../../domain/entities/add_to_cart_entity.dart';
import '../../domain/entities/areas_entity.dart';
import '../../domain/entities/best_sellers_store_entity.dart';
import '../../domain/entities/best_selling_products_entity.dart';
import '../../domain/entities/cancel_order_entity.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/categories_entity.dart';
import '../../domain/entities/check_out_view_entity.dart';
import '../../domain/entities/checkout_entity.dart';
import '../../domain/entities/cities_entity.dart';
import '../../domain/entities/delete_account_entity.dart';
import '../../domain/entities/delete_address_entity.dart';
import '../../domain/entities/delete_cart_item_entity.dart';
import '../../domain/entities/discover_new_store_entity.dart';
import '../../domain/entities/favourite_products_entity.dart';
import '../../domain/entities/favourite_stores_entity.dart';
import '../../domain/entities/fawry_payment_entity.dart';
import '../../domain/entities/get_location_entity.dart';
import '../../domain/entities/get_payment_method_entity.dart';
import '../../domain/entities/home_favourite_store_entity.dart';
import '../../domain/entities/hot_deals_entity.dart';
import '../../domain/entities/landing_entity.dart';
import '../../domain/entities/main_search_product_entity.dart';
import '../../domain/entities/main_search_shop_entity.dart';
import '../../domain/entities/most_deals_entity.dart';
import '../../domain/entities/new_arrivals_entity.dart';
import '../../domain/entities/offers_entity.dart';
import '../../domain/entities/order_details_entity.dart';
import '../../domain/entities/order_reciept_entity.dart';
import '../../domain/entities/orders_entity.dart';
import '../../domain/entities/payment_order_data_entity.dart';
import '../../domain/entities/product_category_details_entity.dart';
import '../../domain/entities/product_data_entity.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/promo_code_entity.dart';
import '../../domain/entities/recently_viewed_entity.dart';
import '../../domain/entities/reciept_entity.dart';
import '../../domain/entities/reset_password_entity.dart';
import '../../domain/entities/shipping_address_entity.dart';
import '../../domain/entities/shop_data_entity.dart';
import '../../domain/entities/shop_location_entity.dart';
import '../../domain/entities/store_category_details_entity.dart';
import '../../domain/entities/store_offer_details_entity.dart';
import '../../domain/entities/store_offers_entity.dart';
import '../../domain/entities/submit_complain_entity.dart';
import '../../domain/entities/update_cart_offer_entity.dart';
import '../../domain/entities/update_cart_product_entity.dart';

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


class LocationLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LocationSuccessState extends HomeState {
  final LocationEntity locationEntity;


  LocationSuccessState({required this.locationEntity});

  @override
  List<Object?> get props => [locationEntity];
}

class LocationErrorState extends HomeState {
  final String failure;

  LocationErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class CitiesLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class CitiesSuccessState extends HomeState {
  final CitiesEntity citiesEntity;


  CitiesSuccessState({required this.citiesEntity});

  @override
  List<Object?> get props => [citiesEntity];
}

class CitiesErrorState extends HomeState {
  final String failure;

  CitiesErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class AreasLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class AreasSuccessState extends HomeState {
  final AreasEntity areasEntity;


  AreasSuccessState({required this.areasEntity});

  @override
  List<Object?> get props => [areasEntity];
}

class AreasErrorState extends HomeState {
  final String failure;

  AreasErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class GetLocationLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class GetLocationSuccessState extends HomeState {
  final GetLocationEntity getLocationEntity;


  GetLocationSuccessState({required this.getLocationEntity});

  @override
  List<Object?> get props => [getLocationEntity];
}

class GetLocationErrorState extends HomeState {
  final String failure;

  GetLocationErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class AddLocationLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class AddLocationSuccessState extends HomeState {
  final AddLocationEntity addLocationEntity;


  AddLocationSuccessState({required this.addLocationEntity});

  @override
  List<Object?> get props => [addLocationEntity];
}

class AddLocationErrorState extends HomeState {
  final String failure;

  AddLocationErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class LandingLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LandingSuccessState extends HomeState {
  final LandingEntity landingEntity;


  LandingSuccessState({required this.landingEntity});

  @override
  List<Object?> get props => [landingEntity];
}

class LandingErrorState extends HomeState {
  final String failure;

  LandingErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class CategoriesLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class CategoriesSuccessState extends HomeState {
  final CategoriesEntity categoriesEntity;


  CategoriesSuccessState({required this.categoriesEntity});

  @override
  List<Object?> get props => [categoriesEntity];
}

class CategoriesErrorState extends HomeState {
  final String failure;

  CategoriesErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class MostOffersLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class MostOffersSuccessState extends HomeState {
  final MostOffersEntity mostOffersEntity;


  MostOffersSuccessState({required this.mostOffersEntity});

  @override
  List<Object?> get props => [mostOffersEntity];
}

class MostOffersErrorState extends HomeState {
  final String failure;

  MostOffersErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class HomeFavouriteStoresLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeFavouriteStoresSuccessState extends HomeState {
  final HomeFavouriteStoresEntity homeFavouriteStoresEntity;


  HomeFavouriteStoresSuccessState({required this.homeFavouriteStoresEntity});

  @override
  List<Object?> get props => [homeFavouriteStoresEntity];
}

class HomeFavouriteStoresErrorState extends HomeState {
  final String failure;

  HomeFavouriteStoresErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class DiscoverNewStoresLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class DiscoverNewStoresSuccessState extends HomeState {
  final DiscoverNewStoresEntity discoverNewStoresEntity;


  DiscoverNewStoresSuccessState({required this.discoverNewStoresEntity});

  @override
  List<Object?> get props => [discoverNewStoresEntity];
}

class DiscoverNewStoresErrorState extends HomeState {
  final String failure;

  DiscoverNewStoresErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class BestSellersStoresLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class BestSellersStoresSuccessState extends HomeState {
  final BestSellersStoresEntity bestSellersStoresEntity;


  BestSellersStoresSuccessState({required this.bestSellersStoresEntity});

  @override
  List<Object?> get props => [bestSellersStoresEntity];
}

class BestSellersStoresErrorState extends HomeState {
  final String failure;

  BestSellersStoresErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class NewArrivalsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class NewArrivalsSuccessState extends HomeState {
  final NewArrivalsEntity newArrivalsEntity;


  NewArrivalsSuccessState({required this.newArrivalsEntity});

  @override
  List<Object?> get props => [newArrivalsEntity];
}

class NewArrivalsErrorState extends HomeState {
  final String failure;

  NewArrivalsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class HotDealsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HotDealsSuccessState extends HomeState {
  final HotDealsEntity hotDealsEntity;


  HotDealsSuccessState({required this.hotDealsEntity});

  @override
  List<Object?> get props => [hotDealsEntity];
}

class HotDealsErrorState extends HomeState {
  final String failure;

  HotDealsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class BestSellingProductsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class BestSellingProductsSuccessState extends HomeState {
  final List<BestSellingProductsEntity> bestSellingProductsEntity;


  BestSellingProductsSuccessState({required this.bestSellingProductsEntity});

  @override
  List<Object?> get props => [bestSellingProductsEntity];
}

class BestSellingProductsErrorState extends HomeState {
  final String failure;

  BestSellingProductsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class TopCategoriesLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class TopCategoriesSuccessState extends HomeState {
  final TopCategoriesEntity topCategoriesEntity;


  TopCategoriesSuccessState({required this.topCategoriesEntity});

  @override
  List<Object?> get props => [topCategoriesEntity];
}

class TopCategoriesErrorState extends HomeState {
  final String failure;

  TopCategoriesErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class RecentlyViewedLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class RecentlyViewedSuccessState extends HomeState {
  final List<RecentlyViewedEntity> recentlyViewedEntity;


  RecentlyViewedSuccessState({required this.recentlyViewedEntity});

  @override
  List<Object?> get props => [recentlyViewedEntity];
}

class RecentlyViewedErrorState extends HomeState {
  final String failure;

  RecentlyViewedErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class OffersLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class OffersSuccessState extends HomeState {
  final OffersEntity offersEntity;


  OffersSuccessState({required this.offersEntity});

  @override
  List<Object?> get props => [offersEntity];
}

class OffersErrorState extends HomeState {
  final String failure;

  OffersErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class OrdersLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class OrdersSuccessState extends HomeState {
  final OrdersEntity ordersEntity;


  OrdersSuccessState({required this.ordersEntity});

  @override
  List<Object?> get props => [ordersEntity];
}

class OrdersErrorState extends HomeState {
  final String failure;

  OrdersErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}




class CancelOrderLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class CancelOrderSuccessState extends HomeState {
  final CancelOrderEntity cancelOrderEntity;


  CancelOrderSuccessState({required this.cancelOrderEntity});

  @override
  List<Object?> get props => [cancelOrderEntity];
}

class CancelOrderErrorState extends HomeState {
  final String failure;

  CancelOrderErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class PaymentOrderDataLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class PaymentOrderDataSuccessState extends HomeState {
  final PaymentOrderDataEntity paymentOrderDataEntity;


  PaymentOrderDataSuccessState({required this.paymentOrderDataEntity});

  @override
  List<Object?> get props => [paymentOrderDataEntity];
}

class PaymentOrderDataErrorState extends HomeState {
  final String failure;

  PaymentOrderDataErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class OrderDetailsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class OrderDetailsSuccessState extends HomeState {
  final OrderDetailsEntity orderDetailsEntity;


  OrderDetailsSuccessState({required this.orderDetailsEntity});

  @override
  List<Object?> get props => [orderDetailsEntity];
}

class OrderDetailsErrorState extends HomeState {
  final String failure;

  OrderDetailsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class AddRateLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class AddRateSuccessState extends HomeState {
  final AddRateEntity addRateEntity;


  AddRateSuccessState({required this.addRateEntity});

  @override
  List<Object?> get props => [addRateEntity];
}

class AddRateErrorState extends HomeState {
  final String failure;

  AddRateErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}




class StoreCategoryDetailsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class StoreCategoryDetailsSuccessState extends HomeState {
  final StoreCategoryDetailsEntity storeCategoryDetailsEntity;


  StoreCategoryDetailsSuccessState({required this.storeCategoryDetailsEntity});

  @override
  List<Object?> get props => [storeCategoryDetailsEntity];
}

class StoreCategoryDetailsErrorState extends HomeState {
  final String failure;

  StoreCategoryDetailsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}




class ProductCategoryDetailsLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class ProductCategoryDetailsSuccessState extends HomeState {
  final ProductCategoryDetailsEntity productCategoryDetailsEntity;


  ProductCategoryDetailsSuccessState({required this.productCategoryDetailsEntity});

  @override
  List<Object?> get props => [productCategoryDetailsEntity];
}

class ProductCategoryDetailsErrorState extends HomeState {
  final String failure;

  ProductCategoryDetailsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class CartLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class CartSuccessState extends HomeState {
  final CartEntity cartEntity;


  CartSuccessState({required this.cartEntity});

  @override
  List<Object?> get props => [cartEntity];
}

class CartErrorState extends HomeState {
  final String failure;

  CartErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class UpdateCartProductLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class UpdateCartProductSuccessState extends HomeState {
  final UpdateCartProductEntity updateCartProductEntity;


  UpdateCartProductSuccessState({required this.updateCartProductEntity});

  @override
  List<Object?> get props => [updateCartProductEntity];
}

class UpdateCartProductErrorState extends HomeState {
  final String failure;

  UpdateCartProductErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}


class DeleteCartItemLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class DeleteCartItemSuccessState extends HomeState {
  final DeleteCartItemEntity deleteCartItemEntity;


  DeleteCartItemSuccessState({required this.deleteCartItemEntity});

  @override
  List<Object?> get props => [deleteCartItemEntity];
}

class DeleteCartItemErrorState extends HomeState {
  final String failure;

  DeleteCartItemErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}




class UpdateCartOfferLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class UpdateCartOfferSuccessState extends HomeState {
  final UpdateCartOfferEntity updateCartOfferEntity;


  UpdateCartOfferSuccessState({required this.updateCartOfferEntity});

  @override
  List<Object?> get props => [updateCartOfferEntity];
}

class UpdateCartOfferErrorState extends HomeState {
  final String failure;

  UpdateCartOfferErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class PromoCodeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class PromoCodeSuccessState extends HomeState {
  final PromoCodeEntity promoCodeEntity;


  PromoCodeSuccessState({required this.promoCodeEntity});

  @override
  List<Object?> get props => [promoCodeEntity];
}

class PromoCodeErrorState extends HomeState {
  final String failure;

  PromoCodeErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}




class CheckOutViewLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class CheckOutViewSuccessState extends HomeState {
  final CheckOutViewEntity checkOutViewEntity;


  CheckOutViewSuccessState({required this.checkOutViewEntity});

  @override
  List<Object?> get props => [checkOutViewEntity];
}

class CheckOutViewErrorState extends HomeState {
  final String failure;

  CheckOutViewErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}




class GetShippingAddressFeesLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class GetShippingAddressFeesSuccessState extends HomeState {
  final GetShippingAddressFeesEntity getShippingAddressFeesEntity;


  GetShippingAddressFeesSuccessState({required this.getShippingAddressFeesEntity});

  @override
  List<Object?> get props => [getShippingAddressFeesEntity];
}

class GetShippingAddressFeesErrorState extends HomeState {
  final String failure;

  GetShippingAddressFeesErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class GetPaymentMethodLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class GetPaymentMethodSuccessState extends HomeState {
  final GetPaymentMethodEntity getPaymentMethodEntity;


  GetPaymentMethodSuccessState({required this.getPaymentMethodEntity});

  @override
  List<Object?> get props => [getPaymentMethodEntity];
}

class GetPaymentMethodErrorState extends HomeState {
  final String failure;

  GetPaymentMethodErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}




class CheckoutLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class CheckoutSuccessState extends HomeState {
  final CheckoutEntity checkoutEntity;


  CheckoutSuccessState({required this.checkoutEntity});

  @override
  List<Object?> get props => [checkoutEntity];
}

class CheckoutErrorState extends HomeState {
  final String failure;

  CheckoutErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}




class OrderReceiptLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class OrderReceiptSuccessState extends HomeState {
  final OrderReceiptEntity orderReceiptEntity;


  OrderReceiptSuccessState({required this.orderReceiptEntity});

  @override
  List<Object?> get props => [orderReceiptEntity];
}

class OrderReceiptErrorState extends HomeState {
  final String failure;

  OrderReceiptErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class FawryPaymentLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class FawryPaymentSuccessState extends HomeState {
  final FawryPaymentEntity fawryPaymentEntity;


  FawryPaymentSuccessState({required this.fawryPaymentEntity});

  @override
  List<Object?> get props => [fawryPaymentEntity];
}

class FawryPaymentErrorState extends HomeState {
  final String failure;

  FawryPaymentErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}



class ReceiptLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class ReceiptSuccessState extends HomeState {
  final ReceiptEntity receiptEntity;


  ReceiptSuccessState({required this.receiptEntity});

  @override
  List<Object?> get props => [receiptEntity];
}

class ReceiptErrorState extends HomeState {
  final String failure;

  ReceiptErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}












class SocketConnectedState extends HomeState {
  @override
  List<Object?> get props => [];
}


class SocketErrorState extends HomeState {
  @override
  List<Object?> get props => [];
}


class SocketDisconnectedState extends HomeState {
  @override
  List<Object?> get props => [];
}


class SocketAddState extends HomeState {
  @override
  List<Object?> get props => [];
}


class SocketUpdateState extends HomeState {
  @override
  List<Object?> get props => [];
}


class SocketDeleteState extends HomeState {
  @override
  List<Object?> get props => [];
}


class SocketChooseAddressState extends HomeState {
  @override
  List<Object?> get props => [];
}


class SocketChoosePaymentState extends HomeState {
  @override
  List<Object?> get props => [];
}
