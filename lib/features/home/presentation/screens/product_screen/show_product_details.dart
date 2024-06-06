import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:exponile_customer/features/home/presentation/screens/product_screen/product_card.dart';
import 'package:exponile_customer/features/home/presentation/screens/shop_screen/offers/product_offer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/loading_files/product_loading.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../../../../core/util/widgets/main_appbar.dart';
import '../../../../../core/util/widgets/progress.dart';
import '../../controller/cubit.dart';
import '../../controller/state.dart';

class ShowProductDetails extends StatefulWidget {
  const ShowProductDetails({super.key,required this.productID, this.isBuyGetOffer});
  final int productID;
  final bool? isBuyGetOffer;

  @override
  State<ShowProductDetails> createState() => _ShowProductDetailsState();
}

class _ShowProductDetailsState extends State<ShowProductDetails> {

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.productDetails(productID: widget.productID);
    homeCubit.productData(productID: widget.productID);
    homeCubit.addToCartCount = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {
          if(state is  FavouriteLoadingState){
            showDialog(
              context: context,
              builder: (context) {
                return ProgressDialog(message: appBloc.translationModel!.loading);
              },
            );
          }
          if (state is FavouriteErrorState) {
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.error,
                text: state.failure.toString());
          }
          if (state is FavouriteSuccessState && state.addFavouriteEntity.success == 0) {
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.error,
                text: state.addFavouriteEntity.data!
            );
          }
          if (state is FavouriteSuccessState && state.addFavouriteEntity.success == 1) {
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.success,
                text: state.addFavouriteEntity.data!
            );
            homeCubit.productData(productID: widget.productID);
          }


          if(state is  AddToCartLoadingState){
            showDialog(
              context: context,
              builder: (context) {
                return ProgressDialog(message: appBloc.translationModel!.loading);
              },
            );
          }
          if (state is AddToCartErrorState) {
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.error,
                text: state.failure.toString());
          }
          if (state is AddToCartSuccessState && state.addToCartEntity.success == 0) {
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.error,
                text: state.addToCartEntity.message!
            );
          }
          if (state is AddToCartSuccessState && state.addToCartEntity.success == 1) {
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.success,
                text: state.addToCartEntity.message!
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: MainAppBar(
                title: appBloc.translationModel!.productDetails,
                isBack: true,
                isLang: false
            ),
            body: homeCubit.productDetailsEntity != null && homeCubit.productDataEntity != null?
            HideKeyboardPage(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                      width: 100.w,
                      child: ListView.builder(
                        //     controller: _scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: homeCubit.images[homeCubit.selectedImages]!.length,
                        //stocksProvider!.response!.data.product.images.length,
                        itemBuilder:(context, index) {
                          return Stack(
                            children: [
                              SizedBox(
                                height: 30.h,
                                width: 100.w,
                                child: CachedNetworkImage(
                                  imageUrl: homeCubit.images[homeCubit.selectedImages]![index] ,
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    height: MediaQuery.of(context).size.height / 1.5,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.rSp),
                                          topRight: Radius.circular(20.rSp)),
                                    ),
                                    child: svgImage(path: Assets.images.svg.noImage),
                                  ),
                                  placeholder: (context, url) => Container(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  width: 25.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.rSp,
                                        color: ColorsManager.mainColor,
                                      ),
                                      color: ColorsManager.success.withOpacity(0.2),
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.rSp))
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.rSp),
                                    child: DefaultText(
                                      title: homeCubit.productDetailsEntity!.data!.product!.getCategory!.name!,
                                      style: Style.small,
                                      fontWeight: FontWeight.w700,
                                      maxLines: 1,
                                      fontSize: 10.rSp,
                                      align: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: DefaultIconButton(
                                    icon: homeCubit.productDataEntity!.data!.product.favoritesCount == 1 ?
                                    const Icon(Icons.favorite,color: ColorsManager.success,):const Icon(Icons.favorite_border),
                                    onPressed: (){
                                      homeCubit.addFavourite(
                                          itemID: widget.productID,
                                          itemType: 'product'
                                      );
                                    }
                                ),
                              )

                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              svgImage(path: Assets.images.svg.product),
                              horizontalSpace(2.w),
                              DefaultText(
                                title: homeCubit.productDetailsEntity!.data!.product!.name!,
                                //textColor: AppColor.blackColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.rSp,
                                style: Style.small,
                              ),
                              const Spacer(),
                              RatingBar.builder(
                                initialRating: double.parse(homeCubit.productDetailsEntity!.data!.product!.rate!),
                                minRating: 0,
                                ignoreGestures: true,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 14.rSp,
                                //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0.rSp),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                },
                              ),
                            ],
                          ),
                          verticalSpace(4.h,),
                          Row(
                            children: [
                              svgImage(path: Assets.images.svg.description,width: 6.w,height:2.h),
                              horizontalSpace(2.w),
                              Expanded(
                                child: Align(
                                  alignment:appBloc.isArabic? Alignment.centerRight: Alignment.centerLeft,
                                  child: DefaultText(
                                    title: homeCubit.productDetailsEntity!.data!.product!.description!,
                                    //textColor: AppColor.blackColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.rSp,
                                    style: Style.small,
                                    maxLines: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(2.h,),
                          Container(
                            width: double.infinity,
                            height: 1.rSp,
                            color: ColorsManager.darkGrey.withOpacity(0.1),
                          ),
                          verticalSpace(2.h,),
                          if(homeCubit.productDetailsEntity!.data!.featuresDetails!.isNotEmpty)
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      if(homeCubit.productDataEntity!.data!.product.offers.isNotEmpty && homeCubit.productDataEntity!.data!.product.offers[0].type == 1)
                                        Expanded(
                                          child: Center(
                                            child: DefaultText(
                                              title: '${((100-homeCubit.productDataEntity!.data!.product.offers[0].value!)/100) * double.parse(homeCubit.productDetailsEntity!.data!.featuresDetails![homeCubit.featureIndex].price!)} ${appBloc.translationModel!.currency}',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.rSp,
                                              style: Style.small,
                                              color: ColorsManager.mainColor,
                                            ),
                                          ),
                                        ),
                                      Expanded(
                                        child: Center(
                                          child: DefaultText(
                                            title: '${homeCubit.productDetailsEntity!.data!.featuresDetails![homeCubit.featureIndex].price!} ${appBloc.translationModel!.currency}',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.rSp,
                                            style: Style.small,
                                            decoration:
                                            homeCubit.productDataEntity!.data!.product.offers.isNotEmpty && homeCubit.productDataEntity!.data!.product.offers[0].type == 1 ?
                                            TextDecoration.lineThrough : TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1.rSp,
                                  height: 2.h,
                                  color: ColorsManager.darkGrey,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DefaultText(
                                        title: '${homeCubit.productDetailsEntity!.data!.featuresDetails![homeCubit.featureIndex].quantity!} ',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.rSp,
                                        style: Style.small,
                                      ),
                                      horizontalSpace(2.w,),
                                      const Icon(Icons.production_quantity_limits),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.rSp,
                      color: ColorsManager.darkGrey.withOpacity(0.1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                      child: Column(
                        children: [
                          verticalSpace(1.h,),
                          if(homeCubit.productDetailsEntity!.data!.featuresDetails!.isNotEmpty && homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature!.feature != 4)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    DefaultText(
                                      title: homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature!.feature == 2 ?
                                      appBloc.translationModel!.color :
                                      homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature!.feature == 3 ?
                                      appBloc.translationModel!.size :
                                      appBloc.translationModel!.other,
                                      color: ColorsManager.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.rSp,
                                      style: Style.small,
                                    ),
                                    horizontalSpace(2.w),
                                    Expanded(
                                      child: SizedBox(
                                        // width: 20,
                                        height: 3.h,
                                        child: ListView.builder(
                                          itemCount: homeCubit.featuresMap.keys.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                homeCubit.selectedIndex = index;
                                                homeCubit.currentIndexProduct = 0;
                                                for (var featureDetail in homeCubit.productDetailsEntity!.data!.featuresDetails!) {
                                                  int itemIndex = homeCubit.productDetailsEntity!.data!.featuresDetails!.indexOf(featureDetail);
                                                  if(
                                                  homeCubit.featuresMap.keys.toList()[index] == featureDetail.getSubfeature1!.name && homeCubit.featuresMap.values.toList()[index][homeCubit.currentIndexProduct] == featureDetail.getSubfeature2!.name
                                                  ){
                                                    homeCubit.featureIndex = itemIndex;
                                                    homeCubit.selectedImages = homeCubit.images.keys.toList()[homeCubit.featureIndex];
                                                  }
                                                }
                                                homeCubit.toggleRoleSelection();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 2.w
                                                ),
                                                width: 16.w,
                                                height: 6.h,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                                                    border: Border.all(
                                                      width: 2.rSp,
                                                      color: homeCubit.selectedIndex == index? ColorsManager.mainColor: ColorsManager.black.withOpacity(0.6),
                                                    ),
                                                    color: homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature!.feature == 2 ?
                                                    Color(int.parse('0xff${homeCubit.featuresMap.keys.toList()[index].replaceAll('#', '')}')) : Colors.transparent
                                                ),
                                                child: homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature!.feature == 2 ?
                                                DefaultText(
                                                    style: Style.small,
                                                    title: '',
                                                    color: ColorsManager.black,
                                                    fontWeight: FontWeight.w500,fontSize: 10.rSp
                                                ):
                                                Center(
                                                  child: DefaultText(
                                                      style: Style.small,
                                                      title: homeCubit.featuresMap.keys.toList()[index],
                                                      color: ColorsManager.black,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 10.rSp
                                                  ),
                                                )
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(1.h),
                                Container(
                                  width: double.infinity,
                                  height: 1.rSp,
                                  color:ColorsManager.darkGrey.withOpacity(0.2),
                                ),
                                verticalSpace(1.h),
                              ],
                            ),
                          if(homeCubit.productDetailsEntity!.data!.featuresDetails!.isNotEmpty && homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature != null && homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature!.feature != 4)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    DefaultText(
                                      title: homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature!.feature == 2 ?
                                      appBloc.translationModel!.color :
                                      homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature!.feature == 3 ?
                                      appBloc.translationModel!.size :
                                      appBloc.translationModel!.other,
                                      color: ColorsManager.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.rSp,
                                      style: Style.small,
                                    ),
                                    horizontalSpace(4.w),
                                    Expanded(
                                      child: SizedBox(
                                        // width: 20,
                                        height: 3.h,
                                        child: ListView.builder(
                                          itemCount: homeCubit.featuresMap.values.toList()[homeCubit.selectedIndex].length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                homeCubit.currentIndexProduct = index;
                                                for (var featureDetail in homeCubit.productDetailsEntity!.data!.featuresDetails!) {
                                                  int itemIndex = homeCubit.productDetailsEntity!.data!.featuresDetails!.indexOf(featureDetail);
                                                  if(
                                                  homeCubit.featuresMap.keys.toList()[homeCubit.selectedIndex] == featureDetail.getSubfeature1!.name
                                                      &&
                                                      homeCubit.featuresMap.values.toList()[homeCubit.selectedIndex][index] == featureDetail.getSubfeature2!.name
                                                  ){
                                                    homeCubit.featureIndex = itemIndex;
                                                    homeCubit.selectedImages = homeCubit.images.keys.toList()[homeCubit.featureIndex];
                                                  }

                                                }
                                                homeCubit.toggleRoleSelection();
                                                },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 2.w
                                                ),
                                                width: 20.w,
                                                height: 6.h,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                                                  border: Border.all(
                                                    width: 1.rSp,
                                                    color: homeCubit.currentIndexProduct == index? ColorsManager.mainColor: ColorsManager.black.withOpacity(0.6),
                                                  ),
                                                  color: homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature!.feature == 2 ?
                                                  Color(int.parse('0xff${homeCubit.featuresMap.values.toList()[homeCubit.selectedIndex][index].replaceAll('#', '')}'),)
                                                      : Colors.transparent,
                                                ),
                                                child: homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature!.feature == 2 ?
                                                DefaultText(
                                                    title: '',style: Style.small,
                                                    fontWeight: FontWeight.w500,fontSize: 10.rSp
                                                ):
                                                Center(
                                                  child: DefaultText(
                                                      title: homeCubit.featuresMap.values.toList()[homeCubit.selectedIndex][index],
                                                      fontWeight: FontWeight.w700,
                                                      style: Style.small,
                                                      fontSize: 10.rSp
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(1.h),
                                Container(
                                  width: double.infinity,
                                  height: 1.rSp,
                                  color: ColorsManager.darkGrey.withOpacity(0.2),
                                ),
                              ],
                            ),
                          verticalSpace(2.h),
                          Container(
                            width: double.infinity,
                            height: 1.rSp,
                            color: ColorsManager.darkGrey.withOpacity(0.1),
                          ),
                          verticalSpace(2.h),
                          Column(
                            children: [
                              verticalSpace(1.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.warehouse_outlined),
                                  horizontalSpace(2.w),
                                  DefaultText(
                                    title: appBloc.translationModel!.warehouseMethod,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.rSp,
                                    style: Style.small,
                                  ),
                                  const Spacer(),
                                  DefaultText(
                                    title: homeCubit.productDetailsEntity!.data!.product!.getWarehouse!.shopWarehouseMethod!.name!,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.rSp,
                                    style: Style.small,
                                    color: ColorsManager.mainColor,
                                  ),
                                ],
                              ),
                              verticalSpace(2.h),
                              Container(
                                width: double.infinity,
                                height: 1.rSp,
                                color: ColorsManager.darkGrey.withOpacity(0.1),
                              ),
                              verticalSpace(1.h),
                            ],
                          ),
                          if(homeCubit.productDetailsEntity!.data!.product!.getDelivery != null)
                          Column(
                            children: [
                              verticalSpace(1.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.delivery_dining_outlined),
                                  horizontalSpace(2.w),
                                  DefaultText(
                                    title: appBloc.translationModel!.deliveryMethod,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.rSp,
                                    style: Style.small,
                                  ),
                                  const Spacer(),
                                  DefaultText(
                                    title: homeCubit.productDetailsEntity!.data!.product!.getDelivery!.getShopMethod!.getMethod!.name!,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.rSp,
                                    style: Style.small,
                                    color: ColorsManager.mainColor,
                                  ),
                                ],
                              ),
                              verticalSpace(2.h),
                              Container(
                                width: double.infinity,
                                height: 1.rSp,
                                color: ColorsManager.darkGrey.withOpacity(0.1),
                              ),
                              verticalSpace(1.h),

                            ],
                          ),
                          Column(
                            children: [
                              verticalSpace(1.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.shop),
                                  horizontalSpace(2.w),
                                  DefaultText(
                                    title: appBloc.translationModel!.shopName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.rSp,
                                    style: Style.small,
                                  ),
                                  const Spacer(),
                                  DefaultText(
                                    title: homeCubit.productDataEntity!.data!.product.getShop.shopName!,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.rSp,
                                    style: Style.small,
                                    color: ColorsManager.mainColor,
                                  ),
                                ],
                              ),
                              verticalSpace(2.h),
                              Container(
                                width: double.infinity,
                                height: 1.rSp,
                                color: ColorsManager.darkGrey.withOpacity(0.1),
                              ),
                              verticalSpace(1.h),
                            ],
                          ),

                        ],
                      ),
                    ),
                    if(widget.isBuyGetOffer == null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DefaultText(
                              title: appBloc.translationModel!.addToCart,
                              style: Style.medium,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.rSp,
                              color: ColorsManager.mainColor,
                          ),
                          horizontalSpace(6.w),

                          Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.rSp),
                                          bottomLeft: Radius.circular(10.rSp),
                                        ),
                                        color: ColorsManager.error,
                                      ),
                                      child: Center(
                                        child: DefaultIconButton(
                                            icon: const Icon(Icons.exposure_minus_1),
                                            onPressed: (){
                                              if(homeCubit.addToCartCount > 1){
                                                homeCubit.countMinusCart();
                                              }
                                            }
                                        ),
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(1.w),
                                  Expanded(
                                    child: Center(
                                      child: DefaultText(
                                          title: homeCubit.addToCartCount.toString(),
                                          style: Style.medium,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.rSp,
                                          color: ColorsManager.mainColor,
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(1.w),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.rSp),
                                          bottomRight: Radius.circular(10.rSp),
                                        ),
                                        color: ColorsManager.success,
                                      ),
                                      child: Center(
                                        child: DefaultIconButton(
                                            icon: const Icon(Icons.exposure_plus_1),
                                            onPressed: (){
                                              if(homeCubit.addToCartCount < int.parse(homeCubit.productDetailsEntity!.data!.featuresDetails![homeCubit.featureIndex].quantity!)){
                                                homeCubit.countPlusCart();
                                              }
                                            }
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                          horizontalSpace(4.w),
                          Expanded(
                            child: DefaultIconButton(
                              onPressed: (){
                                homeCubit.addToCart(
                                    featureID: homeCubit.productDetailsEntity!.data!.featuresDetails![homeCubit.featureIndex].id!,
                                    featureImage:  homeCubit.images[homeCubit.selectedImages]![0],
                                    qty: homeCubit.addToCartCount,
                                    featureSlug: homeCubit.productDataEntity!.data!.product.slug!
                                );
                              },
                              icon: const Icon(Icons.add_shopping_cart,color: ColorsManager.mainColor,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if(widget.isBuyGetOffer != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: DefaultButton(
                          text: appBloc.translationModel!.addToCart,
                          onPressed: (){
                            homeCubit.addProduct(
                                feature: homeCubit.productDetailsEntity!.data!.featuresDetails![homeCubit.featureIndex].id!,
                                image: homeCubit.images[homeCubit.selectedImages]![0],
                                oldPrice: double.parse(homeCubit.productDetailsEntity!.data!.featuresDetails![homeCubit.featureIndex].price!),
                                price: double.parse(homeCubit.productDetailsEntity!.data!.featuresDetails![homeCubit.featureIndex].price!),
                                productSlug: homeCubit.productDataEntity!.data!.product.slug!,
                            );
                            // homeCubit.productsOfferList.add(
                            //
                            //     ProductFeatureModel(
                            //         productSlug: homeCubit.productDataEntity!.data!.product.slug!,
                            //         feature: homeCubit.productDetailsEntity!.data!.featuresDetails![homeCubit.featureIndex].id!,
                            //         image: homeCubit.images[homeCubit.selectedImages]![0],
                            //         price: double.parse(homeCubit.productDetailsEntity!.data!.featuresDetails![homeCubit.featureIndex].price!),
                            //         oldPrice: double.parse(homeCubit.productDetailsEntity!.data!.featuresDetails![homeCubit.featureIndex].price!),
                            //         isGet: ''
                            //     ),
                            // );
                            homeCubit.toggleRoleSelection();
                            Navigator.pop(context);
                          },
                      ),
                    ),

                    if(homeCubit.productDataEntity!.data!.reviews.isNotEmpty)
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.rSp),
                        child: DefaultText(
                            title: appBloc.translationModel!.reviews,
                            style: Style.medium,
                            color: ColorsManager.mainColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.rSp,
                        ),
                    ),
                    verticalSpace(1.h),
                    homeCubit.productDataEntity!.data!.reviews.isNotEmpty
                        ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: homeCubit.productDataEntity!.data!.reviews.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.rSp, vertical: 5.rSp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50.rSp,
                                  height: 50.rSp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.rSp),
                                    color: ColorsManager.mintGreen.withOpacity(0.5),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          homeCubit.productDataEntity!.data!.reviews[index].getUser.imagePath ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                horizontalSpace(1.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      DefaultText(
                                          title: homeCubit.productDataEntity!.data!.reviews[index].getUser.username ?? '',
                                          fontSize: 18.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mintGreen.withOpacity(0.5),
                                          style: Style.medium,
                                      ),
                                      DefaultText(
                                          title: homeCubit.productDataEntity!.data!
                                              .reviews[index]
                                              .createdAt ??
                                              '',
                                        fontSize: 18.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mintGreen.withOpacity(0.5),
                                        style: Style.medium,
                                      ),
                                      DefaultText(
                                          title: homeCubit.productDataEntity!.data!
                                              .reviews[index]
                                              .review ??
                                              '',
                                        fontSize: 18.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mintGreen.withOpacity(0.5),
                                        style: Style.medium,
                                        maxLines: 2
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        })
                        : Container(),
                    verticalSpace(1.h),
                    if(homeCubit.productDataEntity!.data!.relatedProductSameShop.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.rSp),
                          child: DefaultText(
                            title: appBloc.translationModel!.relatedProductsFromSameStores,
                            style: Style.medium,
                            fontSize: 14.rSp,
                            fontWeight: FontWeight.w700,
                            color: ColorsManager.mainColor,
                          ),
                        ),
                        verticalSpace(1.h),
                        SizedBox(
                          width: double.infinity,
                          height:
                          MediaQuery.of(context).size.height / 2.7,
                          child: ListView.builder(
                              shrinkWrap: true,
                              //physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: homeCubit.productDataEntity!.data!
                                  .relatedProductSameShop.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.rSp, vertical: 5.rSp),
                                  child: ProductCard(
                                    imagePath: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].images,
                                    imagesCount: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].images.length,
                                    category: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].getCategory.name ?? '',
                                    name: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].name ?? '',
                                    newPrice: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].basicPrice ?? '',
                                    rate: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].rate ?? '',
                                    ratingCount: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].ratings!.length ,
                                    onProductTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowProductDetails(
                                                    productID: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].id!,
                                                  )));
                                    },
                                    isFavourite: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].favoritesCount ==1 ? true : false,
                                    onFavoriteTap: ()
                                    {
                                      homeCubit.addFavourite(
                                          itemID: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].id!,
                                          itemType: 'product'
                                      );
                                    },
                                    offer: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].offers.isNotEmpty && homeCubit.productDataEntity!.data!.relatedProductSameShop[index].offers[0].type == 1 ? '-${homeCubit.productDataEntity!.data!.relatedProductSameShop[index].offers[0].value} %':null,
                                    offerType: homeCubit.productDataEntity!.data!.relatedProductSameShop[index].offers.isNotEmpty ? homeCubit.productDataEntity!.data!.relatedProductSameShop[index].offers[0].type :null,

                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    verticalSpace(1.h),
                    if(homeCubit.productDataEntity!.data!.relatedProductDiffShop.isNotEmpty)
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.rSp),
                          child: DefaultText(
                              title: appBloc.translationModel!.relatedProductsFromOtherStores,
                              style: Style.medium,
                              fontSize: 14.rSp,
                              fontWeight: FontWeight.w700,
                              color: ColorsManager.mainColor,
                          ),
                        ),
                        verticalSpace(1.h),
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: homeCubit.productDataEntity!.data!.relatedProductDiffShop.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.rSp, vertical: 5.rSp),
                                  child: ProductCard(
                                    imagePath: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].images,
                                    imagesCount: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].images.length,
                                    category: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].getCategory.name ?? '',
                                    name: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].name ?? '',
                                    newPrice: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].basicPrice ?? '',
                                    rate: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].rate ?? '',
                                    ratingCount: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].ratings!.length ,
                                    isFavourite: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].favoritesCount ==1 ? true : false,
                                    onProductTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowProductDetails(
                                                    productID: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].id!,
                                                  )));
                                    },
                                    onFavoriteTap:   () {
                                      homeCubit.addFavourite(
                                          itemID: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].id!,
                                          itemType: 'product'
                                      );
                                    },
                                    offer: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].offers.isNotEmpty && homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].offers[0].type == 1 ? '-${homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].offers[0].value} %':null,
                                    offerType: homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].offers.isNotEmpty ? homeCubit.productDataEntity!.data!.relatedProductDiffShop[index].offers[0].type :null,
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ) :
            const ProductDetailsLoading(),
          );
        },
      ),
    );
  }
}
