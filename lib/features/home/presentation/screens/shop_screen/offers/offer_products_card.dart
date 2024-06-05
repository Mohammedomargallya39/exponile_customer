import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

class OfferProductsCard extends StatelessWidget {
  const OfferProductsCard(
      {super.key,
      required this.productImage,
      required this.productCategory,
      required this.productName,
      required this.offerType,
      required this.offers,
      required this.value,
      required this.oldPrice,
      required this.productRate,
      required this.productRateNumber,
      required this.percentageValue,
      required this.isFavorite,
      required this.onProductTap,
      //required this.onAddProductTap,
      required this.onFavoriteTap});
  final String productImage;
  final String productCategory;
  final String productName;
  final int offerType;
  final List offers;
  final int value;
  final String oldPrice;
  final String productRate;
  final int productRateNumber;
  final String percentageValue;
  final bool isFavorite;
  final Function() onProductTap;
  //Function() onAddProductTap;
  final Function() onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);

    return InkWell(
      onTap: onProductTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.rSp), topRight: Radius.circular(15.rSp))),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4.5,
                  width: MediaQuery.of(context).size.width / 2,
                  child: CarouselSlider.builder(
                    itemCount: 2,
                    itemBuilder:
                        (BuildContext context, int itemIndex, int pageIndex) =>
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: productImage ,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.contain),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width,
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
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 4.5,
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
                  padding: EdgeInsets.symmetric(horizontal: 5.rSp),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.rSp, vertical: 5.rSp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.rSp),
                              child: DefaultText(
                                  title: productCategory,
                                  style: Style.small,
                                  fontSize: 10.rSp,
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                            verticalSpace(1.h),
                            DefaultText(
                              title: productName,
                              style: Style.small,
                              fontSize: 10.rSp,
                              fontWeight: FontWeight.bold,
                            ),
                            verticalSpace(1.h),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.rSp),
                              child: Row(
                                children: [
                                  if(offers.isNotEmpty)
                                  Row(
                                          children: [
                                            DefaultText(
                                              title: offerType == 2
                                                  ? oldPrice
                                                  : (double.parse(oldPrice) -
                                                  ((double.parse(value
                                                      .toString()) /
                                                      100) *
                                                      double.parse(
                                                          oldPrice)))
                                                  .toStringAsFixed(2)
                                                  .toString(),
                                              style: Style.small,
                                              fontSize: 10.rSp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            DefaultText(
                                              title: '${appBloc.translationModel!.currency}, ',
                                              style: Style.small,
                                              fontSize: 10.rSp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                  
                                  if(offerType != 2 && offers.isEmpty)
                                    Row(
                                      children: [
                                        DefaultText(
                                          title: oldPrice,
                                          style: Style.small,
                                          fontSize: 10.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: offers.isNotEmpty
                                              ? ColorsManager.darkGrey
                                              : ColorsManager.mainColor,
                                        ),
                                        DefaultText(
                                          title: '${appBloc.translationModel!.currency},',
                                          style: Style.small,
                                          fontSize: 10.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: offers.isNotEmpty
                                              ? ColorsManager.darkGrey
                                              : ColorsManager.mainColor,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: double.parse(productRate),
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
                                DefaultText(
                                  title: '(${productRateNumber.toString()})',
                                  style: Style.small,
                                  fontSize: 10.rSp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.darkGrey
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              child: percentageValue == ''
                  ? Container()
                  : Container(
                      height: 30.rSp,
                      width: 60.rSp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.rSp),
                            bottomLeft: Radius.circular(15.rSp),
                          ),
                          color: ColorsManager.mainColor),
                      child: Center(
                        child: Text(
                          percentageValue,
                          style: TextStyle(
                              color: ColorsManager.whiteColor,
                              fontSize: 12.rSp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
            ),
            offerType == 1
                ? Positioned(
                    top: 5,
                    right: 5,
                    child: DefaultIconButton(
                    icon: Icon(isFavorite? Icons.favorite : Icons.favorite_border),
                    onPressed: onFavoriteTap
                  ),
                  )
                : Positioned(
                  top: 5,
                  left: 5,
                  child: DefaultIconButton(
                      icon: Icon(isFavorite? Icons.favorite : Icons.favorite_border),
                      onPressed: onFavoriteTap
                  ),
            )
          ],
        ),
      ),
    );
  }
}
