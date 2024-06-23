import 'package:card_loading/card_loading.dart';
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

class HotDealsList extends StatelessWidget {
  const HotDealsList({super.key});

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
              homeCubit.hotDeals(productCategories: null,storeCategories: null);
            }
          },
          builder: (context, state) {
            return homeCubit.hotDealsEntity !=  null && homeCubit.hotDealsEntity!.data.products!.data!.isNotEmpty ?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DefaultText(
                        title: appBloc.translationModel!.hotDeals,
                        style: Style.headMedium,
                        color: ColorsManager.mainColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.rSp,
                      ),
                    ],
                  ),
                  verticalSpace(1.h),
                  SizedBox(
                    height: 36.h,
                    width: 100.w,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: homeCubit.hotDealsEntity!.data.products!.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: ProductCard(
                            category: homeCubit.hotDealsEntity!.data.products!.data![index].getCategory!.name!,
                            name: homeCubit.hotDealsEntity!.data.products!.data![index].name!,
                            newPrice: double.parse(homeCubit.hotDealsEntity!.data.products!.data![index].originalPrice!).toStringAsFixed(2),
                            rate: homeCubit.hotDealsEntity!.data.products!.data![index].rate!,
                            imagePath: homeCubit.hotDealsEntity!.data.products!.data![index].images!,
                            isFavourite: homeCubit.hotDealsEntity!.data.products!.data![index].favorites!.isNotEmpty?true:false,
                            onProductTap: () {
                              navigateTo(context, ShowProductDetails(
                                  productID: homeCubit.hotDealsEntity!.data.products!.data![index].id!
                              ));
                            },
                            onFavoriteTap: () {
                              homeCubit.addFavourite(
                                itemType: 'product',
                                itemID: homeCubit.hotDealsEntity!.data.products!.data![index].id!,
                              );
                            },
                            imagesCount: homeCubit.hotDealsEntity!.data.products!.data![index].images!.length,
                            ratingCount: homeCubit.hotDealsEntity!.data.products!.data![index].ratings!.length,
                            offer: homeCubit.hotDealsEntity!.data.products!.data![index].originalPrice != null && (homeCubit.hotDealsEntity!.data.products!.data![index].originalPrice != homeCubit.hotDealsEntity!.data.products!.data![index].finalPrice)?
                            (  (
                                (
                                    double.parse(homeCubit.hotDealsEntity!.data.products!.data![index].originalPrice!) -
                                        double.parse(homeCubit.hotDealsEntity!.data.products!.data![index].finalPrice!)
                                ) /
                                    double.parse(homeCubit.hotDealsEntity!.data.products!.data![index].originalPrice!)
                            ) * 100).toStringAsFixed(2)
                                :null,
                            offerType: homeCubit.hotDealsEntity!.data.products!.data![index].originalPrice != null && (
                                double.parse(double.parse(homeCubit.hotDealsEntity!.data.products!.data![index].originalPrice!).toStringAsFixed(2))!= double.parse(double.parse(homeCubit.hotDealsEntity!.data.products!.data![index].finalPrice!).toStringAsFixed(2)))? 1 : null,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ):
            homeCubit.hotDealsEntity !=  null && homeCubit.hotDealsEntity!.data.products!.data!.isEmpty?
            Container():
            CardLoading(
              height: 20.h,
              borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
              width: 100.w,
              margin: EdgeInsets.only(bottom: 10.rSp),
            );
          },
        )
    );
  }
}
