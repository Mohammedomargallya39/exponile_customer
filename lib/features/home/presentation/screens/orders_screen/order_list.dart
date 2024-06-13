import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    return Directionality(
        textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: BlocBuilder<HomeCubit,HomeState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SizedBox(
                height: 85.h,
                child:
                RefreshIndicator(
                  onRefresh: () async{
                    homeCubit.categories();
                    await Future.delayed(const Duration(seconds: 2));
                  },
                  backgroundColor: Colors.transparent,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child:homeCubit.categoriesEntity != null && homeCubit.categoriesEntity!.data.productCats.isNotEmpty ?
                    Column(
                      children: [
                        verticalSpace(2.h),
                        AnimationLimiter(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homeCubit.categoriesEntity!.data.productCats.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 1000),
                                child: ScaleAnimation(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  scale: 1.5,
                                  child: FadeInAnimation(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 8.h,
                                              width: 16.w,
                                              child: CachedNetworkImage(
                                                imageUrl: homeCubit.categoriesEntity!.data.productCats[index].bannerPath,
                                                imageBuilder: (context, imageProvider) => Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                                                    image: DecorationImage(
                                                        image: imageProvider, fit: BoxFit.cover),
                                                  ),
                                                ),
                                                errorWidget: (context, url, error) => Container(
                                                  height: 10.h,
                                                  width: 20.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                      bottomLeft:  Radius.circular(!appBloc.isArabic?10.rSp:0),
                                                      topLeft: Radius.circular(!appBloc.isArabic?10.rSp:0),
                                                      bottomRight: Radius.circular(appBloc.isArabic?10.rSp:0),
                                                      topRight: Radius.circular(appBloc.isArabic?10.rSp:0),
                                                    ),
                                                  ),
                                                  child: svgImage(path: Assets.images.svg.noImage),
                                                ),
                                                placeholder: (context, url) => Container(
                                                  color: Colors.black.withOpacity(0.5),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            horizontalSpace(2.w),
                                            Expanded(
                                              child: DefaultText(
                                                title: homeCubit.categoriesEntity!.data.productCats[index].name,
                                                style: Style.headLarge,
                                                fontSize: 12.rSp,
                                                fontWeight: FontWeight.w700,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        verticalSpace(1.h),
                                        Divider(
                                          height: 1.rSp,
                                          color: ColorsManager.darkGrey,
                                          thickness: 1.rSp,
                                        ),
                                        verticalSpace(1.h),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ) :
                    Center(
                      child: DefaultText(
                          title: appBloc.translationModel!.noData,
                          style: Style.headLarge
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
