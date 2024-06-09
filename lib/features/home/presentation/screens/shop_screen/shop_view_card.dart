import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../controller/cubit.dart';

class StoreViewCard extends StatelessWidget {
  const StoreViewCard({
    super.key,
    required this.storeImagePath,
    required this.storeName,
    required this.storeCategories,
    required this.storeRate,
    required this.isFavorite,
    this.onStoreReviewsTap,
    this.onStoreOffersTap,
    required this.onStoreFavoriteTap,
    this.onStoreProductFilterTap,
  });
  final String storeImagePath;
  final String storeName;
  final String storeCategories;
  final String storeRate;
  final bool isFavorite;
  final Function()? onStoreReviewsTap;
  final Function()? onStoreOffersTap;
  final Function() onStoreFavoriteTap;
  final Function()? onStoreProductFilterTap;
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: BlocBuilder<HomeCubit,HomeState>(
        builder: (context, state) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10.rSp, vertical: 5.rSp),
              padding: EdgeInsets.symmetric(horizontal: 5.rSp, vertical: 5.rSp),
              height: 110.rSp,
              decoration: BoxDecoration(
                color: ColorsManager.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 70.rSp,
                    width: 70.rSp,
                    child: CachedNetworkImage(
                      imageUrl: storeImagePath,
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
                    ),
                  ),
                  horizontalSpace(1.w),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultText(
                          title: storeName,
                          style: Style.medium,
                          fontSize: 14.rSp,
                          fontWeight: FontWeight.bold,
                          maxLines: 1,
                          color: ColorsManager.mainColor,
                        ),
                        verticalSpace(1.h),
                        DefaultText(
                          title: storeCategories,
                          style: Style.medium,
                          fontSize: 14.rSp,
                          fontWeight: FontWeight.bold,
                          maxLines: 1,
                          color: ColorsManager.mainColor,
                        ),
                        verticalSpace(1.h),
                        RatingBar.builder(
                          initialRating: double.parse(storeRate),
                          minRating: 0,
                          ignoreGestures: true,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 14.rSp,
                          //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0.rSp),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if(onStoreReviewsTap != null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            DefaultIconButton(
                                icon: const Icon(Icons.rate_review_outlined),
                                onPressed: onStoreReviewsTap
                            ),
                            horizontalSpace(10.w),
                            DefaultIconButton(
                                icon: Icon(
                                  homeCubit.isChangedFavouriteIcon ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? ColorsManager.success : ColorsManager.black,),
                                onPressed: onStoreFavoriteTap
                            ),
                          ],
                        ),
                        verticalSpace(1.h),
                        Row(
                          children: [
                            IconButton(
                                onPressed: onStoreOffersTap,
                                icon: const Icon(Icons.local_offer_outlined)
                            ),
                            horizontalSpace(10.w),
                            IconButton(
                                onPressed: onStoreProductFilterTap,
                                icon: const Icon(Icons.filter_alt_outlined)
                            ),
                          ],
                        ),
                      ],
                    ),
                  if(onStoreReviewsTap == null)
                    DefaultIconButton(
                        icon: Icon(
                          homeCubit.isChangedFavouriteIcon ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? ColorsManager.success : ColorsManager.black,),
                        onPressed: onStoreFavoriteTap
                    ),
                ],
              ));
        },
      ),
    );
  }
}
