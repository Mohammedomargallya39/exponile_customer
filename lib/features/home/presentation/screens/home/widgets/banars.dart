import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/util/cubit/cubit.dart';
import '../../../../../../core/util/resources/assets.gen.dart';
import '../../../../../../core/util/resources/constants_manager.dart';
import '../../../controller/cubit.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
        textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: BlocBuilder<HomeCubit,HomeState>(
            builder: (context, state) {
              return  SizedBox(
                height: 20.h,
                child:
                homeCubit.landingEntity != null && homeCubit.landingEntity!.data.banners.isNotEmpty?
                CarouselSlider.builder(
                  itemCount: homeCubit.landingEntity!.data.banners.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageIndex) =>
                      SizedBox(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: homeCubit.landingEntity!.data.banners[itemIndex].bannerPath!,
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.fill),
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
                              Align(
                                alignment: Alignment.center,

                                child: DefaultText(
                                    title: homeCubit.landingEntity!.data.banners[itemIndex].title!,
                                    style: Style.headMedium,
                                    fontSize: 12.rSp,
                                    fontWeight: FontWeight.w700,
                                    color: ColorsManager.whiteColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 5.5,
                    autoPlay: true,
                    autoPlayCurve: Curves.easeInOut,
                    enableInfiniteScroll: false,
                    autoPlayInterval: const Duration(milliseconds: 3200),
                    autoPlayAnimationDuration:
                    const Duration(milliseconds: 800),
                    viewportFraction: 1,
                  ),
                ) :
                CardLoading(
                  height: 20.h,
                  borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
                  width: 100.w,
                  margin: EdgeInsets.only(bottom: 10.rSp),
                ),
              );
            },
        )
    );
  }
}

