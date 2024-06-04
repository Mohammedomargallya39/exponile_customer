import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/widgets/default_text.dart';


class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imagePath,
    required this.imagesCount,
    required this.category,
    required this.name,
    required this.newPrice,
    required this.rate,
    required this.ratingCount,
    required this.onProductTap,
    required this.onFavoriteTap,
    required this.isFavourite,
  });
  final String imagePath;
  final int imagesCount;
  final String category;
  final String name;
  final String rate;
  final int ratingCount;
  final String newPrice;
  final Function() onProductTap;
  final Function() onFavoriteTap;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.rSp)
          ),
          border: Border.all(
            width: 1.rSp,
            color: ColorsManager.black,
          )
        ),
        child: InkWell(
            onTap: onProductTap,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                      width: 50.w,
                      child: CarouselSlider.builder(
                        itemCount: imagesCount,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageIndex) =>
                        SizedBox(
                          child: CachedNetworkImage(
                            imageUrl: imagePath ,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.contain),
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: SizedBox(
                          height:15.h,
                          width: 50.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                title: category,
                                fontSize: 10.rSp,
                                fontWeight: FontWeight.w700,
                                color: ColorsManager.black,
                                style: Style.medium ,
                              ),
                              verticalSpace(1.h),
                              DefaultText(
                                title: name,
                                fontSize: 10.rSp,
                                fontWeight: FontWeight.w700,
                                color: ColorsManager.black,
                                style: Style.medium ,
                              ),
                              verticalSpace(1.h),
                              DefaultText(
                                title: '$newPrice ${appBloc.translationModel!.currency}',
                                fontSize: 10.rSp,
                                fontWeight: FontWeight.w700,
                                color: ColorsManager.black,
                                style: Style.medium ,
                              ),
                              verticalSpace(1.h),
                              RatingBar.builder(
                                initialRating:  double.parse(rate),
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
                          )),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 3,
                  child:
                  DefaultIconButton(
                      icon: !isFavourite?
                      const Icon(Icons.favorite_border) : const Icon(Icons.favorite,color: ColorsManager.success),
                      onPressed: onFavoriteTap
                  )
                  // favoriteButton(
                  //   onPress: onFavoriteTap,
                  //   radius: BorderRadius.circular(10.rSp),
                  //   width: 55.rSp,
                  //   isFavorite: false,
                  // ),
                ),
              ],
            )),
      ),
    );
  }
}