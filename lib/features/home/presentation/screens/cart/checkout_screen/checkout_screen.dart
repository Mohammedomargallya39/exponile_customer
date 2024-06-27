import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:exponile_customer/core/util/loading_files/map_loading.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/cart/payment_screens/order_receipt_screen.dart';
import 'package:exponile_customer/features/home/presentation/screens/settings/add_new_address_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/cubit/cubit.dart';
import '../../../../../../core/util/widgets/default_text.dart';
import '../../../../../../core/util/widgets/progress.dart';
import '../../main_layout/main_layout.dart';
import 'checkout_offer_card.dart';
import 'checkout_product_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.checkOutView();
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
            if(homeCubit.eventData != null){
              homeCubit.checkOutView();
            }

            if(homeCubit.paymentMethod != null){
              setState(() {
                for(int i = 0; i < homeCubit.checkOutViewEntity!.data.customerPaymentMethods!.length ; i ++){
                  if(homeCubit.checkOutViewEntity!.data.customerPaymentMethods![i].id == homeCubit.paymentMethod){
                    homeCubit.paymentSelectedIndexes.clear();
                    homeCubit.paymentSelectedIndexes.add(homeCubit.checkOutViewEntity!.data.customerPaymentMethods![i].id);
                    homeCubit.selectedPaymentId = homeCubit.checkOutViewEntity!.data.customerPaymentMethods![i].id!;
                  }
                }
              });
            }

            if(homeCubit.deliveryMethod != null){
              setState(() {
                for(int i = 0; i < homeCubit.checkOutViewEntity!.data.addresses!.length ; i ++){
                  if(homeCubit.checkOutViewEntity!.data.addresses![i].id == homeCubit.deliveryMethod){
                    homeCubit.addressSelectedIndexes.clear();
                    homeCubit.addressSelectedIndexes.add(homeCubit.checkOutViewEntity!.data.addresses![i].id!);
                    homeCubit.selectedAddressCityId = homeCubit.checkOutViewEntity!.data.addresses![i].getGovernorate!.id ?? 0;
                    homeCubit.selectedAddressAreaId = homeCubit.checkOutViewEntity!.data.addresses![i].getArea!.id ?? 0;
                    homeCubit.selectedAddressId = homeCubit.checkOutViewEntity!.data.addresses![i].id ?? 0;
                  }
                }
              });
            }



            if (state is CheckoutSuccessState && state.checkoutEntity.success == 1) {
              Navigator.pop(context);
              if(homeCubit.checkoutEntity!.data.paymentRequest != null){
                navigateTo(context, PayScreen(checkout: true,checkOutModel: state.checkoutEntity,));
              }else{
                homeCubit.currentNavIndex = 0;
                navigateTo(context, const MainLayout());
              }
              designToastDialog(
                  context: context,
                  toast: TOAST.success,
                  text: state.checkoutEntity.message!);
            }

            if (state is CheckoutSuccessState && state.checkoutEntity.success ==0) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.checkoutEntity.message!);
            }

            if (state is CheckoutErrorState) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.failure.toString());
            }

            if(state is CheckoutLoadingState) {
              showDialog(
                context: context,
                builder: (context) {
                  return ProgressDialog(message: appBloc.translationModel!.loading);
                },
              );
            }


          },
          builder: (context, state) {
            return Scaffold(
              appBar: MainAppBar(
                  title: appBloc.translationModel!.checkout,
                  isBack: true,
                  isLang: false,
              ),
              body: homeCubit.checkOutViewEntity!= null ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList().length - 4,
                        itemBuilder: (BuildContext context, int index) {
                          return homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index] is String || homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index] is int || homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index] is double ?
                          Container()  : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.rSp, vertical: 3.rSp),
                              child: ExpansionTileCard(
                                  baseColor: ColorsManager.lightGrey,
                                  expandedColor: ColorsManager.white,
                                  initiallyExpanded: true,
                                  title: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 5.rSp, top: 5.rSp, bottom: 5.rSp),
                                          child: CachedNetworkImage(
                                            imageUrl: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index].warehouseMethod!['logo_path'] ?? '',
                                            imageBuilder: (context, imageProvider) => Container(
                                              height: MediaQuery.of(context).size.height / 12,
                                              width: MediaQuery.of(context).size.width / 8,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20.rSp),
                                                  bottomLeft: Radius.circular(20.rSp),
                                                  bottomRight: Radius.circular(20.rSp),
                                                ),
                                                image: DecorationImage(
                                                    image: CachedNetworkImageProvider(homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index].warehouseMethod!['logo_path'] ?? ''),
                                                    fit: BoxFit.fill),
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
                                      horizontalSpace(4.w),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.rSp, top: 10.rSp, bottom: 10.rSp),
                                        child: DefaultText(
                                            title: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index].warehouseMethod!['name'] ?? '',
                                            fontSize: 20.rSp,
                                            fontWeight: FontWeight.bold,
                                            color: ColorsManager.mainColor,
                                            style: Style.small,
                                        ),
                                      )
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
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.rSp,
                                            vertical: 10.rSp,
                                          ),
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products!.isNotEmpty
                                                    ? ListView.builder(
                                                  scrollDirection:
                                                  Axis.vertical,
                                                  itemBuilder: (context, productIndex) {
                                                    homeCubit.validationProducts[homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].pId] = homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].name;
                                                    return CheckOutProductCard(
                                                      proImage: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].imagePath ?? '',
                                                      proName: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].name ?? '',
                                                      proFeat1Name: (homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].pType == 'special' ? '${homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].pf1} : ' : ''),
                                                      proFeat1Value: (homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].pType == 'special' ? homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].f1 : '') ?? '',
                                                      proFeat2Name: (homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].pType == 'special' ? '${homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].pf2} : ' : ''),
                                                      proFeat2Value: (homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].pType == 'special' ? homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].f2 : '') ?? '',
                                                      proPrice: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].price ?? '',
                                                      proCount: homeCubit.eventProductData == null ? (homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].qty).toString()
                                                          : homeCubit.eventProductData['item']['id'] == homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].id
                                                          ? homeCubit.eventProductData['item']['qty'].toString()
                                                          : (homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products![productIndex].qty ?? 0).toString(),
                                                    );
                                                  },
                                                  itemCount: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.products!.length,
                                                  shrinkWrap: true,
                                                  physics:
                                                  const BouncingScrollPhysics(),
                                                )
                                                    : Container(),
                                                verticalSpace(2.h),
                                                homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers != null && homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers!.isNotEmpty
                                                    ? ListView.builder(
                                                  scrollDirection:
                                                  Axis.vertical,
                                                  itemBuilder: (context, offerIndex) {
                                                    return CheckOutOfferCard(
                                                      offerProductsWidget: ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          scrollDirection: Axis.vertical,
                                                          itemCount: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers![offerIndex].products.length,
                                                          itemBuilder: (BuildContext context, int subIndex) {
                                                            homeCubit.validationProductsOffers[homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers![offerIndex].products[subIndex].oId] = homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers![offerIndex].products[subIndex].name;
                                                            return Card(
                                                              elevation: 2,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.rSp)),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                      padding: EdgeInsets.only(left: 5.rSp, top: 5.rSp, bottom: 5.rSp),
                                                                      child: CachedNetworkImage(
                                                                        imageUrl: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers![offerIndex].products[subIndex].imagePath,
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
                                                                                image: CachedNetworkImageProvider(homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers![offerIndex].products[subIndex].imagePath),
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
                                                                  ),
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.only(left: 10.rSp, top: 10.rSp, bottom: 10.rSp),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          DefaultText(
                                                                              title: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers![offerIndex].products[subIndex].name ?? '',
                                                                              fontSize: 12.rSp,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: ColorsManager.mainColor,
                                                                              style: Style.small,
                                                                          ),
                                                                          verticalSpace(2.h),
                                                                          DefaultText(
                                                                              title: '${homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers![offerIndex].products[subIndex].price} ${appBloc.translationModel!.currency}',
                                                                              fontSize: 14.rSp,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: ColorsManager.mainColor,
                                                                              style: Style.small,
                                                                          ),
                                                                          verticalSpace(2.h),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                      offerBanner: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers![offerIndex].bannerPath ?? '',
                                                      offerName: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers![offerIndex].name ?? '',
                                                      offerPrice: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers![offerIndex].price ?? '',
                                                      offerCount: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers![offerIndex].qty.toString(),
                                                    );
                                                  },
                                                  itemCount: homeCubit.checkOutViewEntity!.data.shopsCart!.values.toList()[index]!.offers!.length,
                                                  shrinkWrap: true,
                                                  physics: const BouncingScrollPhysics(),
                                                )
                                                    : Container(),
                                              ]),
                                        ))
                                  ])) ;
                        }),
                    ExpansionTile(
                      title: DefaultText(
                        title: appBloc.translationModel!.location,
                        fontSize: 14.rSp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.mainColor,
                        style: Style.small,
                      ),
                      initiallyExpanded: true,
                      children: [
                        homeCubit.checkOutViewEntity!.data.addresses!.isNotEmpty?
                        SizedBox(
                          height: 20.h, // Adjust the height based on your needs
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: homeCubit.checkOutViewEntity!.data.addresses!.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: EdgeInsets.all(10.rSp),
                                child: GestureDetector(
                                  onTap: () {
                                    homeCubit.addressSelectedIndexes.clear();
                                    homeCubit.addressSelectedIndexes.add(homeCubit.checkOutViewEntity!.data.addresses![index].id!);
                                    homeCubit.selectedAddressCityId = homeCubit.checkOutViewEntity!.data.addresses![index].getGovernorate!.id ?? 0;
                                    homeCubit.selectedAddressAreaId = homeCubit.checkOutViewEntity!.data.addresses![index].getArea!.id ?? 0;
                                    homeCubit.selectedAddressId = homeCubit.checkOutViewEntity!.data.addresses![index].id ?? 0;
                                    homeCubit.getShippingAddressFees(
                                        city: homeCubit.checkOutViewEntity!.data.addresses![index].getGovernorate!.id ?? 0,
                                        addressID: homeCubit.checkOutViewEntity!.data.addresses![index].id ?? 0,
                                        context: context
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width/2,
                                            padding: EdgeInsets.all(5.rSp),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: ColorsManager.lightGrey,
                                                  width: 1.rSp,
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                                                color: homeCubit.addressSelectedIndexes.contains(homeCubit.checkOutViewEntity!.data.addresses![index].id) ?
                                                ColorsManager.success.withOpacity(0.3) : ColorsManager.lightGrey.withOpacity(0.1)
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    DefaultText(
                                                        title: '${appBloc.translationModel!.city} ',
                                                        fontSize: 12.rSp,
                                                        fontWeight: FontWeight.bold,
                                                        color: ColorsManager.mainColor,
                                                        style: Style.small,
                                                    ),
                                                    Expanded(
                                                      child: DefaultText(
                                                          title: '${homeCubit.checkOutViewEntity!.data.addresses![index].getGovernorate!.name}',
                                                          fontSize: 12.rSp,
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorsManager.mainColor,
                                                          style: Style.small,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                verticalSpace(1.h),
                                                Row(
                                                  children: [
                                                    DefaultText(
                                                        title: '${appBloc.translationModel!.areaName} ',
                                                        fontSize: 12.rSp,
                                                        fontWeight: FontWeight.bold,
                                                        color: ColorsManager.mainColor,
                                                        style: Style.small,
                                                    ),
                                                    Expanded(
                                                      child: DefaultText(
                                                          title: '${homeCubit.checkOutViewEntity!.data.addresses![index].getArea!.name}',
                                                          fontSize: 12.rSp,
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorsManager.mainColor,
                                                          style: Style.small,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                verticalSpace(1.h),
                                                Row(
                                                  children: [
                                                    DefaultText(
                                                        title: '${appBloc.translationModel!.streetName} ',
                                                        fontSize: 12.rSp,
                                                        fontWeight: FontWeight.bold,
                                                        color: ColorsManager.mainColor,
                                                        style: Style.small,
                                                    ),
                                                    Expanded(
                                                      child: DefaultText(
                                                          title: '${homeCubit.checkOutViewEntity!.data.addresses![index].streetName}',
                                                          fontSize: 12.rSp,
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorsManager.mainColor,
                                                          style: Style.small,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                verticalSpace(1.h),
                                                Row(
                                                  children: [
                                                    DefaultText(
                                                        title: '${appBloc.translationModel!.buildingName} ',
                                                        fontSize: 12.rSp,
                                                        fontWeight: FontWeight.bold,
                                                        color: ColorsManager.mainColor,
                                                        style: Style.small,
                                                    ),
                                                    Expanded(
                                                      child: DefaultText(
                                                          title: '${homeCubit.checkOutViewEntity!.data.addresses![index].buildingName}',
                                                          fontSize: 12.rSp,
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorsManager.mainColor,
                                                          style: Style.small,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                          if(homeCubit.addressSelectedIndexes.contains(homeCubit.checkOutViewEntity!.data.addresses![index].id))
                                            Positioned(
                                                top: 0,
                                                right: 1.w,
                                                child: const Icon(Icons.check)
                                            )
                                        ],
                                      ),
                                      if(index == homeCubit.checkOutViewEntity!.data.addresses!.length -1)
                                        horizontalSpace(6.w),
                                      if(index == homeCubit.checkOutViewEntity!.data.addresses!.length -1)

                                        IconButton(
                                          color: ColorsManager.mainColor,
                                          icon: Icon(
                                              Icons.add_circle_outline,
                                              size: 30.rSp
                                          ),
                                          onPressed: () {
                                            navigateTo(context, const AddNewAddressScreen());
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ): Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: IconButton(
                            color: ColorsManager.mainColor,
                            icon: Icon(
                                Icons.add_circle_outline,
                                size: 30.rSp
                            ),
                            onPressed: () {
                              navigateTo(context, const AddNewAddressScreen());
                            },),
                        ),

                      ],
                    ),
                    ExpansionTile(
                      title: DefaultText(
                        title: appBloc.translationModel!.paymentMethod,
                        fontSize: 14.rSp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.mainColor,
                        style: Style.small,
                      ),
                      initiallyExpanded: true,
                      children: [
                        SizedBox(
                          height: 20.h, // Adjust the height based on your needs
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: homeCubit.checkOutViewEntity!.data.customerPaymentMethods!.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: EdgeInsets.all(10.rSp),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (homeCubit.paymentSelectedIndexes.isNotEmpty) {
                                        homeCubit.paymentSelectedIndexes.clear();
                                        homeCubit.paymentSelectedIndexes.add(homeCubit.checkOutViewEntity!.data.customerPaymentMethods![index].id);
                                        homeCubit.selectedPaymentId = homeCubit.checkOutViewEntity!.data.customerPaymentMethods![index].id!;
                                      } else {
                                        homeCubit.paymentSelectedIndexes.add(homeCubit.checkOutViewEntity!.data.customerPaymentMethods![index].id);
                                        homeCubit.selectedPaymentId = homeCubit.checkOutViewEntity!.data.customerPaymentMethods![index].id!;
                                      }
                                      homeCubit.getPaymentMethod(
                                          paymentID: homeCubit.checkOutViewEntity!.data.customerPaymentMethods![index].id!,
                                      );
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        padding: EdgeInsets.all(5.rSp),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ColorsManager.lightGrey,
                                              width: 1.rSp,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                                            color: homeCubit.paymentSelectedIndexes.contains(homeCubit.checkOutViewEntity!.data.customerPaymentMethods![index].id) ?
                                            ColorsManager.success.withOpacity(0.3) : ColorsManager.lightGrey.withOpacity(0.1)
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.rSp),
                                              child: SizedBox(
                                                height: MediaQuery.of(context).size.height / 12,
                                                width: MediaQuery.of(context).size.width / 6,
                                                child: CachedNetworkImage(
                                                  imageUrl: homeCubit.checkOutViewEntity!.data.customerPaymentMethods![index].logoPath ?? '',
                                                  imageBuilder: (context, imageProvider) => Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
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
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: DefaultText(
                                                  title: '${homeCubit.checkOutViewEntity!.data.customerPaymentMethods![index].name}',
                                                  fontSize: 12.rSp,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorsManager.mainColor,
                                                  style: Style.small,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      if(homeCubit.paymentSelectedIndexes.contains(homeCubit.checkOutViewEntity!.data.customerPaymentMethods![index].id))
                                        Positioned(
                                            top: 0,
                                            right: 1.w,
                                            child: const Icon(Icons.check)
                                        )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(1.h),
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
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: appBloc.translationModel!.total,
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: homeCubit.storesSubtotal != null ? '${homeCubit.storesSubtotal} ${appBloc.translationModel!.currency}':
                                          '${homeCubit.checkOutViewEntity!.data.shopsCart!['stores_subtotal']} ${appBloc.translationModel!.currency}',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: appBloc.translationModel!.discountValue,
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: homeCubit.storesDiscounts != null ? '${homeCubit.storesDiscounts} ${appBloc.translationModel!.currency}':
                                          '${homeCubit.checkOutViewEntity!.data.shopsCart!['stores_discounts']} ${appBloc.translationModel!.currency}',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small,
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: appBloc.translationModel!.promoCode,
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: homeCubit.storesPromoAmount != null ? '${homeCubit.storesPromoAmount} ${appBloc.translationModel!.currency}':
                                          '${homeCubit.checkOutViewEntity!.data.shopsCart!['stores_promo_amount']} ${appBloc.translationModel!.currency}',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small,
                                      ),
                                    ),
                                  ],
                                ),


                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: appBloc.translationModel!.deliveryFees,
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: homeCubit.totalShipping != null ? '${homeCubit.totalShipping} ${appBloc.translationModel!.currency}':
                                          homeCubit.getShippingAddressFeesEntity != null && homeCubit.getShippingAddressFeesEntity == null?
                                          '${homeCubit.getShippingAddressFeesEntity!.data.shopsCart!.totalShipping} ${appBloc.translationModel!.currency}' :
                                          homeCubit.getShippingAddressFeesEntity == null && homeCubit.getShippingAddressFeesEntity != null?
                                          '${homeCubit.getPaymentMethodEntity!.data.fees} ${appBloc.translationModel!.currency}':
                                          homeCubit.getShippingAddressFeesEntity != null && homeCubit.getShippingAddressFeesEntity != null?
                                          '${int.parse(homeCubit.getShippingAddressFeesEntity!.data.shopsCart!.totalShipping.toString())} ${appBloc.translationModel!.currency}':
                                          '0.00 ${appBloc.translationModel!.currency}',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: DefaultText(
                                          title: appBloc.translationModel!.total,
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: DefaultText(

                                          title:
                                          homeCubit.cartTotalWithShipping != null ? '${homeCubit.cartTotalWithShipping} ${appBloc.translationModel!.currency}':
                                          homeCubit.getShippingAddressFeesEntity != null
                                              ?
                                          '${homeCubit.getShippingAddressFeesEntity!.data!.shopsCart!.cartTotalWithShipping} ${appBloc.translationModel!.currency}' : '${homeCubit.checkOutViewEntity!.data!.shopsCart!['totalCarts']} ${appBloc.translationModel!.currency}',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          verticalSpace(2.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: DefaultButton(
                                text: appBloc.translationModel!.placeOrder,
                                onPressed: homeCubit.paymentSelectedIndexes.isEmpty ||
                                    homeCubit.addressSelectedIndexes.isEmpty
                                    ? () {
                                  designToastDialog(
                                      context: context,
                                      toast: TOAST.warning,
                                      text: '${appBloc.translationModel!.location} ${appBloc.translationModel!.requiredField} & ${appBloc.translationModel!.paymentMethod} ${appBloc.translationModel!.requiredField}'
                                  );
                                }
                                    : () {
                                  homeCubit.checkout(
                                      paymentID: homeCubit.selectedPaymentId,
                                      addressID: homeCubit.selectedAddressId,
                                  );
                                },
                            ),
                          ),
                          verticalSpace(2.h)
                        ]),

                  ],
                ),
              ) : const MapDetailsLoading(),
            );
          },
        )
    );
  }
}
