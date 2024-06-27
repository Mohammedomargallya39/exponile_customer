import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:flutter/material.dart';

class OrderReceiptProductCard extends StatefulWidget {
  const OrderReceiptProductCard({
    super.key,
    required this.proImage,
    required this.proName,
    required this.proFeat1Name,
    required this.proFeat1Value,
    required this.proFeat2Name,
    required this.proFeat2Value,
    required this.proPrice,
    required this.proCount,
  });

  final String proImage;
  final String proName;
  final String proFeat1Name;
  final String proFeat1Value;
  final String proFeat2Name;
  final String proFeat2Value;
  final String proPrice;
  final String proCount;
  @override
  State<OrderReceiptProductCard> createState() =>
      _OrderReceiptProductCardState();
}

class _OrderReceiptProductCardState extends State<OrderReceiptProductCard> {
  String proCount2 = '';
  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);

    if (widget.proCount != 'null') {
      proCount2 = widget.proCount;
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.5,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.rSp, top: 5.rSp),
                child: Container(
                  height: MediaQuery.of(context).size.height / 4.5,
                  width: MediaQuery.of(context).size.width / 2.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.rSp),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.proImage),
                      fit: BoxFit.fitWidth,
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
                          title: widget.proName,
                          fontSize: 12.rSp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.mainColor,
                          style: Style.small,
                          ),
                      widget.proFeat2Value == ''
                          ? Container()
                          : verticalSpace(1.h),
                      widget.proFeat1Value == ''
                          ? Container()
                          : DefaultText(
                              title:
                                  '${widget.proFeat1Name}  ${widget.proFeat1Value}',
                        fontSize: 12.rSp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.mainColor,
                        style: Style.small,),
                      widget.proFeat2Value == ''
                          ? Container()
                          : verticalSpace(1.h),
                      widget.proFeat2Value == ''
                          ? Container()
                          : DefaultText(
                              title:
                                  '${widget.proFeat2Name}  ${widget.proFeat2Value}',
                        fontSize: 12.rSp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.mainColor,
                        style: Style.small,),
                      DefaultText(
                          title: '${appBloc.translationModel!.quantity}: ${widget.proCount}',
                        fontSize: 12.rSp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.mainColor,
                        style: Style.small,),
                      DefaultText(
                          title: '${widget.proPrice} ${appBloc.translationModel!.currency}',
                        fontSize: 12.rSp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.mainColor,
                        style: Style.small,),
                      verticalSpace(1.h),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
