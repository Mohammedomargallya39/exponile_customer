import 'package:exponile_customer/core/usecase/use_case.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/features/home/domain/entities/about_exponile_entity.dart';
import 'package:exponile_customer/features/home/domain/usecase/about_exponile_usecase.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../domain/entities/main_search_product_entity.dart';
import '../../domain/entities/main_search_shop_entity.dart';
import '../../domain/entities/product_data_entity.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/shop_data_entity.dart';
import '../../domain/entities/store_offer_details_entity.dart';
import '../../domain/entities/store_offers_entity.dart';
import '../../domain/usecase/add_favourite_usecase.dart';
import '../../domain/usecase/add_offer_to_cart_usecase.dart';
import '../../domain/usecase/add_to_cart_usecase.dart';
import '../../domain/usecase/delete_account_usecase.dart';
import '../../domain/usecase/main_search_product_usecase.dart';
import '../../domain/usecase/main_search_shop_usecase.dart';
import '../../domain/usecase/product_data_usecase.dart';
import '../../domain/usecase/product_details_usecase.dart';
import '../../domain/usecase/reset_password_usecase.dart';
import '../../domain/usecase/shop_data_usecase.dart';
import '../../domain/usecase/store_offer_details_usecase.dart';
import '../../domain/usecase/store_offers_usecase.dart';
import '../../domain/usecase/submit_complain_usecase.dart';
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


      super(Empty());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentNavIndex = 0;

  void changeNavBottomScreens(int index) {
    emit(InitState());
    currentNavIndex = index;
    emit(HomeChangeNavBottomScreensState());
  }

  List<Widget> customer = [
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
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

   List categories = [];
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

}