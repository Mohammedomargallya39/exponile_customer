import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/loading_files/all_product_loading.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/progress.dart';
import '../product_screen/product_card.dart';
import '../product_screen/show_product_details.dart';
import '../shop_screen/shop_screen.dart';
import '../shop_screen/store_card.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> with SingleTickerProviderStateMixin{

  TabController? _tabController;

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    _tabController = TabController(length: 2, vsync: this);
    homeCubit.favouriteStores(itemType: 'store');
    homeCubit.favouriteProducts(itemType: 'product');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
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
                homeCubit.favouriteStores(itemType: 'store');
                homeCubit.favouriteProducts(itemType: 'product');
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: MainAppBar(
                    title: appBloc.translationModel!.favourites,
                    isBack: true,
                    isLang: false
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        tabs: <Widget>[
                          Tab(
                            text: appBloc.translationModel!.products,
                          ),
                          Tab(
                            text: appBloc.translationModel!.stores,
                          ),
                        ],
                        labelStyle: TextStyle(
                            color: ColorsManager.black,
                            fontSize: 12.rSp,
                            fontWeight: FontWeight.w700,
                        ),
                        labelColor: ColorsManager.mainColor,
                        unselectedLabelColor: ColorsManager.black.withOpacity(0.6),
                        indicatorColor: ColorsManager.mainColor,
                      ),
                      verticalSpace(2.h),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ///products
                            homeCubit.favouriteProductsEntity != null ?
                            GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: homeCubit.favouriteProductsEntity!.data!.length,
                              gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                childAspectRatio:
                                (MediaQuery.of(context).size.width) / (MediaQuery.of(context).size.height / 1.33),
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                                  child: ProductCard(
                                    category: homeCubit.favouriteProductsEntity!.data![index].getCategory.name!,
                                    name: homeCubit.favouriteProductsEntity!.data![index].name!,
                                    newPrice: '${homeCubit.favouriteProductsEntity!.data![index].basicPrice}',
                                    rate: homeCubit.favouriteProductsEntity!.data![index].rate!,
                                    imagePath: homeCubit.favouriteProductsEntity!.data![index].images,
                                    isFavourite: true,
                                    onProductTap: () {
                                      navigateTo(context, ShowProductDetails(
                                          productID: homeCubit.favouriteProductsEntity!.data![index].id!
                                      ));
                                    },
                                    onFavoriteTap: () {
                                      homeCubit.addFavourite(
                                        itemType: 'product',
                                        itemID: homeCubit.favouriteProductsEntity!.data![index].id!,
                                      );
                                    },
                                    imagesCount: homeCubit.favouriteProductsEntity!.data![index].images.length,
                                    ratingCount: homeCubit.favouriteProductsEntity!.data![index].ratings.length,
                                    offer: homeCubit.favouriteProductsEntity!.data![index].offers.isNotEmpty && homeCubit.favouriteProductsEntity!.data![index].offers[0].type == 1 ? '-${homeCubit.favouriteProductsEntity!.data![index].offers[0].value} %':null,
                                    offerType: homeCubit.favouriteProductsEntity!.data![index].offers.isNotEmpty? homeCubit.favouriteProductsEntity!.data![index].offers[0].type : null,
                                  ),
                                );
                              },
                            ):
                            const AllProductsLoading(),


                            ///stores
                            homeCubit.favouriteStoresEntity != null ?
                            GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: homeCubit.favouriteStoresEntity!.data!.data.length,
                              gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                childAspectRatio:
                                (MediaQuery.of(context).size.width) / (MediaQuery.of(context).size.height / 1.33),
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                                  child: StoreCard(
                                    imagePath: homeCubit.favouriteStoresEntity!.data!.data[index].getShop!.logoPath!,
                                    category: homeCubit.favouriteStoresEntity!.data!.data[index].getShop!.categories![0]!.name!,
                                    name: homeCubit.favouriteStoresEntity!.data!.data[index].getShop!.shopName!,
                                    rate: homeCubit.favouriteStoresEntity!.data!.data[index].getShop!.rate!,
                                    isFavourite: true,
                                    onStoreTap: () {
                                      navigateTo(context, ShopScreen(
                                          shopID: homeCubit.favouriteStoresEntity!.data!.data[index].getShop!.id!
                                      ));
                                    },
                                    onFavoriteTap: () {
                                      homeCubit.addFavourite(
                                        itemType: 'store',
                                        itemID: homeCubit.favouriteStoresEntity!.data!.data[index].getShop!.id!,
                                      );
                                    },
                                  ),
                                );
                              },
                            ) :
                            const AllProductsLoading(),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
        )
    );
  }
}
