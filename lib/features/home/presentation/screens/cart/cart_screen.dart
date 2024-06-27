import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/core/util/widgets/default_text_field.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/screens/cart/checkout_screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/loading_files/all_product_loading.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../../../../core/util/widgets/progress.dart';
import '../../controller/state.dart';
import 'cart_offer_card.dart';
import 'cart_product_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.cart();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {

      if (state is UpdateCartProductSuccessState && state.updateCartProductEntity.success == 1) {
        Navigator.pop(context);
        homeCubit.cart();
        designToastDialog(
            context: context,
            toast: TOAST.success,
            text: state.updateCartProductEntity.message!);
      }

      if (state is UpdateCartProductSuccessState && state.updateCartProductEntity.success ==0) {
        Navigator.pop(context);
        designToastDialog(
            context: context,
            toast: TOAST.error,
            text: state.updateCartProductEntity.message!);
      }

      if (state is UpdateCartProductErrorState) {
        Navigator.pop(context);
        designToastDialog(
            context: context,
            toast: TOAST.error,
            text: state.failure.toString());
      }

      if(state is UpdateCartProductLoadingState) {
        showDialog(
          context: context,
          builder: (context) {
            return ProgressDialog(message: appBloc.translationModel!.loading);
          },
        );
      }



      if (state is DeleteCartItemSuccessState && state.deleteCartItemEntity.success == 1) {
        Navigator.pop(context);
        homeCubit.cart();
        designToastDialog(
            context: context,
            toast: TOAST.success,
            text: state.deleteCartItemEntity.message!);
      }

      if (state is DeleteCartItemSuccessState && state.deleteCartItemEntity.success ==0) {
        Navigator.pop(context);
        designToastDialog(
            context: context,
            toast: TOAST.error,
            text: state.deleteCartItemEntity.message!);
      }

      if (state is DeleteCartItemErrorState) {
        Navigator.pop(context);
        designToastDialog(
            context: context,
            toast: TOAST.error,
            text: state.failure.toString());
      }

      if(state is DeleteCartItemLoadingState) {
        showDialog(
          context: context,
          builder: (context) {
            return ProgressDialog(message: appBloc.translationModel!.loading);
          },
        );
      }




      if (state is UpdateCartOfferSuccessState && state.updateCartOfferEntity.success == 1) {
        Navigator.pop(context);
        homeCubit.cart();
        designToastDialog(
            context: context,
            toast: TOAST.success,
            text: state.updateCartOfferEntity.message!);
      }

      if (state is UpdateCartOfferSuccessState && state.updateCartOfferEntity.success ==0) {
        Navigator.pop(context);
        designToastDialog(
            context: context,
            toast: TOAST.error,
            text: state.updateCartOfferEntity.message!);
      }

      if (state is UpdateCartOfferErrorState) {
        Navigator.pop(context);
        designToastDialog(
            context: context,
            toast: TOAST.error,
            text: state.failure.toString());
      }

      if(state is UpdateCartOfferLoadingState) {
        showDialog(
          context: context,
          builder: (context) {
            return ProgressDialog(message: appBloc.translationModel!.loading);
          },
        );
      }







        },
        builder: (context, state) {
          return HideKeyboardPage(
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      verticalSpace(1.h),
                      if(homeCubit.cartEntity != null && homeCubit.cartEntity!.data.shopsCart.isEmpty)
                        Center(
                          child: DefaultText(
                              title: appBloc.translationModel!.noData,
                              style: Style.headLarge
                          ),
                        ),
                      if(homeCubit.cartEntity == null)
                        const AllProductsLoading(),
                      if(homeCubit.cartEntity != null)
                        RefreshIndicator(
                          onRefresh: () async{
                            homeCubit.cart();
                            await Future.delayed(const Duration(seconds: 2));
                          },
                          backgroundColor: Colors.transparent,
                          child: AnimationLimiter(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80.h,
                                  child: SingleChildScrollView(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: homeCubit.cartEntity!.data.shopsCart.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              var val = homeCubit.cartEntity!.data.shopsCart[homeCubit.keys[index]];

                                              for (var element in val!.shop.categories) {
                                                homeCubit.categoriesList.add(element.name);
                                              }
                                              homeCubit.categoriesCart = [
                                                for (var data in (homeCubit.categoriesList)) data
                                              ].join(",");
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 1, vertical: 3),
                                                child: ExpansionTileCard(
                                                  baseColor: ColorsManager.lightGrey,
                                                  expandedColor: ColorsManager.whiteColor,
                                                  initiallyExpanded: true,
                                                  //key: cardA,
                                                  leading: SizedBox(
                                                      width: 15.w,
                                                      height: 10.h,
                                                      child: CachedNetworkImage(
                                                        imageUrl: val.shop.logoPath ?? '',
                                                        imageBuilder: (context, imageProvider) => Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        errorWidget: (context, url, error) => Container(
                                                            height: MediaQuery.of(context).size.height / 4,
                                                            width: double.infinity,
                                                            decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                            ),
                                                            child: svgImage(path: Assets.images.svg.noImage)
                                                        ),
                                                        placeholder: (context, url) => Container(
                                                          color: Colors.black.withOpacity(0.5),
                                                        ),
                                                        fit: BoxFit.fill,
                                                        memCacheHeight: 300,
                                                        memCacheWidth: 300,
                                                      )
                                                  ),
                                                  title: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      DefaultText(
                                                          title: val.shop.categories[0].name ?? '', //categories
                                                          fontSize: 10.rSp,
                                                          fontWeight: FontWeight.normal,
                                                          color: ColorsManager.mainColor.withOpacity(0.7),
                                                          maxLines: 2,
                                                          style: Style.small
                                                      ),
                                                      verticalSpace(1.h),
                                                      DefaultText(
                                                          title: val.shop.shopName ?? '',
                                                          fontSize: 16.rSp,
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorsManager.mainColor,
                                                          maxLines: 2,
                                                          style: Style.small,
                                                      ),
                                                      verticalSpace(1.h),
                                                      RatingBar(
                                                        initialRating: double.parse(val.shop.rate ?? ''),
                                                        minRating: 1,
                                                        direction: Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize: 10.rSp,
                                                        ignoreGestures: true,
                                                        itemPadding: EdgeInsets.symmetric(horizontal: 2.rSp),
                                                        ratingWidget: RatingWidget(
                                                          full: Image.asset(Assets.images.png.star),
                                                          half: Image.asset(Assets.images.png.starHalf),
                                                          empty: Image.asset(Assets.images.png.starBorder),
                                                        ),
                                                        onRatingUpdate: (rating) {
                                                        },
                                                      ),
                                                      verticalSpace(1.h),
                                                      DefaultText(
                                                          title: '${appBloc.translationModel!.totalAfterDiscount} : ${val.storeTotalAfterDiscount} ${appBloc.translationModel!.currency}',
                                                          fontSize: 10.rSp,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: ColorsManager.darkGrey,
                                                          maxLines: 2,
                                                          style: Style.small,
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Container(),
                                                  children: <Widget>[
                                                    Divider(
                                                      thickness: 1.0.rSp,
                                                      height: 1.0.rSp,
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 5.rSp,
                                                            vertical: 10.rSp,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              // CartStateView(),
                                                              val.products.isNotEmpty
                                                                  ? ListView.builder(
                                                                scrollDirection:
                                                                Axis.vertical,
                                                                itemBuilder:
                                                                    (context,
                                                                    index) {
                                                                  return CartProductCard(
                                                                    proImage: val.products[index].imagePath ?? '',
                                                                    proName: val.products[index].name ?? '',
                                                                    proFeat1Name: (val.products[index].pType == 'special'? '${val.products[index].pf1} : ' : ''),
                                                                    proFeat1Value: (val.products[index].pType == 'special' ? val.products[index].f1 : '') ?? '',
                                                                    proFeat2Name: (val.products[index].pType == 'special' ? '${val.products[index].pf2} : ' : ''),
                                                                    proFeat2Value: (val.products[index].pType == 'special' ? val.products[index].f2 : '') ?? '',
                                                                    proPrice: val.products[index].price ?? '',
                                                                    proCount:
                                                                    homeCubit.eventProductData == null || state is UpdateCartProductLoadingState
                                                                        ? (val.products[index].qty ?? 0).toString()
                                                                        : homeCubit.eventProductData['item']['id'] == val.products[index].id
                                                                        ? homeCubit.eventProductData['item']['qty'].toString()
                                                                        : (val.products[index].qty ?? 0).toString(),
                                                                    addOnTap: state
                                                                    is UpdateCartProductLoadingState
                                                                        ? () {}
                                                                        : () {
                                                                      homeCubit.updateCartProduct(
                                                                          shop: val.products[index].shop ?? 0,
                                                                          item: val.products[index].id ?? 0,
                                                                          f1: (val.products[index].pType == 'special' ? val.products[index].f1Id : null),
                                                                          f2: (val.products[index].pType == 'special' ? val.products[index].f2Id : null),
                                                                          qty: homeCubit.eventProductData != null && homeCubit.eventProductData['item']['id'] == val.products[index].id ? int.parse(homeCubit.eventProductData['item']['qty'].toString()) + 1 : int.parse(val.products[index].qty!.toString()) + 1,
                                                                          action: 'plus');
                                                                    },
                                                                    subOnTap: state
                                                                    is UpdateCartProductLoadingState
                                                                        ? () {}
                                                                        : () {
                                                                      homeCubit.updateCartProduct(
                                                                          shop: val.products[index].shop ?? 0,
                                                                          item: val.products[index].id ?? 0,
                                                                          f1: (val.products[index].pType == 'special' ? val.products[index].f1Id : null),
                                                                          f2: (val.products[index].pType == 'special' ? val.products[index].f2Id : null),
                                                                          qty: homeCubit.eventProductData != null && homeCubit.eventProductData['item']['id'] == val.products[index].id ? homeCubit.eventProductData['item']['qty'] - 1 : val.products[index].qty! - 1,
                                                                          action: 'minus');
                                                                    },
                                                                    deleteOnTap:
                                                                        () {
                                                                          homeCubit.deleteCartItem(
                                                                          type:
                                                                          'products',
                                                                          shop: val.products[index].shop ?? 0,
                                                                          item: val.products[index].id ?? 0);
                                                                    },
                                                                  );
                                                                },
                                                                itemCount: val
                                                                    .products
                                                                    .length,
                                                                shrinkWrap: true,
                                                                physics:
                                                                const BouncingScrollPhysics(),
                                                              )
                                                                  : Container(),
                                                              verticalSpace(2.h),
                                                              if(val.offers!.isNotEmpty)
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 1.rSp,
                                                                  color: ColorsManager.darkGrey.withOpacity(0.3),
                                                                ),
                                                              verticalSpace(2.h),
                                                              if(val.offers!.isNotEmpty)
                                                                ListView.builder(
                                                                  scrollDirection:
                                                                  Axis.vertical,
                                                                  itemBuilder:
                                                                      (context,
                                                                      index) {
                                                                    return CartOfferCard(
                                                                      totalPrice: val.storeTotalAfterDiscount!,
                                                                      offerProductsWidget: ExpansionTile(
                                                                        title: DefaultText(
                                                                            title: '${appBloc.translationModel!.products} ${appBloc.translationModel!.offers}',
                                                                            fontSize: 12.rSp,
                                                                            style: Style.small,
                                                                            fontWeight: FontWeight.bold,
                                                                        ),
                                                                        initiallyExpanded: true,
                                                                        children: [
                                                                          ListView.builder(
                                                                              shrinkWrap: true,
                                                                              physics: const NeverScrollableScrollPhysics(),
                                                                              scrollDirection: Axis.vertical,
                                                                              itemCount: val.offers![index].products.length,
                                                                              itemBuilder:
                                                                                  (BuildContext context, int subIndex) {
                                                                                return Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          DefaultText(
                                                                                              title: val.offers![index].products[subIndex].price != '0.00'? '${appBloc.translationModel!.buy} ${appBloc.translationModel!.products}' : '${appBloc.translationModel!.get} ${appBloc.translationModel!.free} ${appBloc.translationModel!.products}',
                                                                                              fontSize: 14.rSp,
                                                                                              style: Style.small,
                                                                                              fontWeight: FontWeight.bold
                                                                                          ),
                                                                                          const Spacer(),
                                                                                          DefaultText(
                                                                                              title: val.offers![index].products[subIndex].qty.toString(),
                                                                                              fontSize: 14.rSp,
                                                                                              style: Style.small
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Card(
                                                                                      elevation: 2,
                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.rSp)),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.all(10.rSp),
                                                                                        child: Row(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Padding(
                                                                                                padding: EdgeInsets.only(left: 5.rSp, top: 5.rSp, bottom: 5.rSp),
                                                                                                child: CachedNetworkImage(
                                                                                                  imageUrl: val.offers![index].products[subIndex].imagePath ?? '',
                                                                                                  imageBuilder: (context, imageProvider) => Container(
                                                                                                    height: MediaQuery.of(context).size.height / 12,
                                                                                                    width: MediaQuery.of(context).size.width / 6,
                                                                                                    decoration: BoxDecoration(
                                                                                                      borderRadius: BorderRadius.only(
                                                                                                        topRight: Radius.circular(20.rSp),
                                                                                                        bottomLeft: Radius.circular(20.rSp),
                                                                                                        bottomRight: Radius.circular(20.rSp),
                                                                                                      ),
                                                                                                      image: DecorationImage(
                                                                                                          image: CachedNetworkImageProvider(val.offers![index].products[subIndex].imagePath ?? ''),
                                                                                                          fit: BoxFit.fill),
                                                                                                    ),
                                                                                                  ),
                                                                                                  errorWidget: (context, url, error) => Container(
                                                                                                      height: MediaQuery.of(context).size.height / 12,
                                                                                                      width: MediaQuery.of(context).size.width / 6,
                                                                                                      decoration: const BoxDecoration(
                                                                                                        borderRadius: BorderRadius.only(
                                                                                                            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                                      ),
                                                                                                      child: svgImage(path: Assets.images.svg.noImage)
                                                                                                    // Image.asset(
                                                                                                    //   'assets/images/cover.png',
                                                                                                    //   fit: BoxFit.fill,
                                                                                                    // ),
                                                                                                  ),
                                                                                                  placeholder: (context, url) => Container(
                                                                                                    color: Colors.black.withOpacity(0.5),
                                                                                                  ),
                                                                                                  fit: BoxFit.fill,
                                                                                                  memCacheHeight: 300,
                                                                                                  memCacheWidth: 300,
                                                                                                )

                                                                                              // Container(
                                                                                              //   height: MediaQuery.of(context).size.height / 12,
                                                                                              //   width: MediaQuery.of(context).size.width / 6,
                                                                                              //   decoration: BoxDecoration(
                                                                                              //     borderRadius: BorderRadius.circular(15.rSp),
                                                                                              //     image: DecorationImage(
                                                                                              //       image: CachedNetworkImageProvider(val.offers![index].products[subIndex].image ?? ''),
                                                                                              //       fit: BoxFit.cover,
                                                                                              //     ),
                                                                                              //   ),
                                                                                              // ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Padding(
                                                                                                padding: EdgeInsets.only(left: 10.rSp, top: 10.rSp, bottom: 10.rSp),
                                                                                                child: Column(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    DefaultText(
                                                                                                        title: val.offers![index].products[subIndex].name ?? '',
                                                                                                        fontSize: 12,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        color: ColorsManager.mainColor,
                                                                                                        style: Style.small,
                                                                                                    ),
                                                                                                    verticalSpace(1.h),
                                                                                                    DefaultText(
                                                                                                        title: '${val.offers![index].products[subIndex].price} ${appBloc.translationModel!.currency}',
                                                                                                        fontSize: 14,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        color: ColorsManager.mainColor,
                                                                                                        style: Style.small,
                                                                                                    ),
                                                                                                    verticalSpace(1.h),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              }),


                                                                        ],
                                                                      ),
                                                                      offerBanner: val.offers![index].bannerPath ?? '',
                                                                      offerName: val.offers![index].name ?? '',
                                                                      offerPrice: val.offers![index].price ?? '',
                                                                      offerCount: homeCubit.eventOfferData == null || state is UpdateCartOfferLoadingState
                                                                          ? (val.offers![index].qty ??
                                                                          0)
                                                                          .toString()
                                                                          : homeCubit.eventOfferData['item']['id'] ==
                                                                          val.offers![index].id
                                                                          ? homeCubit.eventOfferData['item']['qty'].toString()
                                                                          : (val.offers![index].qty ?? 0).toString(),
                                                                      addOnTap: state is UpdateCartOfferLoadingState
                                                                          ? () {}
                                                                          : () {
                                                                        homeCubit.updateCartOffer(
                                                                            shop: val.offers![index].shop ?? 0,
                                                                            item: val.offers![index].id ?? 0,
                                                                            qty: homeCubit.eventOfferData != null && homeCubit.eventOfferData['item']['id'] == val.offers![index].id ? homeCubit.eventOfferData['item']['qty'] + 1 : val.offers![index].qty! + 1,
                                                                            action: 'plus');
                                                                      },
                                                                      subOnTap: state
                                                                      is UpdateCartOfferLoadingState
                                                                          ? () {}
                                                                          : () {
                                                                        homeCubit.updateCartOffer(
                                                                            shop: val.offers![index].shop ?? 0,
                                                                            item: val.offers![index].id ?? 0,
                                                                            qty: homeCubit.eventOfferData != null && homeCubit.eventOfferData['item']['id'] == val.offers![index].id ? homeCubit.eventOfferData['item']['qty'] - 1 : val.offers![index].qty! - 1,
                                                                            action: 'minus');
                                                                      },
                                                                      deleteOnTap:
                                                                          () {
                                                                            homeCubit.deleteCartItem(
                                                                            type: 'offers',
                                                                            shop: val.offers![index].shop ?? 0,
                                                                            item: val.offers![index].id ?? 0
                                                                            );
                                                                      },
                                                                    );
                                                                  },
                                                                  itemCount: val
                                                                      .offers!
                                                                      .length,
                                                                  shrinkWrap: true,
                                                                  physics:
                                                                  const BouncingScrollPhysics(),
                                                                )

                                                            ],
                                                          )),
                                                    ),

                                                    Divider(
                                                      thickness: 1.0.rSp,
                                                      height: 1.0.rSp,
                                                    ),
                                                    verticalSpace(3.h),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 10.rSp),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal: 10.rSp
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: DefaultTextField(
                                                                      controller: homeCubit.promoController[index],
                                                                      type: TextInputType.text,
                                                                      validate: (dynamic value) {
                                                                        if (value.isEmpty) {
                                                                          return appBloc.translationModel!.requiredField;
                                                                        }
                                                                        return null;
                                                                      },
                                                                      hint: appBloc.translationModel!.promoCode,
                                                                    ),
                                                                  ),
                                                                  horizontalSpace(2.w),
                                                                  DefaultButton(
                                                                      text: appBloc.translationModel!.submit,
                                                                      onPressed: () {
                                                                        homeCubit.promoCode(
                                                                            shop: val.shop.id ?? 0,
                                                                            promo: homeCubit.promoController[index].text, minAmount: val.price ?? '');
                                                                        if (homeCubit.promoCodeEntity != null && homeCubit.promoCodeEntity!.data.status != 'invalid') {
                                                                          if (homeCubit.storeTotals.containsKey(homeCubit.promoCodeEntity!.data.shop.toString())) {
                                                                            homeCubit.storeTotals[homeCubit.promoCodeEntity!.data.shop.toString()]
                                                                            ['total_without_shipping'] = homeCubit.promoCodeEntity!.data.totalWithoutShipping ?? '';
                                                                            homeCubit.storeTotals[homeCubit.promoCodeEntity!.data.shop.toString()]
                                                                            ['promo_amount'] = homeCubit.promoCodeEntity!.data.amount ?? '';
                                                                            homeCubit.storeTotals[homeCubit.promoCodeEntity!.data.shop.toString()]
                                                                            ['promo'] = homeCubit.promoController[index].text;
                                                                            homeCubit.totalStoresPrice = homeCubit.storeTotals.values.map((e) => e[
                                                                            'total_without_shipping']).where((value) => value != null).fold(0, (previousValue, element) => previousValue + double.parse(element));
                                                                          }
                                                                          final newList =
                                                                          homeCubit.storesPromo.map((e) {
                                                                            if (e.containsKey(homeCubit.promoCodeEntity!.data.shop)) {
                                                                              e[homeCubit.promoCodeEntity!.data.shop ?? 0] = homeCubit.storeTotals[homeCubit.promoCodeEntity!.data.shop.toString()]['promo'];
                                                                            }
                                                                            return e;
                                                                          }).toList();
                                                                          homeCubit.storesPromo =
                                                                              newList;

                                                                        } else {
                                                                          if (homeCubit.storeTotals.containsKey(homeCubit.promoCodeEntity!.data.shop.toString())) {homeCubit.storeTotals[homeCubit.promoCodeEntity!.data.shop.toString()]
                                                                          ['total_without_shipping'] = val.price ?? '';
                                                                          homeCubit.storeTotals[homeCubit.promoCodeEntity!.data.shop.toString()]
                                                                          ['promo_amount'] = '0.00';
                                                                          homeCubit.storeTotals[homeCubit.promoCodeEntity!.data.shop.toString()]
                                                                          ['promo'] = '';
                                                                          homeCubit.totalStoresPrice = homeCubit.storeTotals.values.map((e) => e['total_without_shipping']).where((value) => value != null).fold(0,
                                                                                  (previousValue, element) => previousValue + double.parse(element));
                                                                          final newList = homeCubit.storesPromo.map((e) {
                                                                            if (e.containsKey(homeCubit.promoCodeEntity!.data.shop)) {
                                                                              e[homeCubit.promoCodeEntity!.data.shop ?? 0] = homeCubit.storeTotals[homeCubit.promoCodeEntity!.data.shop.toString()]['promo'];
                                                                            }
                                                                            return e;
                                                                          }).toList();
                                                                          homeCubit.storesPromo =
                                                                              newList;

                                                                          }
                                                                        }
                                                                      },
                                                                      radius: 5.rSp,
                                                                      width: MediaQuery.of(context).size.width / 3.5,
                                                                      fontSize: 12.rSp,
                                                                  ),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    verticalSpace(1.h),
                                                  ],
                                                ),
                                              );
                                            }),
                                        verticalSpace(2.h),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorsManager.lightGrey,
                                                  width: 1.rSp
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(10.rSp))
                                          ),
                                          padding: EdgeInsets.all(10.rw),
                                          margin: EdgeInsets.all(10.rSp),
                                          child: Column(
                                            children: [
                                              verticalSpace(1.h),
                                              Row(
                                                children: [
                                                  DefaultText(
                                                      title: appBloc.translationModel!.total,
                                                      fontSize: 12.rSp,
                                                      style: Style.small,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                  const Spacer(),
                                                  DefaultText(
                                                      title: '${(homeCubit.eventOfferData == null && homeCubit.eventProductData == null) ? homeCubit.cartEntity!.data.storesSubtotal : homeCubit.eventOfferData == null ? homeCubit.eventProductData['stores_subtotal'] : homeCubit.eventOfferData['stores_subtotal']} ${appBloc.translationModel!.currency}',
                                                      fontSize: 12.rSp,
                                                      style: Style.small,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ],
                                              ),
                                              verticalSpace(1.h),
                                              Row(
                                                children: [
                                                  DefaultText(
                                                      title: appBloc.translationModel!.discountValue,
                                                      fontSize: 12.rSp,
                                                      style: Style.small,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                  const Spacer(),
                                                  DefaultText(
                                                      title: '${(homeCubit.eventOfferData == null && homeCubit.eventProductData == null) ? homeCubit.cartEntity!.data.storesDiscounts : homeCubit.eventOfferData == null ? homeCubit.eventProductData['stores_discounts'] : homeCubit.eventOfferData['stores_discounts']} ${appBloc.translationModel!.currency}',
                                                      fontSize: 12.rSp,
                                                      style: Style.small,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ],
                                              ),
                                              verticalSpace(1.h),
                                              Row(
                                                children: [
                                                  DefaultText(
                                                      title: appBloc.translationModel!.promoCode,
                                                      fontSize: 12.rSp,
                                                      style: Style.small,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                  const Spacer(),
                                                  DefaultText(
                                                      title: '${(homeCubit.eventOfferData == null && homeCubit.eventProductData == null) ? homeCubit.cartEntity!.data.storesPromoAmount : homeCubit.eventOfferData == null ? homeCubit.eventProductData['stores_promo_amount'] : homeCubit.eventOfferData['stores_promo_amount']} ${appBloc.translationModel!.currency}',
                                                      fontSize: 12.rSp,
                                                      style: Style.small,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ],
                                              ),
                                              verticalSpace(1.h),
                                              Row(
                                                children: [
                                                  DefaultText(
                                                      title: appBloc.translationModel!.total,
                                                      fontSize: 12.rSp,
                                                      style: Style.small,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                  const Spacer(),
                                                  DefaultText(
                                                      title: '${(homeCubit.eventOfferData == null && homeCubit.eventProductData == null) ? homeCubit.cartEntity!.data.totalCarts : homeCubit.eventOfferData == null ? homeCubit.eventProductData['total'] : homeCubit.eventOfferData['total']} ${appBloc.translationModel!.currency}',
                                                      fontSize: 12.rSp,
                                                      style: Style.small,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        verticalSpace(2.h),
                                        if(homeCubit.cartEntity!.data.shopsCart.isNotEmpty)
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                                          child: DefaultButton(
                                              text: appBloc.translationModel!.checkout,
                                              onPressed: () {
                                                navigateTo(context, const CheckoutScreen());
                                                homeCubit.inCart = false;
                                              },
                                              ),
                                        ),
                                        verticalSpace(2.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  )
              )
          );
        },
      ),
    );
  }
}
