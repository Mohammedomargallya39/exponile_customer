import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:flutter/material.dart';


class OrderReceiptOfferCard extends StatefulWidget {
  const OrderReceiptOfferCard({
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
  State<OrderReceiptOfferCard> createState() => _OrderReceiptOfferCardState();
}

class _OrderReceiptOfferCardState extends State<OrderReceiptOfferCard> {
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
                  child: Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.rSp),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.offerBanner),
                        fit: BoxFit.fill,
                      ),
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
                            fontSize: 12.rSp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.mainColor,
                            style: Style.small,
                        ),
                        verticalSpace(2.h),
                        DefaultText(
                            title: '${widget.offerPrice} ${appBloc.translationModel!.currency}',
                            fontSize: 12.rSp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.mainColor,
                            style: Style.small,
                        ),
                        verticalSpace(2.h),
                        DefaultText(
                            title: '${appBloc.translationModel!.quantity}: ${widget.offerCount}',
                            fontSize: 12.rSp,
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
