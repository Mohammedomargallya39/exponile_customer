import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/features/home/presentation/screens/shop_screen/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../../core/util/cubit/cubit.dart';
import '../../../../../../core/util/resources/assets.gen.dart';
import '../../../../../../core/util/resources/constants_manager.dart';
import '../../../../../../core/util/widgets/default_text.dart';

class StoresCards extends StatelessWidget {
  const StoresCards({super.key,required this.storeLogo,required this.storeName, this.totalOffers,required this.shopID,required this.rates});
  final String storeLogo;
  final String storeName;
  final int? totalOffers;
  final int shopID;
  final String rates;

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Stack(
          children: [
            SizedBox(
              height: 32.h,
              width: 50.w,
              child: CachedNetworkImage(
                imageUrl: storeLogo,
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
            Positioned(
              bottom: 0,
              child: Container(
                  height: 15.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70.rSp),
                      ),
                      color: ColorsManager.lightGrey.withOpacity(0.6)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultText(
                        title: storeName,
                        style: Style.headMedium,
                      //  color: ColorsManager.mainColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.rSp,
                      ),
                      verticalSpace(1.h),
                      if(totalOffers != null)
                        DefaultText(
                          title: "${appBloc.translationModel!.totalOffers} $totalOffers",
                          style: Style.headMedium,
                         // color: ColorsManager.mainColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.rSp,
                        ),
                      RatingBar.builder(
                        initialRating: double.parse(rates),
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

                      verticalSpace(2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: DefaultButton(
                            text: appBloc.translationModel!.seeAll,
                            onPressed: () {
                              navigateTo(context, ShopScreen(
                                  shopID: shopID
                              )
                              );
                            },
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
