import 'package:card_loading/card_loading.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/util/cubit/cubit.dart';
import '../../../../../../core/util/resources/colors_manager.dart';
import '../../../../../../core/util/resources/constants_manager.dart';
import '../../../../../../core/util/widgets/default_text.dart';
import '../../../../../../core/util/widgets/progress.dart';
import '../../../controller/cubit.dart';
import '../../../controller/state.dart';
import '../../product_screen/product_card.dart';
import '../../product_screen/show_product_details.dart';

class RecentlyList extends StatelessWidget {
  const RecentlyList({super.key});

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
            return homeCubit.recentlyViewedEntity ==  null ?
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
                        title: appBloc.translationModel!.recentlyViewed,
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
                   SizedBox(
                      height: 36.h,
                      width: 100.w,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: homeCubit.recentlyViewedEntity!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: ProductCard(
                              category: homeCubit.recentlyViewedEntity![index].getCategory!.name!,
                              name: homeCubit.recentlyViewedEntity![index].name!,
                              newPrice: double.parse(homeCubit.recentlyViewedEntity![index].originalPrice!).toStringAsFixed(2),
                              rate: homeCubit.recentlyViewedEntity![index].rate!,
                              imagePath: homeCubit.recentlyViewedEntity![index].images!,
                              isFavourite: homeCubit.recentlyViewedEntity![index].favorites!.isNotEmpty?true:false,
                              onProductTap: () {
                                navigateTo(context, ShowProductDetails(
                                    productID: homeCubit.recentlyViewedEntity![index].id!
                                ));
                              },
                              onFavoriteTap: () {
                                homeCubit.addFavourite(
                                  itemType: 'product',
                                  itemID: homeCubit.recentlyViewedEntity![index].id!,
                                );
                              },
                              imagesCount: homeCubit.recentlyViewedEntity![index].images!.length,
                              ratingCount: homeCubit.recentlyViewedEntity![index].ratings!.length,
                              offer: homeCubit.recentlyViewedEntity![index].originalPrice != null && (homeCubit.recentlyViewedEntity![index].originalPrice != homeCubit.recentlyViewedEntity![index].finalPrice)?
                              (  (
                                  (
                                      double.parse(homeCubit.recentlyViewedEntity![index].originalPrice!) -
                                          double.parse(homeCubit.recentlyViewedEntity![index].finalPrice!)
                                  ) /
                                      double.parse(homeCubit.recentlyViewedEntity![index].originalPrice!)
                              ) * 100).toStringAsFixed(2)
                                  :null,
                              offerType: homeCubit.recentlyViewedEntity![index].originalPrice != null && (
                                  double.parse(double.parse(homeCubit.recentlyViewedEntity![index].originalPrice!).toStringAsFixed(2))!= double.parse(double.parse(homeCubit.recentlyViewedEntity![index].finalPrice!).toStringAsFixed(2)))? 1 : null,
                            ),
                          );
                        },
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

