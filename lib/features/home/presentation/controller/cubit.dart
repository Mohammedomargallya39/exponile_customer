import 'package:exponile_customer/core/usecase/use_case.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/features/home/domain/entities/about_exponile_entity.dart';
import 'package:exponile_customer/features/home/domain/entities/best_selling_products_entity.dart';
import 'package:exponile_customer/features/home/domain/entities/categories_entity.dart';
import 'package:exponile_customer/features/home/domain/usecase/about_exponile_usecase.dart';
import 'package:exponile_customer/features/home/domain/usecase/best_sellers_stores_usecase.dart';
import 'package:exponile_customer/features/home/domain/usecase/home_favourite_stores_usecase.dart';
import 'package:exponile_customer/features/home/domain/usecase/most_offers_usecase.dart';
import 'package:exponile_customer/features/home/domain/usecase/new_arrivals_usecase.dart';
import 'package:exponile_customer/features/home/domain/usecase/offers_usecase.dart';
import 'package:exponile_customer/features/home/domain/usecase/recently_viewed_usecase.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/categories/categories.dart';
import 'package:exponile_customer/features/home/presentation/screens/offers_screen/all_offer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../domain/entities/account_data_entity.dart';
import '../../domain/entities/add_address_entity.dart';
import '../../domain/entities/areas_entity.dart';
import '../../domain/entities/best_sellers_store_entity.dart';
import '../../domain/entities/cities_entity.dart';
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
import '../../domain/entities/orders_entity.dart';
import '../../domain/entities/product_data_entity.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/recently_viewed_entity.dart';
import '../../domain/entities/shop_data_entity.dart';
import '../../domain/entities/shop_location_entity.dart';
import '../../domain/entities/store_offer_details_entity.dart';
import '../../domain/entities/store_offers_entity.dart';
import '../../domain/entities/top_categories_entity.dart';
import '../../domain/usecase/account_data_usecase.dart';
import '../../domain/usecase/add_favourite_usecase.dart';
import '../../domain/usecase/add_location_details_usecase.dart';
import '../../domain/usecase/add_offer_to_cart_usecase.dart';
import '../../domain/usecase/add_to_cart_usecase.dart';
import '../../domain/usecase/areas_usecase.dart';
import '../../domain/usecase/best_selling_products_usecase.dart';
import '../../domain/usecase/categories_usecase.dart';
import '../../domain/usecase/cities_usecase.dart';
import '../../domain/usecase/delete_account_usecase.dart';
import '../../domain/usecase/delete_address_usecase.dart';
import '../../domain/usecase/discover_new_stores_usecase.dart';
import '../../domain/usecase/favourite_products_usecase.dart';
import '../../domain/usecase/favourite_stores_usecase.dart';
import '../../domain/usecase/get_location_usecase.dart';
import '../../domain/usecase/hot_deals_usecase.dart';
import '../../domain/usecase/landing_usecase.dart';
import '../../domain/usecase/location_usecase.dart';
import '../../domain/usecase/main_search_product_usecase.dart';
import '../../domain/usecase/main_search_shop_usecase.dart';
import '../../domain/usecase/orders_usecase.dart';
import '../../domain/usecase/product_data_usecase.dart';
import '../../domain/usecase/product_details_usecase.dart';
import '../../domain/usecase/reset_password_usecase.dart';
import '../../domain/usecase/shop_data_usecase.dart';
import '../../domain/usecase/store_offer_details_usecase.dart';
import '../../domain/usecase/store_offers_usecase.dart';
import '../../domain/usecase/submit_complain_usecase.dart';
import '../../domain/usecase/top_categories_usecase.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/widgets/arrival_list.dart';
import '../screens/home/widgets/banars.dart';
import '../screens/home/widgets/best_sellers_list.dart';
import '../screens/home/widgets/best_selling_list.dart';
import '../screens/home/widgets/categories_slider.dart';
import '../screens/home/widgets/discover_list.dart';
import '../screens/home/widgets/favourite_list.dart';
import '../screens/home/widgets/hot_deals_list.dart';
import '../screens/home/widgets/offers_list.dart';
import '../screens/home/widgets/top_categories_list.dart';
import '../screens/home/widgets/recently_list.dart';
import '../screens/orders_screen/orders_screen.dart';
import '../screens/settings/setting_screen.dart';

class HomeCubit extends Cubit<HomeState> {
   final MainSearchProductUseCase _mainSearchProductUseCase;
   final MainSearchShopUseCase _mainSearchShopUseCase;
   final ProductDetailsUseCase _productDetailsUseCase;
   final ProductDataUseCase _productDataUseCase;
   final AddFavouriteUseCase _addFavouriteUseCase;
   final AddToCartUseCase _addToCartUseCase;
   final AddOfferToCartUseCase _addOfferToCartUseCase;
   final ShopDataUseCase _shopDataUseCase;
   final StoreOffersUseCase _storeOffersUseCase;
   final StoreOfferDetailsUseCase _storeOfferDetailsUseCase;
   final DeleteAccountUseCase _deleteAccountUseCase;
   final ResetPasswordSUseCase _resetPasswordSUseCase;
   final AboutExponileUseCase _aboutExponileUseCase;
   final SubmitComplainUseCase _submitComplainUseCase;
   final FavouriteStoresUseCase _favouriteStoresUseCase;
   final FavouriteProductsUseCase _favouriteProductsUseCase;
   final AccountDataUseCase _accountDataUseCase;
   final DeleteAddressUseCase _deleteAddressUseCase;
   final CitiesUseCase _citiesUseCase;
   final AreasUseCase _areasUseCase;
   final LocationUseCase _locationUseCase;
   final GetLocationUseCase _getLocationUseCase;
   final AddLocationUseCase _addLocationUseCase;
   final LandingUseCase _landingUseCase;
   final CategoriesUseCase _categoriesUseCase;
   final MostOffersUseCase _mostOffersUseCase;
   final HomeFavouriteStoresUseCase _homeFavouriteStoresUseCase;
   final DiscoverNewStoresUseCase _discoverNewStoresUseCase;
   final BestSellersStoresUseCase _bestSellersStoresUseCase;
   final NewArrivalsUseCase _newArrivalsUseCase;
   final HotDealsUseCase _hotDealsUseCase;
   final BestSellingProductsUseCase _bestSellingProductsUseCase;
   final TopCategoriesUseCase _topCategoriesUseCase;
   final RecentlyViewedUseCase _recentlyViewedUseCase;
   final OffersUseCase _offersUseCase;
   final OrdersUseCase _ordersUseCase;

  HomeCubit(
      {
    required MainSearchProductUseCase mainSearchProductUseCase,
    required MainSearchShopUseCase mainSearchShopUseCase,
    required ProductDetailsUseCase productDetailsUseCase,
    required ProductDataUseCase productDataUseCase,
    required AddFavouriteUseCase addFavouriteUseCase,
    required AddToCartUseCase addToCartUseCase,
    required AddOfferToCartUseCase addOfferToCartUseCase,
    required ShopDataUseCase shopDataUseCase,
    required StoreOffersUseCase storeOffersUseCase,
    required StoreOfferDetailsUseCase storeOfferDetailsUseCase,
    required DeleteAccountUseCase deleteAccountUseCase,
    required ResetPasswordSUseCase resetPasswordSUseCase,
    required AboutExponileUseCase aboutExponileUseCase,
    required SubmitComplainUseCase submitComplainUseCase,
    required FavouriteStoresUseCase favouriteStoresUseCase,
    required FavouriteProductsUseCase favouriteProductsUseCase,
    required AccountDataUseCase accountDataUseCase,
    required DeleteAddressUseCase deleteAddressUseCase,
    required CitiesUseCase citiesUseCase,
    required AreasUseCase areasUseCase,
    required LocationUseCase locationUseCase,
    required GetLocationUseCase getLocationUseCase,
    required AddLocationUseCase addLocationUseCase,
    required LandingUseCase landingUseCase,
    required CategoriesUseCase categoriesUseCase,
    required MostOffersUseCase mostOffersUseCase,
    required HomeFavouriteStoresUseCase homeFavouriteStoresUseCase,
    required DiscoverNewStoresUseCase discoverNewStoresUseCase,
    required BestSellersStoresUseCase bestSellersStoresUseCase,
    required NewArrivalsUseCase newArrivalsUseCase,
    required HotDealsUseCase hotDealsUseCase,
    required BestSellingProductsUseCase bestSellingProductsUseCase,
    required TopCategoriesUseCase topCategoriesUseCase,
    required RecentlyViewedUseCase recentlyViewedUseCase,
    required OffersUseCase offersUseCase,
    required OrdersUseCase ordersUseCase,
  }
  ) :
       _mainSearchProductUseCase = mainSearchProductUseCase,
       _mainSearchShopUseCase = mainSearchShopUseCase,
       _productDetailsUseCase = productDetailsUseCase,
       _productDataUseCase = productDataUseCase,
       _addFavouriteUseCase = addFavouriteUseCase,
       _addToCartUseCase = addToCartUseCase,
       _addOfferToCartUseCase = addOfferToCartUseCase,
       _shopDataUseCase = shopDataUseCase,
       _storeOffersUseCase = storeOffersUseCase,
       _storeOfferDetailsUseCase = storeOfferDetailsUseCase,
       _deleteAccountUseCase = deleteAccountUseCase,
       _resetPasswordSUseCase = resetPasswordSUseCase,
       _aboutExponileUseCase = aboutExponileUseCase,
       _submitComplainUseCase = submitComplainUseCase,
       _favouriteStoresUseCase = favouriteStoresUseCase,
       _favouriteProductsUseCase = favouriteProductsUseCase,
       _accountDataUseCase = accountDataUseCase,
       _deleteAddressUseCase = deleteAddressUseCase,
       _citiesUseCase = citiesUseCase,
       _areasUseCase = areasUseCase,
       _locationUseCase = locationUseCase,
       _getLocationUseCase = getLocationUseCase,
       _addLocationUseCase = addLocationUseCase,
       _landingUseCase = landingUseCase,
       _categoriesUseCase = categoriesUseCase,
       _mostOffersUseCase = mostOffersUseCase,
       _homeFavouriteStoresUseCase = homeFavouriteStoresUseCase,
       _discoverNewStoresUseCase = discoverNewStoresUseCase,
       _bestSellersStoresUseCase = bestSellersStoresUseCase,
       _newArrivalsUseCase = newArrivalsUseCase,
       _hotDealsUseCase = hotDealsUseCase,
       _bestSellingProductsUseCase = bestSellingProductsUseCase,
       _topCategoriesUseCase = topCategoriesUseCase,
       _recentlyViewedUseCase = recentlyViewedUseCase,
       _offersUseCase = offersUseCase,
       _ordersUseCase = ordersUseCase,


      super(Empty());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentNavIndex = 0;

  void changeNavBottomScreens(int index) {
    emit(InitState());
    currentNavIndex = index;
    emit(HomeChangeNavBottomScreensState());
  }

  List<Widget> customer = [
    const HomeScreen(),
    const AllOffersScreen(),
    const CategoriesScreen(),
    Container(),
    const OrdersScreen(),
    const SettingsScreen(),
  ];

  TextEditingController mainSearchController = TextEditingController();


  Map<String, String> filterMainSearch = {};
  String? selectedMainSearchName;
  String? selectedMainSearchType;

  void selectSearchType({
    required String? mainSearchName,
    required String? mainSearchType,
  }){
    emit(InitState());
    selectedMainSearchName = mainSearchName;
    selectedMainSearchType = mainSearchType;
    emit(ChangeState());
  }
  List<String> mainSearchImages=[
    Assets.images.svg.product,
    Assets.images.svg.shop,
  ];


   MainSearchProductEntity? mainSearchProductEntity;
   void mainSearchProduct({
     required String searchText,
   }) async {
     emit(MainSearchProductsLoadingState());
     final result = await _mainSearchProductUseCase(
         MainSearchProductParams(
             searchText: searchText,
         )
     );
     result.fold((failure) {
       emit(MainSearchProductsErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       mainSearchProductEntity = data;
       emit(MainSearchProductsSuccessState(
           mainSearchProductEntity: data
       ));
     });
   }


   MainSearchShopEntity? mainSearchShopEntity;

   void mainSearchShop({
     required String searchText,
   }) async {
     emit(MainSearchShopsLoadingState());
     final result = await _mainSearchShopUseCase(
         MainSearchShopParams(
           searchText: searchText,
         )
     );
     result.fold((failure) {
       emit(MainSearchShopsErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       mainSearchShopEntity = data;
       emit(MainSearchShopsSuccessState(
           mainSearchShopEntity: data
       ));
     });
   }


   Map<int, int> productIdsMap = {};
   int selectedIndex = 0;
   int selectedImages = 0;
   int currentIndex = 0;
   String initFeature='';
   Map<int,List<String>> images = {};
   Map<String, List<String>> featuresMap = {};
   int featureIndex = 0;
   int productQuantity = 0;
   bool isInStock = false;
   int? pressedIndex;
   int average = 0;
   int? startIndex;
   String imageUrl = '';
   Map<String,String> featureType = {};
   String firstFeature = '';
   String secondFeature = '';
   int currentIndexProduct = 0;

   ProductDetailsEntity? productDetailsEntity;
   void productDetails({
     required int productID,
   }) async {
     emit(ProductDetailsLoadingState());
     productDetailsEntity = null;
     productDataEntity = null;
     final result = await _productDetailsUseCase(
         ProductDetailsParams(
           productID: productID,
         )
     );
     result.fold((failure) {
       emit(ProductDetailsErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) async {
       productDetailsEntity = data;


       selectedIndex = 0;
       selectedImages = 0;
       initFeature='';
       images = {};
       featuresMap = {};
       featureIndex = 0;
       productQuantity = 0;
       isInStock = false;
       pressedIndex;
       average = 0;
       startIndex;
       imageUrl = '';
       featureType = {};
       firstFeature = '';
       secondFeature = '';
       currentIndexProduct = 0;
       productIdsMap = {};

       imageUrl = productDetailsEntity!.data!.product!.images![0].imagePath ?? '';

       for (int i = 0; i < productDetailsEntity!.data!.product!.images!.length; i++) {
         if (productDetailsEntity!.data!.product!.images![i].subfeature != null) {
           int subfeature = productDetailsEntity!.data!.product!.images![i].subfeature!;
           String imagePath = productDetailsEntity!.data!.product!.images![i].imagePath!;

           if (!images.containsKey(subfeature)) {
             images[subfeature] = []; // Initialize the list for the subfeature if it doesn't exist
           }
           images[subfeature]!.add(imagePath);
           selectedImages = images.keys.toList()[0];
         }
       }

       for (var featureDetail in productDetailsEntity!.data!.featuresDetails!) {
         String feature1 = featureDetail.getSubfeature1!.name!;
         String feature2 = featureDetail.getSubfeature2!.name!;
         if (featuresMap.containsKey(feature1)) {
           featuresMap[feature1]!.add(feature2);
         } else {
           featuresMap[feature1] = [feature2];
         }
       }

       if(productDetailsEntity!.data!.featuresDetails![0].getSubfeature1 != null){
         featureType['feature1'] = productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature!.feature.toString();
       }else{
         featureType['feature1']='0';
       }

       if(productDetailsEntity!.data!.featuresDetails![0].getSubfeature2 != null && productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature != null){
         featureType['feature2'] = productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature!.feature.toString();
       }else{
         featureType['feature2']='0';
       }


       if(featureType.values.toList()[0] == '0'||featureType.values.toList()[0] == '4')
       {
         firstFeature = isRTL == true ? 'بدون مميزات' : 'Without Feature';
       }else if(featureType.values.toList()[0] == '2'){
         firstFeature = isRTL == true ? 'اللون' : 'Color';
       }else if(featureType.values.toList()[0] == '3'){
         firstFeature = isRTL == true ? 'الحجم' : 'Size';
       }else if(featureType.values.toList()[0] == '1'){
         firstFeature = isRTL == true ? 'ميزات أخري' : 'Others';
       }

       if(featureType.values.toList()[1] == '0'||featureType.values.toList()[1] == '4')
       {
         secondFeature = isRTL == true ? 'بدون مميزات' : 'Without Feature';
       }else if(featureType.values.toList()[1] == '2'){
         secondFeature = isRTL == true ? 'اللون' : 'Color';
       }else if(featureType.values.toList()[1] == '3'){
         secondFeature = isRTL == true ? 'الحجم' : 'Size';
       }else if(featureType.values.toList()[1] == '1'){
         secondFeature = isRTL == true ? 'ميزات أخري' : 'Others';
       }


       featureType['feature1'] = firstFeature;
       featureType['feature2'] = secondFeature;


       if(featureType['feature1']== (isRTL == true ? 'بدون مميزات' : 'Without Feature'))
       {
         featureType.remove('feature1');
       }

       if(featureType['feature2']== (isRTL == true ? 'بدون مميزات' : 'Without Feature'))
       {
         featureType.remove('feature2');
       }
       if(featureType.isNotEmpty) {
         initFeature = featureType.values.first;
       }else{
         featureType['without']=isRTL == true ? 'بدون مميزات' : 'Without Feature';
         initFeature = featureType.values.first;
       }


       emit(ProductDetailsSuccessState(
           productDetailsEntity: data
       ));
     });
   }

   ProductDataEntity? productDataEntity;
   void productData({
     required int productID,
   }) async {
     emit(ProductDataLoadingState());
     final result = await _productDataUseCase(
         ProductDataParams(
           productID: productID,
         )
     );
     result.fold((failure) {
       emit(ProductDataErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       productDataEntity = data;
       emit(ProductDataSuccessState(
           productDataEntity: data
       ));
     });
   }


   void toggleRoleSelection(){
     emit(InitState());

     emit(ChangeState());
   }


   void addFavourite({
     required int itemID,
     required String itemType,
   }) async {
     emit(FavouriteLoadingState());
     final result = await _addFavouriteUseCase(
         AddFavouriteParams(
           itemID: itemID,
           itemType: itemType,
         )
     );
     result.fold((failure) {
       emit(FavouriteErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       emit(FavouriteSuccessState(
           addFavouriteEntity: data
       ));
     });
   }


   int addToCartCount = 1;
   void countPlusCart(){
     emit(InitState());
     addToCartCount ++;
     emit(ChangeState());
   }
   void countMinusCart(){
     emit(InitState());
     addToCartCount --;
     emit(ChangeState());
   }

   void addToCart({
     required int featureID,
     required String featureImage,
     required int qty,
     required String featureSlug,
   }) async {
     emit(AddToCartLoadingState());
     final result = await _addToCartUseCase(
         AddToCartParams(
           featureID: featureID,
           featureImage: featureImage,
           qty: qty,
           featureSlug: featureSlug,
         )
     );
     result.fold((failure) {
       emit(AddToCartErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       emit(AddToCartSuccessState(
           addToCartEntity: data
       ));
     });
   }


   ShopDataEntity? shopDataEntity;
   void shopData({
     required int? shopID,
     required List? category,
     required List? subCategory,
     required String? from,
     required String? to,
   }) async {
     emit(ShopDataLoadingState());
     shopDataEntity = null;
     final result = await _shopDataUseCase(
         ShopDataParams(
           shopID: shopID,
           category: category,
           subCategory: subCategory,
           from: from,
           to: to,
         )
     );
     result.fold((failure) {
       emit(ShopDataErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       shopDataEntity = data;
       isChangedFavouriteIcon = shopDataEntity!.data!.store
           .favorites.isNotEmpty
           ? true
           : false;
       for(int i = 0; i < data.data!.categories.length; i++) {
         filterShopCategories[data.data!.categories[i].id!] = data.data!.categories[i].slug!;
       }
       emit(ShopDataSuccessState(
           shopDataEntity: data
       ));
     });
   }

   List categoriesList = [];
   List subCategories = [];

   bool isChangedFavouriteIcon = false;
   void changedFavouriteIcon (){
     emit(InitState());
     isChangedFavouriteIcon = !isChangedFavouriteIcon;
     emit(ChangeState());
   }

   String? selectedFilterShopCategoryName;
   int? selectedFilterShopCategoryID;
   TextEditingController startFilterShopDateController = TextEditingController();
   TextEditingController endFilterShopDateController = TextEditingController();
   Map<int, String> filterShopCategories = {};

   void changeShopCategoriesValue({
     required String? filterShopCategoryName,
     required int? filterShopCategoryID,
   }){
     emit(InitState());
     selectedFilterShopCategoryName = filterShopCategoryName;
     selectedFilterShopCategoryID = filterShopCategoryID;
     emit(ChangeState());
   }


   StoreOffersEntity? storeOffersEntity;
   void storeOffers({
     required int? storeID,
   }) async {
     emit(StoreOffersLoadingState());
     storeOffersEntity = null;
     final result = await _storeOffersUseCase(
         StoreOffersParams(
           storeID: storeID,
         )
     );
     result.fold((failure) {
       emit(StoreOffersErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       storeOffersEntity = data;
       emit(StoreOffersSuccessState(
           storeOffersEntity: data
       ));
     });
   }


   StoreOfferDetailsEntity? storeOfferDetailsEntity;
   void storeOfferDetails({
     required int? offerID,
   }) async {
     storeOfferDetailsEntity = null;
     emit(StoreOfferDetailsLoadingState());
     final result = await _storeOfferDetailsUseCase(
         StoreOfferDetailsParams(
           offerID: offerID,
         )
     );
     result.fold((failure) {
       emit(StoreOfferDetailsErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       storeOfferDetailsEntity = data;
       emit(StoreOfferDetailsSuccessState(
           storeOfferDetailsEntity: data
       ));
     });
   }

   void addOfferToCart({
     required List offerProducts,
     required int qty,
     required String offerSlug,
   }) async {
     emit(AddOfferToCartLoadingState());
     final result = await _addOfferToCartUseCase(
         AddOfferToCartParams(
           offerSlug: offerSlug,
           offerProducts: offerProducts,
           qty: qty,
         )
     );
     result.fold((failure) {
       emit(AddOfferToCartErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       emit(AddOfferToCartSuccessState(
           addOfferToCartEntity: data
       ));
     });
   }


   List<Map<String,dynamic>> productsOfferList = [];

   void addProduct({
     required String productSlug,
     required int feature,
     required String image,
     required double price,
     required double oldPrice,
   })
 {
     emit(InitState());
     productsOfferList.add({
       'product_slug': productSlug,
       'feature': feature,
       'image': image,
       'price': price,
       'old_price': oldPrice,
       'isGet': "",
     });
     productsOfferList.sort((a, b) => b['price'].compareTo(a['price']));
     emit(ChangeState());
   }

   void deleteAccount({
     required String password
   }) async {
     emit(DeleteAccountLoadingState());
     final result = await _deleteAccountUseCase(
         DeleteAccountParams(
             password: password
         )
     );
     result.fold((failure) {
       emit(DeleteAccountErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       emit(DeleteAccountSuccessState(
           deleteAccountEntity: data
       ));
     });
   }


   void resetPassword({
     required String oldPassword,
     required String newPassword,
     required String confirmNewPassword
   }) async {
     emit(ResetPasswordLoadingState());
     final result = await _resetPasswordSUseCase(
         ResetPasswordSParams(
           confirmNewPassword : confirmNewPassword,
           newPassword : newPassword,
           oldPassword : oldPassword,
         )
     );
     result.fold((failure) {
       emit(ResetPasswordErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       emit(ResetPasswordSuccessState(
           resetPasswordEntity: data
       ));
     });
   }

   final TextEditingController passwordController = TextEditingController();
   final TextEditingController oldPasswordController = TextEditingController();
   final TextEditingController newPasswordController = TextEditingController();
   final TextEditingController confirmNewPasswordController = TextEditingController();


   AboutExponileEntity? aboutExponileEntity;
   void aboutExponile() async {
     emit(AboutExponileLoadingState());
     final result = await _aboutExponileUseCase(
         NoParams()
     );
     result.fold((failure) {
       emit(AboutExponileErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       aboutExponileEntity = data;
       emit(AboutExponileSuccessState(
           aboutExponileEntity: data
       ));
     });
   }

   final TextEditingController contactUsNameController = TextEditingController();
   final TextEditingController contactUsEmailController = TextEditingController();
   final TextEditingController contactUsPhoneController = TextEditingController();
   final TextEditingController contactUsMessageController = TextEditingController();
   final GlobalKey<FormState> contactUsFormKey = GlobalKey<FormState>();


   void submitComplain({
     required String name,
     required String email,
     required String phone,
     required String complain,
   }) async {
     emit(SubmitComplainLoadingState());
     final result = await _submitComplainUseCase(
         SubmitComplainParams(
           name : name,
           email : email,
           phone : phone,
           complain : complain,
         )
     );
     result.fold((failure) {
       emit(SubmitComplainErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       emit(SubmitComplainSuccessState(
           submitComplainEntity: data
       ));
     });
   }


   FavouriteStoresEntity? favouriteStoresEntity;
   void favouriteStores({
     required String itemType,
   }) async {
     emit(FavouriteStoresLoadingState());
     final result = await _favouriteStoresUseCase(
         FavouriteStoresParams(
           itemType : itemType,
         )
     );
     result.fold((failure) {
       emit(FavouriteStoresErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       favouriteStoresEntity = data;
       emit(FavouriteStoresSuccessState(
           favouriteStoresEntity: data
       ));
     });
   }


   FavouriteProductsEntity? favouriteProductsEntity;
   void favouriteProducts({
     required String itemType,
   }) async {
     emit(FavouriteProductsLoadingState());
     final result = await _favouriteProductsUseCase(
         FavouriteProductsParams(
           itemType : itemType,
         )
     );
     result.fold((failure) {
       emit(FavouriteProductsErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       favouriteProductsEntity = data;
       emit(FavouriteProductsSuccessState(
           favouriteProductsEntity: data
       ));
     });
   }


   AccountDataEntity? accountDataEntity;
   void accountData() async {
     emit(AccountDataLoadingState());
     final result = await _accountDataUseCase(
         NoParams(),
     );
     result.fold((failure) {
       emit(AccountDataErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       accountDataEntity = data;
       emit(AccountDataSuccessState(
           accountDataEntity: data
       ));
     });
   }


   void deleteAddress({
     required int? addressID,
   }) async {
     emit(DeleteAddressLoadingState());
     final result = await _deleteAddressUseCase(
         DeleteAddressParams(
           addressID : addressID,
         )
     );
     result.fold((failure) {
       emit(DeleteAddressErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       emit(DeleteAddressSuccessState(
           deleteAddressEntity: data
       ));
     });
   }



   LocationEntity? locationEntity;
   void location({
     required String? address,
   }) async {
     emit(LocationLoadingState());
     final result = await _locationUseCase(
         LocationParams(
           address: address!,
         )
     );
     result.fold((failure) {
       emit(LocationErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) async {
       locationEntity = data;
       emit(LocationSuccessState(
           locationEntity: data
       ));
     });
   }


   CitiesEntity? citiesEntity;
   List<CitiesData> filteredCities = [];

   void getCities() async {
     emit(CitiesLoadingState());

     final result = await _citiesUseCase(NoParams());

     result.fold((failure) {
       emit(CitiesErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       citiesEntity = data;
       filteredCities= data.data!;
       emit(CitiesSuccessState(
           citiesEntity: data
       )
       );
     });
   }

   AreasEntity? areasEntity;
   List<AreasData> filteredAreas = [];

   void getAreas(
       {
         required int cityID,
       }) async {
     emit(AreasLoadingState());

     final result = await _areasUseCase(
         AreasParams(
             cityId: cityID
         )
     );

     result.fold((failure) {
       emit(AreasErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       areasEntity = data;
       filteredAreas = data.data!;
       emit(AreasSuccessState(
         areasEntity: data
       ));
     });
   }



   String? selectedCityName;
   int? selectedCityID;

   void changeCityValue({
     required String cityName,
     required int cityID,
   }){
     emit(InitState());
     selectedCityName = cityName;
     selectedCityID = cityID;
     emit(ChangeState());
   }

   void filterCities(String value){
     emit(ChangeState());

     if (value.isNotEmpty) {
       filteredCities = citiesEntity!.data!.where((city) =>
           city.name!.toLowerCase().contains(value.toLowerCase())).toList();
     } else {
       filteredCities = citiesEntity!.data!;
     }
     emit(FilterState());
   }



   String? selectedAreaName;
   dynamic selectedAreaID;

   void changeAreaValue({
     required String areaName,
     required dynamic areaID,
   }){
     emit(InitState());
     selectedAreaName = areaName;
     selectedAreaID = areaID;
     emit(ChangeState());
   }

   void filterAreas(String value){
     emit(ChangeState());

     if (value.isNotEmpty) {
       filteredAreas = areasEntity!.data!.where((area) =>
           area.name!.toLowerCase().contains(value.toLowerCase())).toList();
     } else {
       filteredAreas = areasEntity!.data!;
     }
     emit(FilterState());
   }


   GetLocationEntity? getLocationEntity;
   void getLocation({
     required double? lat,
     required double? long,
   }) async {
     emit(GetLocationLoadingState());
     final result = await _getLocationUseCase(
         GetLocationParams(
           lat: lat!,
           long: long!,
         )
     );
     result.fold((failure) {
       emit(GetLocationErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) async {
       getLocationEntity = data;
       emit(GetLocationSuccessState(
           getLocationEntity: data
       ));
     });
   }

   bool isHome = false;
   bool isWork = false;

   void changeLocationPlace(
       {
         required bool isHomeValue,
         required bool isWorkValue,
       }
       ){
     emit(InitState());
     isHome = isHomeValue;
     isWork = isWorkValue;
     emit(ChangeState());
   }


   AddLocationEntity? addLocationEntity;
   void addLocation({
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
     emit(AddLocationLoadingState());
     final result = await _addLocationUseCase(
         AddLocationParams(
           area: area,
           governorate: governorate,
           late: late,
           long: long,
           streetName: streetName,
           buildingName: buildingName,
           landmark: landmark,
           floorNo: floorNo,
           aptNo: aptNo,
           type: type,
         )
     );
     result.fold((failure) {
       emit(AddLocationErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) async {
       addLocationEntity = data;
       emit(AddLocationSuccessState(
           addLocationEntity: data
       ));
     });
   }


   LandingEntity? landingEntity;
   void landing() async {
     emit(LandingLoadingState());

     final result = await _landingUseCase(NoParams());

     result.fold((failure) {
       emit(LandingErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       landingEntity = data;
       emit(LandingSuccessState(
           landingEntity: data
       )
       );
     });
   }


   CategoriesEntity? categoriesEntity;
   void categories() async {
     emit(CategoriesLoadingState());

     final result = await _categoriesUseCase(NoParams());

     result.fold((failure) {
       emit(CategoriesErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       categoriesEntity = data;
       filterCategoriesProduct = data.data.productCats;
       filterCategoriesStores = data.data.storeCats;
       emit(CategoriesSuccessState(
           categoriesEntity: data
       )
       );
     });
   }


   MostOffersEntity? mostOffersEntity;
   void mostOffers() async {
     emit(MostOffersLoadingState());

     final result = await _mostOffersUseCase(NoParams());

     result.fold((failure) {
       emit(MostOffersErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       mostOffersEntity = data;
       emit(MostOffersSuccessState(
           mostOffersEntity: data
       )
       );
     });
   }


  HomeFavouriteStoresEntity? homeFavouriteStoresEntity;
   void homeFavouriteStores({
     required String? storeCategory,
     required String? offerType,
     required String? sortedBy,
}) async {
     emit(HomeFavouriteStoresLoadingState());

     final result = await _homeFavouriteStoresUseCase(
       HomeFavouriteStoresParams(
           pageNumber: 1,
           storeCategory: storeCategory,
           offerType: offerType,
           sortedBy: sortedBy
       )
     );

     result.fold((failure) {
       emit(HomeFavouriteStoresErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       homeFavouriteStoresEntity = data;
       emit(HomeFavouriteStoresSuccessState(
           homeFavouriteStoresEntity: data
       )
       );
     });
   }


   DiscoverNewStoresEntity? discoverNewStoresEntity;
   void discoverNewStores({
     required String? storeCategory,
     required String? offerType,
     required String? sortedBy,
   }) async {
     emit(DiscoverNewStoresLoadingState());

     final result = await _discoverNewStoresUseCase(
         DiscoverNewStoresParams(
             pageNumber: 1,
             storeCategory: storeCategory,
             offerType: offerType,
             sortedBy: sortedBy
         )
     );

     result.fold((failure) {
       emit(DiscoverNewStoresErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       discoverNewStoresEntity = data;
       emit(DiscoverNewStoresSuccessState(
           discoverNewStoresEntity: data
       )
       );
     });
   }



   BestSellersStoresEntity? bestSellersStoresEntity;
   void bestSellersStores({
     required String? storeCategory,
     required String? offerType,
     required String? sortedBy,
   }) async {
     emit(BestSellersStoresLoadingState());

     final result = await _bestSellersStoresUseCase(
         BestSellersStoresParams(
             pageNumber: 1,
             storeCategory: storeCategory,
             offerType: offerType,
             sortedBy: sortedBy
         )
     );

     result.fold((failure) {
       emit(BestSellersStoresErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       bestSellersStoresEntity = data;
       emit(BestSellersStoresSuccessState(
           bestSellersStoresEntity: data
       )
       );
     });
   }



   NewArrivalsEntity? newArrivalsEntity;
   void newArrivals({
     required List<String>? productCategories,
     required List<String>? storeCategories,
   }) async {
     emit(NewArrivalsLoadingState());

     final result = await _newArrivalsUseCase(
         NewArrivalsParams(
             pageNumber: 1,
             productCategories: productCategories,
             storeCategories: storeCategories,
         )
     );

     result.fold((failure) {
       emit(NewArrivalsErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       newArrivalsEntity = data;
       emit(NewArrivalsSuccessState(
           newArrivalsEntity: data
       )
       );
     });
   }


   HotDealsEntity? hotDealsEntity;
   void hotDeals({
     required List<String>? productCategories,
     required List<String>? storeCategories,
   }) async {
     emit(HotDealsLoadingState());

     final result = await _hotDealsUseCase(
         HotDealsParams(
           pageNumber: 1,
           productCategories: productCategories,
           storeCategories: storeCategories,
         )
     );

     result.fold((failure) {
       emit(HotDealsErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       hotDealsEntity = data;
       emit(HotDealsSuccessState(
           hotDealsEntity: data
       )
       );
     });
   }



   List<BestSellingProductsEntity>? bestSellingProductsEntity;
   void bestSellingProducts() async {
     emit(HotDealsLoadingState());

     final result = await _bestSellingProductsUseCase(
         NoParams()
     );

     result.fold((failure) {
       emit(BestSellingProductsErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       bestSellingProductsEntity = data;
       emit(BestSellingProductsSuccessState(
           bestSellingProductsEntity: data
       )
       );
     });
   }


   int bestSellingCurrentIndex = 0;
   void changeBestCurrentIndex({required int value})
   {
     emit(InitState());
     bestSellingCurrentIndex = value;
     emit(ChangeState());
   }


   TopCategoriesEntity? topCategoriesEntity;
   void topCategories() async {
     emit(TopCategoriesLoadingState());

     final result = await _topCategoriesUseCase(
         NoParams()
     );

     result.fold((failure) {
       emit(TopCategoriesErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       topCategoriesEntity = data;
       if (topCategoriesEntity!.data.length > 4) {
         topCategoriesEntity!.data = topCategoriesEntity!.data.sublist(0, 4);
       }
       emit(TopCategoriesSuccessState(
           topCategoriesEntity: data
       )
       );
     });
   }



   int topCategoriesCurrentIndex = 0;
   void changeTopCurrentIndex({required int value})
   {
     emit(InitState());
     topCategoriesCurrentIndex = value;
     emit(ChangeState());
   }


   List<RecentlyViewedEntity>? recentlyViewedEntity;
   void recentlyViewed() async {
     emit(RecentlyViewedLoadingState());

     final result = await _recentlyViewedUseCase(
         NoParams()
     );

     result.fold((failure) {
       emit(RecentlyViewedErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       recentlyViewedEntity = data;
       emit(RecentlyViewedSuccessState(
           recentlyViewedEntity: data
       )
       );
     });
   }

   int totalTopCategories = 4;


   List<Widget> homeWidgets = [
     const Banners(),
     const CategorySlider(),
     const NewArrivalsList(),
     const HotDealsList(),
     const OffersList(),
     const FavouriteList(),
     const DiscoverList(),
     const BestSellersList(),
     const BestSellingProductsList(),
     const TopCategoriesList(),
     const RecentlyList(),
   ];


   int pageNumber = 1;

   OffersEntity? offersEntity;
   void offers({
     required List<String>? productCategories,
     required List<String>? storeCategories,
   }) async {
     emit(OffersLoadingState());

     final result = await _offersUseCase(
         OffersParams(
           pageNumber: pageNumber,
           productCategories: productCategories,
           storeCategories: storeCategories,
         )
     );

     result.fold((failure) {
       emit(OffersErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       offersEntity = data;
       emit(OffersSuccessState(
           offersEntity: data
       )
       );
     });
   }

   void changePageNumber({
     required int page,
   }){
     emit(InitState());
     pageNumber = page;
     emit(ChangeState());
   }




   final TextEditingController searchCategoryProductFilter = TextEditingController();
   final TextEditingController searchCategoryStoreFilter = TextEditingController();



   List<ProductCat> filterCategoriesProduct = [];
   void filterCategoriesProducts(String value) {
     emit(ChangeState());
     if (value.isNotEmpty) {
       // Filter the categories based on the search value
       filterCategoriesProduct = [];
       filterCategoriesProduct = categoriesEntity!.data.productCats.where((category) =>
           category.name.toLowerCase().contains(value.toLowerCase())).toList();
     } else {
       // If the search value is empty, revert to full data
       filterCategoriesProduct = categoriesEntity!.data.productCats;
     }
     emit(FilterState());
   }

   String? selectedCategoriesProductsName;

   void changeCategoriesProductsValue({
     required String? categoriesProductsName,
   }){
     emit(InitState());
     selectedCategoriesProductsName = categoriesProductsName;
     emit(ChangeState());
   }


   List<StoreCat> filterCategoriesStores = [];
   void filterCategoriesStore(String value) {
     emit(ChangeState());
     if (value.isNotEmpty) {
       // Filter the categories based on the search value
       filterCategoriesStores = [];
       filterCategoriesStores = categoriesEntity!.data.storeCats.where((category) =>
           category.name.toLowerCase().contains(value.toLowerCase())).toList();
     } else {
       // If the search value is empty, revert to full data
       filterCategoriesStores = categoriesEntity!.data.storeCats;
     }
     emit(FilterState());
   }

   String? selectedCategoriesStoresName;

   void changeCategoriesStoresValue({
     required String? categoriesStoresName,
   }){
     emit(InitState());
     selectedCategoriesStoresName = categoriesStoresName;
     emit(ChangeState());
   }


   OrdersEntity? ordersEntity;
   void orders({
     required String? status,
   }) async {
     emit(OrdersLoadingState());

     final result = await _ordersUseCase(
         OrdersParams(
           pageNumber: pageNumber,
           status: status,
         )
     );

     result.fold((failure) {
       emit(OrdersErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       ordersEntity = data;
       emit(OrdersSuccessState(
           ordersEntity: data
       )
       );
     });
   }


}
