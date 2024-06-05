import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:flutter/material.dart';

class StoreOffersCard extends StatelessWidget {
  const StoreOffersCard({
    super.key,
    required this.offerBannerPath,
    required this.offerTitle,
    required this.onSeeMoreTap,
  });
  final String offerBannerPath;
  final String offerTitle;
  final Function() onSeeMoreTap;

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: InkWell(
        onTap: () {},
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.rSp)),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 2,
                    child: CachedNetworkImage(
                      imageUrl: offerBannerPath ,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.contain),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 2,
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
                  Padding(
                    padding: EdgeInsets.only(left: 5.rSp, right: 5.rSp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DefaultText(
                            title: offerTitle,
                            style: Style.medium,
                          fontSize: 16.rSp,
                          maxLines: 1,
                          color: ColorsManager.mainColor,
                          fontWeight: FontWeight.w700
                        ),
                        verticalSpace(1.h),
                        DefaultButton(
                            text: appBloc.translationModel!.seeAll,
                            onPressed: onSeeMoreTap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
