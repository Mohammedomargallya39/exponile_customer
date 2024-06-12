import 'package:card_loading/card_loading.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/product_screen/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/util/cubit/cubit.dart';
import '../../../../../../core/util/resources/colors_manager.dart';
import '../../../../../../core/util/resources/constants_manager.dart';
import '../../../../../../core/util/widgets/default_text.dart';
import '../../../../../../core/util/widgets/progress.dart';
import '../../product_screen/show_product_details.dart';

class BestSellingProductsList extends StatefulWidget {
  const BestSellingProductsList({super.key});

  @override
  State<BestSellingProductsList> createState() => _BestSellingProductsListState();
}

class _BestSellingProductsListState extends State<BestSellingProductsList>  with TickerProviderStateMixin{

  late final TabController _bestSellingTabController;

  @override
  void initState() {
    _bestSellingTabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _bestSellingTabController.dispose();
    super.dispose();
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
              homeCubit.newArrivals(productCategories: null,storeCategories: null);
              homeCubit.bestSellingProducts();
            }
          },
          builder: (context, state) {
            return homeCubit.newArrivalsEntity ==  null && homeCubit.bestSellingProductsEntity == null ?
            CardLoading(
              height: 20.h,
              borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
              width: 100.w,
              margin: EdgeInsets.only(bottom: 10.rSp),
            ) :

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DefaultText(
                        title: appBloc.translationModel!.bestSelling,
                        style: Style.headMedium,
                        color: ColorsManager.mainColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.rSp,
                      ),
                      // const Spacer(),
                      // DefaultText(
                      //   title: appBloc.translationModel!.seeAll,
                      //   style: Style.headMedium,
                      //   color: ColorsManager.mainColor,
                      //   fontWeight: FontWeight.w700,
                      //   fontSize: 14.rSp,
                      // ),
                    ],
                  ),
                  verticalSpace(1.h),

                  if((homeCubit.bestSellingProductsEntity == null ||  homeCubit.bestSellingProductsEntity![0].products!.isEmpty || homeCubit.bestSellingProductsEntity![1].products!.isEmpty || homeCubit.bestSellingProductsEntity![2].products!.isEmpty || homeCubit.bestSellingProductsEntity![3].products!.isEmpty || homeCubit.bestSellingProductsEntity!.isEmpty) && homeCubit.newArrivalsEntity != null && homeCubit.newArrivalsEntity!.data.products!.data!.isNotEmpty)
                    SizedBox(
                      height: 36.h,
                      width: 100.w,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: homeCubit.newArrivalsEntity!.data.products!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final bestSellingProducts = homeCubit.newArrivalsEntity!.data.products!.data!.reversed.toList();
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: ProductCard(
                              category: bestSellingProducts[index].getCategory!.name!,
                              name: bestSellingProducts[index].name!,
                              newPrice: double.parse(bestSellingProducts[index].originalPrice!).toStringAsFixed(2),
                              rate: bestSellingProducts[index].rate!,
                              imagePath: bestSellingProducts[index].images!,
                              isFavourite: bestSellingProducts[index].favorites!.isNotEmpty?true:false,
                              onProductTap: () {
                                navigateTo(context, ShowProductDetails(
                                    productID: bestSellingProducts[index].id!
                                ));
                              },
                              onFavoriteTap: () {
                                homeCubit.addFavourite(
                                  itemType: 'product',
                                  itemID: bestSellingProducts[index].id!,
                                );
                              },
                              imagesCount: bestSellingProducts[index].images!.length,
                              ratingCount: bestSellingProducts[index].ratings!.length,
                              offer: bestSellingProducts[index].originalPrice != null && (bestSellingProducts[index].originalPrice != bestSellingProducts[index].finalPrice)?
                              (  (
                                  (
                                      double.parse(bestSellingProducts[index].originalPrice!) -
                                          double.parse(bestSellingProducts[index].finalPrice!)
                                  ) /
                                      double.parse(bestSellingProducts[index].originalPrice!)
                              ) * 100).toStringAsFixed(2)
                                  :null,
                              offerType: bestSellingProducts[index].originalPrice != null && (
                                  double.parse(double.parse(bestSellingProducts[index].originalPrice!).toStringAsFixed(2))!= double.parse(double.parse(bestSellingProducts[index].finalPrice!).toStringAsFixed(2)))? 1 : null,
                            ),
                          );
                        },
                      ),
                    ),

                  if(homeCubit.bestSellingProductsEntity != null && homeCubit.bestSellingProductsEntity![0].products!.isNotEmpty && homeCubit.bestSellingProductsEntity![1].products!.isNotEmpty && homeCubit.bestSellingProductsEntity![2].products!.isNotEmpty && homeCubit.bestSellingProductsEntity![3].products!.isNotEmpty && homeCubit.bestSellingProductsEntity!.isNotEmpty)
                    SizedBox(
                      height: 40.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          TabBar(
                            controller: _bestSellingTabController,
                            tabs: List<Widget>.generate(
                              homeCubit.bestSellingProductsEntity!.length,
                                  (index) {
                                _bestSellingTabController.addListener(() {
                                  homeCubit.changeBestCurrentIndex(value: _bestSellingTabController.index);
                                });
                                return Tab(
                                  text: homeCubit.bestSellingProductsEntity![index].category!.slug,
                                );
                              } ,
                            ),
                            labelStyle: TextStyle(
                                color: ColorsManager.black,
                                fontSize: 12.rSp,
                                fontWeight: FontWeight.bold
                            ),
                            labelColor: ColorsManager.mainColor,
                            unselectedLabelColor: ColorsManager.black.withOpacity(0.6),
                            indicatorColor: ColorsManager.mainColor,
                            labelPadding: EdgeInsets.symmetric(horizontal: 2.w),
                            isScrollable: true,
                            padding: EdgeInsets.symmetric(horizontal: 0.w,vertical: 1.h),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _bestSellingTabController,
                              children:
                              List<Widget>.generate(
                                homeCubit.bestSellingProductsEntity!.length,
                                    (index) =>  homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products!.isNotEmpty ?
                                ListView.builder(
                                  itemBuilder: (context, index) {
                                    return homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products!.isNotEmpty?
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                                      child: ProductCard(
                                        category: homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].getCategory!.slug!,
                                        name: homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].name!,
                                        newPrice: double.parse(homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].originalPrice!).toStringAsFixed(2),
                                        rate: homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].rate!,
                                        imagePath: homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].images!,
                                        isFavourite: homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].favorites!.isNotEmpty?true:false,
                                        onProductTap: () {
                                          navigateTo(context, ShowProductDetails(
                                              productID: homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].id!
                                          ));
                                        },
                                        onFavoriteTap: () {
                                          homeCubit.addFavourite(
                                            itemType: 'product',
                                            itemID: homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].id!,
                                          );
                                        },
                                        imagesCount: homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].images!.length,
                                        ratingCount:homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].ratings!.length,
                                        offer: homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].originalPrice != null && (homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].originalPrice != homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].finalPrice)?
                                        (  (
                                            (
                                                double.parse(homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].originalPrice!) -
                                                    double.parse(homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].finalPrice!)
                                            ) /
                                                double.parse(homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].originalPrice!)
                                        ) * 100).toStringAsFixed(2)
                                            :null,
                                        offerType: homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].originalPrice != null && (
                                            double.parse(double.parse(homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].originalPrice!).toStringAsFixed(2))!= double.parse(double.parse(homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products![index].finalPrice!).toStringAsFixed(2)))? 1 : null,
                                      ),
                                    )
                                        :
                                    svgImage(path: Assets.images.svg.noImage);
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homeCubit.bestSellingProductsEntity![homeCubit.bestSellingCurrentIndex].products!.length,
                                  shrinkWrap: true,
                                ) :
                                    svgImage(path: Assets.images.svg.noImage),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        )
    );
  }
}
