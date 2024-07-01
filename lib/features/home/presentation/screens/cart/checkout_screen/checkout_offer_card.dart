import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/util/resources/assets.gen.dart';
import '../../../../../../core/util/resources/colors_manager.dart';

class CheckOutOfferCard extends StatefulWidget {
  const CheckOutOfferCard({
    super.key,
    required this.offerBanner,
    required this.offerName,
    required this.offerPrice,
    required this.offerCount,
    required this.offerProductsWidget,
  });

  final String offerBanner;
  final String offerName;
  final String offerPrice;
  final String offerCount;
  final Widget offerProductsWidget;

  @override
  State<CheckOutOfferCard> createState() => _CheckOutOfferCardState();
}

class _CheckOutOfferCardState extends State<CheckOutOfferCard> {
  String offerCount2 = '';

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);

    if (widget.offerCount != 'null') {
      offerCount2 = widget.offerCount;
    }

    return Stack(
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 5.rSp, top: 5.rSp, bottom: 5.rSp),
                    child: CachedNetworkImage(
                      imageUrl: widget.offerBanner,
                      imageBuilder: (context, imageProvider) => Container(
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width / 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.rSp),
                            bottomLeft: Radius.circular(20.rSp),
                            bottomRight: Radius.circular(20.rSp),
                          ),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(widget.offerBanner),
                              fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                          height: MediaQuery.of(context).size.height / 12,
                          width: MediaQuery.of(context).size.width / 6,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          ),
                          child: svgImage(path: Assets.images.svg.noImage)
                      ),
                      placeholder: (context, url) => Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      fit: BoxFit.fill,
                      memCacheHeight: 300,
                      memCacheWidth: 300,
                    )
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.rSp, top: 10.rSp, bottom: 10.rSp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                            title: widget.offerName,
                            fontSize: 14.rSp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.mainColor,
                            style: Style.small,
                        ),
                        verticalSpace(1.h),
                        DefaultText(
                            title: '${widget.offerPrice} ${appBloc.translationModel!.currency}',
                            fontSize: 14.rSp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.mainColor,
                            style: Style.small,
                        ),
                        verticalSpace(1.h),
                        DefaultText(
                            title: '${appBloc.translationModel!.quantity}: ${widget.offerCount}',
                            fontSize: 14.rSp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.mainColor,
                            style: Style.small,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            widget.offerProductsWidget
          ],
        ),
      ],
    );
  }
}