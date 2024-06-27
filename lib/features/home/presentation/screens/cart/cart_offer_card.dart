import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:flutter/material.dart';

class CartOfferCard extends StatefulWidget {
  CartOfferCard({
    super.key,
    required this.offerBanner,
    required this.offerName,
    required this.offerPrice,
    required this.totalPrice,
    required this.offerCount,
    required this.addOnTap,
    required this.subOnTap,
    required this.deleteOnTap,
    required this.offerProductsWidget,
  });

  final String offerBanner;
  final String offerName;
  final String offerPrice;
  final String totalPrice;
  String offerCount;
  final Function() addOnTap;
  final Function() subOnTap;
  final Function() deleteOnTap;
  final Widget offerProductsWidget;

  @override
  State<CartOfferCard> createState() => _CartOfferCardState();
}

class _CartOfferCardState extends State<CartOfferCard> {
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
                  padding: EdgeInsets.only(left: 5.rSp, top: 5.rSp),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.width / 4,
                    child: CachedNetworkImage(
                      imageUrl: widget.offerBanner,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30.rw),
                            bottomLeft: Radius.circular(30.rw),
                            topRight: Radius.circular(30.rh),
                          ),
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
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.rSp, top: 10.rSp, bottom: 10.rSp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                            title: widget.offerName,
                            style: Style.small,
                            fontSize: 12.rSp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.mainColor,
                        ),
                        verticalSpace(1.h),
                        DefaultText(
                            title: '${appBloc.translationModel!.price} ${widget.offerPrice} ${appBloc.translationModel!.currency}',
                            style: Style.small,
                            fontSize: 14.rSp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.mainColor,
                        ),
                        verticalSpace(1.h),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                widget.subOnTap();

                                setState(() {
                                  widget.offerCount =
                                      (int.parse(widget.offerCount) - 1)
                                          .toString();
                                });
                              },
                              child: Container(
                                height: 35.rSp,
                                width: 40.rSp,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5.rSp),
                                      bottomLeft: Radius.circular(5.rSp),
                                    ),
                                    color: ColorsManager.lightGrey
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: ColorsManager.error,
                                  size: 20.rSp,
                                ),
                              ),
                            ),
                            Container(
                              height: 35.rSp,
                              width: 40.rSp,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorsManager.lightGrey, width: 1.rSp)),
                              child: Center(
                                child: DefaultText(
                                    title: widget.offerCount == 'null'
                                        ? offerCount2
                                        : widget.offerCount,
                                    style: Style.small,
                                    fontSize: 14.rSp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManager.mainColor,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                widget.addOnTap();

                                setState(() {
                                  widget.offerCount =
                                      (int.parse(widget.offerCount) - 1)
                                          .toString();
                                });
                              },
                              child: Container(
                                height: 35.rSp,
                                width: 40.rSp,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.rSp),
                                      bottomRight: Radius.circular(5.rSp),
                                    ),
                                    color: ColorsManager.lightGrey,),
                                child: Icon(
                                  Icons.add,
                                  color: ColorsManager.success,
                                  size: 20.rSp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(1.h),
                        DefaultText(
                          title: '${appBloc.translationModel!.total} ${widget.totalPrice} ${appBloc.translationModel!.currency}',
                          style: Style.small,
                          fontSize: 14.rSp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.mainColor,
                        ),
                        verticalSpace(1.h),
                      ],
                    ),
                  ),
                )
              ],
            ),
            widget.offerProductsWidget
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: widget.deleteOnTap,
            child: Container(
              height: 35.rSp,
              width: 50.rSp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.rSp),
                    bottomRight: Radius.circular(10.rSp),
                  ),
                  color: ColorsManager.lightGrey),
              child: Icon(
                Icons.delete_outline,
                color: ColorsManager.error,
                size: 20.rSp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
