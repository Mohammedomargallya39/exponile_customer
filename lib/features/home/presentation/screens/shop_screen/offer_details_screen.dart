import "package:cached_network_image/cached_network_image.dart";
import "package:card_loading/card_loading.dart";
import "package:exponile_customer/core/util/cubit/cubit.dart";
import "package:exponile_customer/core/util/loading_files/offer_loading.dart";
import "package:exponile_customer/core/util/resources/colors_manager.dart";
import "package:exponile_customer/core/util/resources/extensions_manager.dart";
import "package:exponile_customer/core/util/widgets/default_button.dart";
import "package:exponile_customer/core/util/widgets/default_text.dart";
import "package:exponile_customer/core/util/widgets/main_appbar.dart";
import "package:exponile_customer/core/util/widgets/my_icon_button.dart";
import "package:exponile_customer/features/home/presentation/controller/state.dart";
import "package:exponile_customer/features/home/presentation/screens/product_screen/product_card.dart";
import "package:exponile_customer/features/home/presentation/screens/product_screen/show_product_details.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_staggered_animations/flutter_staggered_animations.dart";
import "../../../../../core/util/resources/assets.gen.dart";
import "../../../../../core/util/resources/constants_manager.dart";
import "../../../../../core/util/widgets/progress.dart";
import "../../controller/cubit.dart";
import "offers/offer_store_details_card.dart";

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({super.key, required this.offerId, this.storeCategories});
  final int offerId;
  final dynamic storeCategories;
  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {

  List<String> storeCategoryList = [];
  String storeCategories = "";

  @override
  void initState() {
    storeCategoryList = widget.storeCategories;
    storeCategories = [for (var data in (storeCategoryList)) data].join(",");
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.storeOfferDetails(offerID: widget.offerId);
    homeCubit.isChangedFavouriteIcon = false;
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
          if(state is  AddOfferToCartLoadingState){
            showDialog(
              context: context,
              builder: (context) {
                return ProgressDialog(message: appBloc.translationModel!.loading);
              },
            );
          }
          if (state is AddOfferToCartErrorState) {
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.error,
                text: state.failure.toString());
          }
          if (state is AddOfferToCartSuccessState && state.addOfferToCartEntity.success == 0) {
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.error,
                text: state.addOfferToCartEntity.message!
            );
          }
          if (state is AddOfferToCartSuccessState && state.addOfferToCartEntity.success == 1) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.success,
                text: state.addOfferToCartEntity.message!
            );
          }

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
                text: state.addFavouriteEntity.message!
            );
          }
          if (state is FavouriteSuccessState && state.addFavouriteEntity.success == 1) {
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.success,
                text: state.addFavouriteEntity.message!
            );
          }

        },
        builder: (context, state) {
          return Scaffold(
              appBar: MainAppBar(
                  title: appBloc.translationModel!.offerDetails,
                  isBack: true,
                  isLang: false
              ),
              body:  homeCubit.storeOfferDetailsEntity == null ?
              const OfferDetailsLoading() :
              homeCubit.storeOffersEntity!.data!.offers.isEmpty ?
              Center(
                  child: svgImage(
                      path: Assets.images.svg.noImage
                  )
              ):
              SingleChildScrollView(
                child: homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 3
                    ? Column(
                  children: [
                    OfferStoreDetailsCard(
                      storeCategories: storeCategories,
                      storeName: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.shopName ?? "",
                      storeRate: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.rate ?? "",
                      storeLogo: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.logoPath ?? "",
                      offerPath: homeCubit.storeOfferDetailsEntity!.data!.offer!.bannerPath ?? "",
                      isFavorite: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.favorites!.isNotEmpty ? true : false,
                      storeAddToFav:   () async {
                        homeCubit.addFavourite(
                          itemType: 'store',
                          itemID: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.id!,
                        );
                        homeCubit.changedFavouriteIcon();
                      },
                    ),
                    Divider(color: ColorsManager.mainColor,thickness: 1.rSp,)
                  ],
                )
                    : Column(
                  children: [
                   OfferStoreDetailsCard(
                      storeCategories: storeCategories,
                      storeName: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.shopName ?? "",
                      storeRate: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.rate ?? "",
                      storeLogo: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.logoPath ?? "",
                      offerPath: homeCubit.storeOfferDetailsEntity!.data!.offer!.bannerPath ?? "",
                      isFavorite: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.favorites!.isNotEmpty ? true : false,
                      storeAddToFav:   () async {
                        homeCubit.addFavourite(
                          itemType: 'store',
                          itemID: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.id!,
                        );
                        homeCubit.changedFavouriteIcon();
                      },

                    ),
                   Divider(color: ColorsManager.mainColor,thickness: 1.rSp,),
                    if(homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 2)
                    Padding(
                        padding: EdgeInsets.all(5.rSp),
                        child: Row(
                          children: [
                            Icon(Icons.card_giftcard,
                                color: ColorsManager.mainColor, size: 30.rSp),
                            Row(
                              children: [
                                DefaultText(
                                  title: " ${appBloc.translationModel!.buy}  ${homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount} ${appBloc.translationModel!.get} ${homeCubit.storeOfferDetailsEntity!.data!.offer!.getAmount} ",
                                  style: Style.medium,
                                  fontSize: 16.rSp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.mainColor,
                                ),
                                horizontalSpace(2.w),
                                DefaultText(
                                  title: " *${appBloc.translationModel!.total}  ${homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount! + homeCubit.storeOfferDetailsEntity!.data!.offer!.getAmount!}*",
                                  style: Style.medium,
                                  fontSize: 16.rSp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.mainColor,
                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    verticalSpace(1.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: AnimationLimiter(
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 5.w,
                                        crossAxisSpacing: 2.w,
                                        mainAxisExtent: 37.h,
                                        mainAxisSpacing: 2.h
                                    ),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: homeCubit.storeOfferDetailsEntity!.data!.products!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return AnimationConfiguration.staggeredGrid(
                                        columnCount: 2,
                                        position: index,
                                        duration: const Duration(milliseconds: 1000),
                                        child: ScaleAnimation(
                                          duration: const Duration(milliseconds: 1000),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          scale: 1.5,
                                          child: FadeInAnimation(
                                            child: ProductCard(
                                              imagePath: homeCubit.storeOfferDetailsEntity!.data!.products![index].images!,
                                              imagesCount: homeCubit.storeOfferDetailsEntity!.data!.products![index].images!.length,
                                              category: homeCubit.storeOfferDetailsEntity!.data!.products![index].getCategory!.name!,
                                              name: homeCubit.storeOfferDetailsEntity!.data!.products![index].name!,
                                              newPrice: homeCubit.storeOfferDetailsEntity!.data!.products![index].basicPrice!,
                                              rate: homeCubit.storeOfferDetailsEntity!.data!.products![index].rate!,
                                              ratingCount: homeCubit.storeOfferDetailsEntity!.data!.products![index].ratings!.length,
                                              onProductTap:() {
                                                navigateTo(context, ShowProductDetails(
                                                  productID: homeCubit.storeOfferDetailsEntity!.data!.products![index].id!,
                                                  isBuyGetOffer: homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 2 ? true : null,
                                                )
                                                );
                                              },
                                              isFavourite: homeCubit.storeOfferDetailsEntity!.data!.products![index].favorites!.isNotEmpty ? true : false,
                                              onFavoriteTap: () {
                                                homeCubit.addFavourite(
                                                  itemType: 'product',
                                                  itemID: homeCubit.storeOfferDetailsEntity!.data!.products![index].id!,
                                                );
                                                homeCubit.storeOfferDetails(offerID: widget.offerId);
                                              },
                                              offer: homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 1 ? '-${homeCubit.storeOfferDetailsEntity!.data!.offer!.value} %':null,
                                              offerType: homeCubit.storeOfferDetailsEntity!.data!.offer!.type,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  verticalSpace(2.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if(homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 2 && homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount! + homeCubit.storeOfferDetailsEntity!.data!.offer!.getAmount! - homeCubit.productsOfferList.length != 0)
                    SizedBox(
                        width: 100.w,
                        height: 40.h,
                        child: AnimationLimiter(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount! + homeCubit.storeOfferDetailsEntity!.data!.offer!.getAmount! - homeCubit.productsOfferList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      columnCount: 2,
                                      position: index,
                                      duration: const Duration(milliseconds: 1000),
                                      child: ScaleAnimation(
                                        duration: const Duration(milliseconds: 1000),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        scale: 1.5,
                                        child: FadeInAnimation(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                                            child: CardLoading(
                                              height: 40.h,
                                              borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
                                              width: 50.w,
                                              margin: EdgeInsets.only(bottom: 10.rSp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              verticalSpace(2.h),
                            ],
                          ),
                        ),
                      ),
                   if(homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 2 && homeCubit.productsOfferList.isNotEmpty)
                    SizedBox(
                       width: 100.w,
                       height: 30.h,
                       child: AnimationLimiter(
                         child: Column(
                           children: [
                             Expanded(
                               child: ListView.builder(
                                 scrollDirection: Axis.horizontal,
                                 itemCount: homeCubit.productsOfferList.length,
                                 itemBuilder: (BuildContext context, int index) {
                                   return AnimationConfiguration.staggeredList(
                                     position: index,
                                     duration: const Duration(milliseconds: 1000),
                                     child: ScaleAnimation(
                                       duration: const Duration(milliseconds: 1000),
                                       curve: Curves.fastLinearToSlowEaseIn,
                                       scale: 1.5,
                                       child: FadeInAnimation(
                                         child: Padding(
                                           padding: EdgeInsets.symmetric(horizontal: 2.w),
                                           child: Container(
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.all(Radius.circular(10.rSp)
                                                 ),
                                                 border: Border.all(
                                                   width: 1.rSp,
                                                   color: ColorsManager.black,
                                                 )
                                             ),
                                             child: Stack(
                                               children: [
                                                 Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     Stack(
                                                       children: [
                                                         SizedBox(
                                                           height: 18.h,
                                                           width: 50.w,
                                                           child: CachedNetworkImage(
                                                             imageUrl: homeCubit.productsOfferList[index]['image'],
                                                             imageBuilder: (context, imageProvider) => Container(
                                                               decoration: BoxDecoration(
                                                                 image: DecorationImage(
                                                                     image: imageProvider, fit: BoxFit.contain),
                                                                 borderRadius: BorderRadius.only(
                                                                     topLeft: Radius.circular(20.rSp),
                                                                     topRight: Radius.circular(20.rSp)),
                                                               ),
                                                             ),
                                                             errorWidget: (context, url, error) => Container(
                                                                 decoration: BoxDecoration(
                                                                   borderRadius: BorderRadius.only(
                                                                       topLeft: Radius.circular(20.rSp),
                                                                       topRight: Radius.circular(20.rSp)),
                                                                 ),
                                                                 child:svgImage(path: Assets.images.svg.noImage)
                                                             ),
                                                             placeholder: (context, url) => Container(
                                                               color: Colors.black.withOpacity(0.5),
                                                             ),
                                                             fit: BoxFit.contain,
                                                           ),
                                                         ),
                                                         Positioned(
                                                             top: 0,
                                                             right: 3,
                                                             child:
                                                             DefaultIconButton(
                                                                 icon: const Icon(Icons.delete_forever,color: ColorsManager.error,),
                                                                 onPressed: (){
                                                                   homeCubit.productsOfferList.remove(homeCubit.productsOfferList[index]);
                                                                   homeCubit.toggleRoleSelection();
                                                                 }
                                                             )
                                                         ),
                                                       ],
                                                     ),
                                                     verticalSpace(1.h),
                                                     Padding(
                                                       padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                       child: Column(
                                                         mainAxisAlignment: MainAxisAlignment.start,
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         children: [
                                                           DefaultText(
                                                             title: homeCubit.productsOfferList[index]['product_slug'],
                                                             fontSize: 10.rSp,
                                                             fontWeight: FontWeight.w700,
                                                             color: ColorsManager.black,
                                                             style: Style.medium ,
                                                           ),
                                                           verticalSpace(2.h),
                                                           //if(index > homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount)
                                                           Row(
                                                             children: [
                                                               if(index+1 > homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount)
                                                              DefaultText(
                                                                   title: '0.00 ${appBloc.translationModel!.currency}',
                                                                   fontSize: 10.rSp,
                                                                   fontWeight: FontWeight.w700,
                                                                   color: ColorsManager.mainColor,
                                                                   style: Style.medium,
                                                              ),
                                                               if(index+1 > homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount)
                                                                 horizontalSpace(2.w),
                                                               DefaultText(
                                                                 title: homeCubit.productsOfferList[index]['price'].toString() + appBloc.translationModel!.currency,
                                                                 fontSize: 10.rSp,
                                                                 fontWeight: FontWeight.w700,
                                                                 color: ColorsManager.black,
                                                                 style: Style.medium,
                                                                 decoration:
                                                                 index+1 > homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount?
                                                                 TextDecoration.lineThrough : TextDecoration.none,
                                                               ),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                   );
                                 },
                               ),
                             ),
                             verticalSpace(2.h),
                           ],
                         ),
                       ),
                     ),
                    if(homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 2)
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

                                if(homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount! + homeCubit.storeOfferDetailsEntity!.data!.offer!.getAmount! - homeCubit.productsOfferList.length == 0){
                                  for(int i = 0; i < homeCubit.productsOfferList.length; i++){
                                    homeCubit.productsOfferList[i].remove('price');
                                    homeCubit.productsOfferList[i].remove('old_price');
                                    homeCubit.productsOfferList[i].remove('isGet');
                                    if(i+1 == homeCubit.productsOfferList.length){
                                      homeCubit.addOfferToCart(
                                          offerProducts: homeCubit.productsOfferList,
                                          qty: homeCubit.addToCartCount,
                                          offerSlug: homeCubit.storeOfferDetailsEntity!.data!.offer!.slug!
                                      );
                                    }
                                  }
                                }else{
                                  designToastDialog(
                                      context: context,
                                      toast: TOAST.warning,
                                      text: appBloc.translationModel!.completeOffer
                                  );
                                }
                              },
                              icon: const Icon(Icons.add_shopping_cart,color: ColorsManager.mainColor,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(2.h),
                  ],
                ),
              ),
          );
        },
      ),
    );
  }
}
