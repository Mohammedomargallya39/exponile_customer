import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:flutter/material.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({
    super.key,
    required this.itemImage,
    required this.itemName,
    required this.description,
    required this.itemQty,
    required this.itemF1Name,
    required this.itemF2Name,
    required this.itemPrice,
    this.rateOption,
    // required this.itemF1value,
    // required this.itemF2value,
    // required this.ratingOnTap,
    // required this.claimOnTap,
    // required this.removeOnTap,
    // required this.rateBefore,
    // required this.itemStatus,
    //  required this.status,
    // required this.paymentStatus,
    // required this.promoAmount,
    // required this.promo,
    required this.createAt,
    //required this.returnDays,
  });
  final String itemImage;
  final String itemName;
  final String description;
  final int itemQty;
  final String? itemF1Name;
  final String? itemF2Name;
  final String itemPrice;
  final String? createAt;
  final Widget? rateOption;
  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder
        (
          borderRadius: BorderRadius.circular(15.rSp),
          side: BorderSide(
              color: ColorsManager.black.withOpacity(0.7),
              width: 1.rSp
          )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5.5,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: CachedNetworkImage(
                    imageUrl: itemImage ,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                        height: MediaQuery.of(context).size.height / 5.5,
                        width: MediaQuery.of(context).size.width / 2.5,
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.rSp, top: 10.rSp, bottom: 10.rSp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                            title: itemName,
                            fontSize: 14.rSp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.mainColor,
                            align: TextAlign.left,
                            style: Style.small,
                        ),
                        verticalSpace(1.h),
                        DefaultText(
                          title: '${appBloc.translationModel!.quantity} : $itemQty',
                          fontSize: 14.rSp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.mainColor,
                          align: TextAlign.left,
                          style: Style.small,
                        ),
                        verticalSpace(1.h),


                        itemF1Name == '' || itemF1Name == '-' || itemF1Name == '_'
                            ? Container() :
                        !itemF1Name!.contains('#')?
                        DefaultText(
                          title: itemF1Name!,
                          fontSize: 14.rSp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.mainColor,
                          align: TextAlign.left,
                          style: Style.small,
                        ):
                        Container(
                          width: 60.rSp,
                          height: 25.rSp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.rSp)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(int.parse('0xff${
                                    itemF1Name!.replaceAll('#', '')
                                }')),
                                blurRadius: 1.0, // has the effect of softening the shadow
                                spreadRadius: 1.0, // has the effect of extending the shadow
                                offset: const Offset(0.7, 0.7,),
                              )
                            ],
                            border:
                            Border.all(
                                color:  ColorsManager.black,
                                width: 1.5),
                            color: Color(int.parse('0xff${
                                itemF1Name!.replaceAll('#', '')
                            }')),
                          ),
                        ),
                        itemF2Name == '' || itemF2Name == '-' || itemF2Name == '_'
                            ? Container()
                            : !itemF2Name!.contains('#')?
                        DefaultText(
                            title: itemF2Name!,
                            fontSize: 14.rSp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.mainColor,
                            align: TextAlign.left,
                            style: Style.small,
                        ):
                        Container(
                          width: 60.rSp,
                          height: 25.rSp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.rSp)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(int.parse('0xff${
                                    itemF2Name!.replaceAll('#', '')
                                }')),
                                blurRadius: 1.0, // has the effect of softening the shadow
                                spreadRadius: 1.0, // has the effect of extending the shadow
                                offset: const Offset(0.7, 0.7,),
                              )
                            ],
                            border:
                            Border.all(
                                color:  ColorsManager.black,
                                width: 1.5),
                            color: Color(int.parse('0xff${
                                itemF2Name!.replaceAll('#', '')
                            }')),
                          ),
                        ),
                        DefaultText(
                          title: '$itemPrice ${appBloc.translationModel!.currency}',
                          fontSize: 14.rSp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.mainColor,
                          align: TextAlign.left,
                          style: Style.small,
                        ),
                        verticalSpace(1.h),
                      ],
                    ),
                  ),
                )
              ],
            ),
            verticalSpace(1.h),
            DefaultText(
              title: description,
              fontSize: 14.rSp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.mainColor,
              align: TextAlign.left,
              style: Style.small,
            ),
            verticalSpace(1.h),
            if(rateOption != null)
              rateOption!
          ],
        ),
      ),
    );
  }
}
