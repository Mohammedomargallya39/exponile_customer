import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../../core/util/widgets/default_text.dart';

class OfferStoreDetailsCard extends StatelessWidget {
  const OfferStoreDetailsCard(
      {super.key,
      required this.storeLogo,
      required this.storeName,
      required this.storeCategories,
      required this.storeRate,
      required this.offerPath,
      required this.isFavorite,
      required this.storeAddToFav,
      });
  final String storeLogo;
  final String storeName;
  final String storeCategories;
  final String storeRate;
  final String offerPath;
  final bool isFavorite;
  final Function() storeAddToFav;
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.rSp),
              color: ColorsManager.whiteColor.withOpacity(0.5),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 20.h,
                        margin: EdgeInsets.all(5.rSp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.rSp),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(offerPath),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                              width: 25.w,
                              child: CachedNetworkImage(
                                imageUrl: storeLogo ,
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.contain),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                    height: 15.h,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.rSp),
                                          topRight: Radius.circular(20.rSp)),
                                    ),
                                    child: svgImage(path: Assets.images.svg.noImage)
                                ),
                                placeholder: (context, url) => Container(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),

                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    verticalSpace(1.h),
                                    DefaultText(
                                      title: storeName,
                                      style: Style.medium,
                                      fontSize: 14.rSp,
                                      fontWeight: FontWeight.w700,
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
                              ],
                            ),
                      
                          ],
                        ),
                      ),
                    ),
                    horizontalSpace(2.w),
                  ],
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 22.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.rSp,
                          color: ColorsManager.mainColor,
                        ),
                        color: ColorsManager.success.withOpacity(0.2),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.rSp))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.rSp),
                      child: DefaultText(
                        title: storeCategories,
                        style: Style.small,
                        fontWeight: FontWeight.w700,
                        maxLines: 1,
                        fontSize: 8.rSp,
                        align: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: DefaultIconButton(
                      icon: Icon(
                        homeCubit.isChangedFavouriteIcon ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? ColorsManager.success : ColorsManager.black,),
                      onPressed: storeAddToFav
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
