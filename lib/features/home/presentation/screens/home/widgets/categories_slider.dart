import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/util/cubit/cubit.dart';
import '../../../../../../core/util/resources/assets.gen.dart';
import '../../../controller/cubit.dart';

class CategorySlider extends StatelessWidget {
  const CategorySlider({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: BlocBuilder<HomeCubit,HomeState>(
        builder: (context, state) {
          return homeCubit.categoriesEntity ==  null || homeCubit.categoriesEntity!.data.storeCats.isEmpty ?
          CardLoading(
            height: 20.h,
            borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
            width: 100.w,
            margin: EdgeInsets.only(bottom: 10.rSp),
          ) :
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                  title: appBloc.translationModel!.storesCategories,
                  style: Style.headMedium,
                  color: ColorsManager.mainColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.rSp,
              ),
              verticalSpace(1.h),
              CarouselSlider.builder(
                itemCount: homeCubit.categoriesEntity!.data.storeCats.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AllCategoryStoresScreen(
                    //           categorySlug: cubit.filteredStoresCategories![itemIndex].slug,
                    //         )));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                        width: 20.w,
                        child: CachedNetworkImage(
                          imageUrl: homeCubit.categoriesEntity!.data.storeCats[itemIndex].bannerPath,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                              height: MediaQuery.of(context).size.height / 4,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                              ),
                              child:svgImage(path: Assets.images.svg.noImage)
                          ),
                          placeholder: (context, url) => Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          fit: BoxFit.fill,
                          memCacheHeight: 300,
                          memCacheWidth: 300,
                        ),
                      ),
                      DefaultText(
                        title: homeCubit.categoriesEntity!.data.storeCats[itemIndex].slug,
                        style: Style.headMedium,
                        color: ColorsManager.mainColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.rSp,
                      ),
                    ],
                  ),
                ),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 6,
                  autoPlay: true,
                  autoPlayCurve: Curves.easeInOut,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(milliseconds: 3200),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.3,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
