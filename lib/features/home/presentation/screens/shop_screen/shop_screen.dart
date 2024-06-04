import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/loading_files/all_product_loading.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/product_screen/product_card.dart';
import 'package:exponile_customer/features/home/presentation/screens/product_screen/show_product_details.dart';
import 'package:exponile_customer/features/home/presentation/screens/shop_screen/shop_view_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key,required this.shopID});
  final int shopID;

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.shopData(
        shopID: widget.shopID,
        category: homeCubit.categories,
        subCategory: homeCubit.subCategories,
        from: homeCubit.filterShopStartDate.text,
        to: homeCubit.filterShopEndDate.text,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: BlocBuilder<HomeCubit,HomeState>(
        builder: (context, state) {
          return Scaffold(
             appBar: MainAppBar(
                 title: appBloc.translationModel!.shop,
                 isBack: true,
                 isLang: false
             ),
             body: homeCubit.shopDataEntity != null ?
             Column(
              children: [
                StoreViewCard(
                  storeImagePath: homeCubit.shopDataEntity!.data!.store.bannerPath!,
                  storeName: homeCubit.shopDataEntity!.data!.store.shopName ?? '',
                  storeCategories: homeCubit.shopDataEntity!.data!.categories[0].slug!,
                  storeRate: homeCubit.shopDataEntity!.data!.store.rate ?? '',
                  onStoreReviewsTap: () async {
                    // bool connected = await checkInternet(context);
                    // if (connected) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>
                    //               StoreReviewsScreen(
                    //                 reviews: homeCubit.shopDataEntity!.data!.store.ratings,
                    //                 categories: homeCubit.shopDataEntity!.data!.store.categories,
                    //                 logoPath: homeCubit.shopDataEntity!.data!.store.bannerPath!,
                    //                 storeName: homeCubit.shopDataEntity!.data!.store.shopName!,
                    //                 rate: homeCubit.shopDataEntity!.data!.store.rate!,
                    //               )));
                    // }
                  },
                  onStoreOffersTap: () async {
                    // bool connected = await checkInternet(context);
                    // if (connected) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>
                    //               StoreOffersScreen(
                    //                 storeId: homeCubit.shopDataEntity!.data!.store.id,
                    //                 category: homeCubit.shopDataEntity!.data!.store.categories[0].slug!,
                    //               )
                    //       ));
                    // }
                  },
                  isFavorite: homeCubit.shopDataEntity!.data!.store
                      .favorites.isNotEmpty
                      ? true
                      : false,
                  onStoreFavoriteTap: () async {
                    homeCubit.addFavourite(
                      itemType: 'store',
                      itemID: widget.shopID,
                    );
                  },
                  onStoreProductFilterTap: () {

                  },
                ),
                verticalSpace(1.h),
                verticalSpace(1.h),
                homeCubit.shopDataEntity!.data!.products.isEmpty
                    ? Center(
                  child: SizedBox(
                      width: 350.rSp,
                      height: 350.rSp,
                      child: svgImage(path: Assets.images.svg.noImage)
                  ),
                )
                    : Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: homeCubit.shopDataEntity!.data!.products.length,
                    gridDelegate:
                    SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio:
                      (MediaQuery.of(context).size.width) / (MediaQuery.of(context).size.height / 1.4),
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                        child: ProductCard(
                          category: homeCubit.shopDataEntity!.data!.products[index].getCategory!.name,
                          name: homeCubit.shopDataEntity!.data!.products[index].name ?? '',
                          newPrice: '${homeCubit.shopDataEntity!.data!.products[index].basicPrice}',
                          rate: homeCubit.shopDataEntity!.data!.products[index].rate!,
                          imagePath: homeCubit.shopDataEntity!.data!.products[index].images[0].imagePath!,
                          isFavourite: homeCubit.shopDataEntity!.data!.products[index].favorites.isNotEmpty
                              ? true
                              : false,
                          onProductTap: () {
                            navigateTo(context, ShowProductDetails(
                                productID: homeCubit.shopDataEntity!.data!.products[index].id!
                            ));
                          },
                          onFavoriteTap: () {
                            homeCubit.addFavourite(
                              itemType: 'product',
                              itemID: homeCubit.shopDataEntity!.data!.products[index].id!,
                            );
                          },
                          imagesCount: homeCubit.shopDataEntity!.data!.products[index].images.length,
                          ratingCount: homeCubit.shopDataEntity!.data!.products[index].ratings.length,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ):
             const AllProductsLoading(),
          );
        },
      ),
    );
  }
}
