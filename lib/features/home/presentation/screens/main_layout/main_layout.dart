import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/cubit/state.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:exponile_customer/core/util/widgets/default_text_field.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:exponile_customer/core/util/widgets/two_option_dialog.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/product_screen/show_product_details.dart';
import 'package:exponile_customer/features/home/presentation/screens/shop_screen/shop_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../../../../core/util/widgets/versions_dialog.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  void initState() {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.filterMainSearch['product']= appBloc.translationModel!.products;
    homeCubit.filterMainSearch['store']= appBloc.translationModel!.stores;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {
        if(state is AppInfoSuccessState && customerVersion != state.appInfoEntity.customerVersion){
          showDialog(
            context: context,
            barrierDismissible: state.appInfoEntity.customerRequired == 'no' ? true : false,
            builder: (context) {
              return VersionDialog(
                message: appBloc.translationModel!.sure,
                popButtonVoidCallback:
                state.appInfoEntity.customerRequired == 'no'?  () {
                  Navigator.pop(context);
                } : null,

                pushButtonVoidCallback: () {
                  Platform.isAndroid ?
                  appBloc.launchGooglePlayStore(
                      storeLink: state.appInfoEntity.customerAndroidLink!
                  ) :
                  appBloc.launchGooglePlayStore(
                      storeLink: state.appInfoEntity.customerIosLink!
                  );
                },
              );
            },
          );
        }
      },
      builder: (context, state) {
          return  Directionality(
            textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: BlocBuilder<HomeCubit,HomeState>(
                builder: (context, state) {
                  return Scaffold(
                    appBar: MainAppBar(
                      title: null,
                      isBack: false,
                      isLang: false,
                      widget: SizedBox(
                        width: 90.w,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: DefaultTextField(
                                controller: homeCubit.mainSearchController,
                                hint: 'Search',
                                maxLines: 1,
                                svgImg:homeCubit.selectedMainSearchType == null || homeCubit.selectedMainSearchType == 'product'?
                                Assets.images.svg.product:Assets.images.svg.shop,
                                svgColor: ColorsManager.whiteColor,
                                maxLength: 50,
                                hintStyle: const TextStyle(color: ColorsManager.whiteColor),
                                mainInputColor: ColorsManager.whiteColor,
                                margin: EdgeInsets.symmetric(vertical: 2.h),
                                suffixIcon: DefaultIconButton(
                                  icon: const Icon(Icons.search, color: ColorsManager.whiteColor,),
                                  onPressed: ()
                                  {
                                    // homeCubit.mainSearchProduct(
                                    //     searchText:  homeCubit.mainSearchController.text.isEmpty ? '':homeCubit.mainSearchController.text
                                    // );
                                  },
                                ),
                                onChanged: (value) {
                                  if(homeCubit.selectedMainSearchType == null || homeCubit.selectedMainSearchType == 'product'){
                                    homeCubit.mainSearchProduct(
                                        searchText: homeCubit.mainSearchController.text
                                    );
                                  }else{
                                    homeCubit.mainSearchShop(
                                        searchText: homeCubit.mainSearchController.text
                                    );
                                  }
                                },
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 1.h),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                                  child: Row(
                                    children: [
                                      DefaultText(
                                        title: homeCubit.selectedMainSearchName ?? homeCubit.filterMainSearch.values.toList()[0],
                                        style: Style.large,
                                        fontSize: 12.rSp,
                                        color: ColorsManager.whiteColor,
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down_sharp,
                                        color: ColorsManager.whiteColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    enableDrag: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0.rSp))),
                                    builder: (context) {
                                      return BlocBuilder<HomeCubit, HomeState>(
                                        builder: (context, state) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                right: 20.0.rSp,
                                                top: 20.rSp,
                                                left: 20.0.rSp
                                            ),
                                            child: SizedBox(
                                              height: 20.h,
                                              child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.0.rSp),
                                                  child: ListView.builder(
                                                      itemCount: homeCubit.filterMainSearch.length,
                                                      itemBuilder: (context, i) {
                                                        return DropdownMenuItem(
                                                          child: InkWell(
                                                            onTap: () {
                                                              homeCubit.selectSearchType(
                                                                mainSearchName: homeCubit.filterMainSearch.values.toList()[i],
                                                                mainSearchType: homeCubit.filterMainSearch.keys.toList()[i],
                                                              );
                                                              homeCubit.mainSearchController.text = '';
                                                              Navigator.pop(context);
                                                            },
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                verticalSpace(2.h),
                                                                SizedBox(
                                                                  width: 100.w,
                                                                  child: Theme(
                                                                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                                                    child: Row(
                                                                      children: [
                                                                        svgImage(path: homeCubit.mainSearchImages[i]),
                                                                        horizontalSpace(2.w),
                                                                        DefaultText(
                                                                          title: homeCubit.filterMainSearch.values.toList()[i],
                                                                          style: Style.small,
                                                                          fontWeight: FontWeight.w700,
                                                                          fontSize: 12.rSp,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                verticalSpace(2.h),
                                                                Divider(
                                                                  thickness: 1.rSp,
                                                                  color: ColorsManager.darkGrey.withOpacity(0.5),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                  )
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar:  CurvedNavigationBar(
                      key: bottomNavigationKey,
                      index: homeCubit.currentNavIndex,
                      height: 7.h,
                      items:
                      token != null ?
                      <Widget>[
                        Icon(Icons.home_outlined,color: homeCubit.currentNavIndex == 0? ColorsManager.whiteColor:ColorsManager.black,),
                        Icon(Icons.local_offer_outlined,color: homeCubit.currentNavIndex == 1? ColorsManager.whiteColor:ColorsManager.black),
                        Icon(Icons.category_outlined,color: homeCubit.currentNavIndex == 2? ColorsManager.whiteColor:ColorsManager.black),
                        Stack(
                          children: [
                            Icon(Icons.production_quantity_limits_outlined,color: homeCubit.currentNavIndex == 3? ColorsManager.whiteColor:ColorsManager.black),
                            Positioned(
                              right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorsManager.warning,
                                    borderRadius: BorderRadius.circular(10.rSp),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 3.rSp,vertical: 1.rSp),
                                  child:  DefaultText(
                                      title: '0',
                                      style: Style.small,
                                      fontSize: 7.rSp,
                                      color: ColorsManager.whiteColor,
                                  ),
                                )
                            )
                          ],
                        ),
                        Icon(Icons.shopping_bag_outlined,color: homeCubit.currentNavIndex == 4? ColorsManager.whiteColor:ColorsManager.black),
                        Icon(Icons.settings_outlined,color: homeCubit.currentNavIndex == 5? ColorsManager.whiteColor:ColorsManager.black),
                      ]:
                      <Widget>[
                        Icon(Icons.home_outlined,color: homeCubit.currentNavIndex == 0? ColorsManager.whiteColor:ColorsManager.black,),
                        Icon(Icons.local_offer_outlined,color: homeCubit.currentNavIndex == 1? ColorsManager.whiteColor:ColorsManager.black),
                        Icon(Icons.category_outlined,color: homeCubit.currentNavIndex == 2? ColorsManager.whiteColor:ColorsManager.black),
                        Icon(Icons.settings_outlined,color: homeCubit.currentNavIndex == 5? ColorsManager.whiteColor:ColorsManager.black),
                      ],
                      color: ColorsManager.primary.withOpacity(0.05),
                      buttonBackgroundColor: ColorsManager.mainColor,
                      backgroundColor: Colors.transparent,
                      animationCurve: Curves.linear,
                      animationDuration: const Duration(milliseconds: 300),
                      onTap: (index)
                      {
                        homeCubit.changeNavBottomScreens(index);
                      },
                      letIndexChange: (index) => true,
                    ),
                    body:HideKeyboardPage(
                      child: PopScope(
                          canPop: false,
                          onPopInvoked: (bool didPop){
                            didPop = true;
                            if(didPop && homeCubit.currentNavIndex == 0){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return TwoOptionsDialog(
                                        message: appBloc.translationModel!.exit,
                                        popButtonText: appBloc.translationModel!.cancel,
                                        pushButtonText: appBloc.translationModel!.yesOnly,
                                        pushButtonVoidCallback: (){
                                          SystemNavigator.pop();
                                        },
                                        popButtonVoidCallback: (){
                                          Navigator.pop(context);
                                        },
                                       colorEdit: ColorsManager.error,
                                    );
                                  },
                              );
                            }else if (didPop && homeCubit.currentNavIndex != 0){
                              homeCubit.currentNavIndex = 0;
                              homeCubit.changeNavBottomScreens(0);
                            }
                          },
                          child: Column(
                            children: [
                              if(homeCubit.mainSearchController.text.isNotEmpty && homeCubit.mainSearchProductEntity != null && homeCubit.mainSearchProductEntity!.data.isNotEmpty && (homeCubit.selectedMainSearchType == null || homeCubit.selectedMainSearchType == 'product'))
                              SizedBox(
                                height: 25.h,
                                width: 100.w,
                                child: ListView.builder(
                                    itemCount: homeCubit.mainSearchProductEntity!.data.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
                                        child: InkWell(
                                          onTap: () {
                                            navigateTo(
                                                context, ShowProductDetails(
                                                productID: homeCubit.mainSearchProductEntity!.data[index].id!
                                            )
                                            );
                                          },
                                          child: Container(
                                            height: 25.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorsManager.black,
                                                    width: 1.rSp
                                                ),
                                              borderRadius: BorderRadius.all(Radius.circular(10.rSp))
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                                              child: Column(
                                                children: [
                                                  verticalSpace(1.h),
                                                  SizedBox(
                                                    height: 10.h,
                                                    width: 20.w,
                                                    child: CachedNetworkImage(
                                                      imageUrl: homeCubit.mainSearchProductEntity!.data[index].images[0].imagePath ?? '',
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
                                                    ),
                                                  ),
                                                  verticalSpace(2.h),
                                                  RatingBar.builder(
                                                    initialRating: double.parse(homeCubit.mainSearchProductEntity!.data[index].rate!),
                                                    minRating: 0,
                                                    ignoreGestures: true,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 10.rSp,
                                                    itemPadding: EdgeInsets.symmetric(horizontal: 5.0.rSp),
                                                    itemBuilder: (context, _) => const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                    },
                                                  ),
                                                  verticalSpace(1.h),
                                                  DefaultText(
                                                    title: homeCubit.mainSearchProductEntity!.data[index].name!,
                                                    style: Style.small,
                                                    fontSize: 10.rSp,
                                                    maxLines: 1,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  verticalSpace(1.h),
                                                  DefaultText(
                                                    title: homeCubit.mainSearchProductEntity!.data[index].description!,
                                                    style: Style.small,
                                                    fontSize: 10.rSp,
                                                    maxLines: 2,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                ),
                              ),
                              if(homeCubit.mainSearchController.text.isNotEmpty && homeCubit.mainSearchShopEntity != null && homeCubit.mainSearchShopEntity!.data.isNotEmpty && homeCubit.selectedMainSearchType == 'store')
                              SizedBox(
                                  height: 25.h,
                                  width: 100.w,
                                  child: ListView.builder(
                                    itemCount: homeCubit.mainSearchShopEntity!.data.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          navigateTo(
                                              context,
                                              ShopScreen(
                                                  shopID: homeCubit.mainSearchShopEntity!.data[index].id!
                                              ),
                                          );
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
                                          child: Container(
                                            height: 25.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorsManager.black,
                                                    width: 1.rSp
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(10.rSp))
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                                              child: Column(
                                                children: [
                                                  verticalSpace(1.h),
                                                  SizedBox(
                                                    height: 10.h,
                                                    width: 20.w,
                                                    child: CachedNetworkImage(
                                                      imageUrl: homeCubit.mainSearchShopEntity!.data[index].logoPath ?? '',
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
                                                    ),
                                                  ),
                                                  verticalSpace(2.h),
                                                  RatingBar.builder(
                                                    initialRating: double.parse(homeCubit.mainSearchShopEntity!.data[index].rate!),
                                                    minRating: 0,
                                                    ignoreGestures: true,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 10.rSp,
                                                    itemPadding: EdgeInsets.symmetric(horizontal: 5.0.rSp),
                                                    itemBuilder: (context, _) => const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                    },
                                                  ),
                                                  verticalSpace(1.h),
                                                  DefaultText(
                                                    title: homeCubit.mainSearchShopEntity!.data[index].shopName!,
                                                    style: Style.small,
                                                    fontSize: 10.rSp,
                                                    maxLines: 1,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  verticalSpace(1.h),
                                                  DefaultText(
                                                    title: homeCubit.mainSearchShopEntity!.data[index].categories[0].name!,
                                                    style: Style.small,
                                                    fontSize: 10.rSp,
                                                    maxLines: 2,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              homeCubit.customer.elementAt(homeCubit.currentNavIndex),
                            ],
                          )
                      ),
                    ),
                  );
                },
            ),
          );
        },
    );
  }
}
