import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/util/resources/colors_manager.dart';

class CheckOutProductCard extends StatefulWidget {
  const CheckOutProductCard({
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
  State<CheckOutProductCard> createState() => _CheckOutProductCardState();
}

class _CheckOutProductCardState extends State<CheckOutProductCard> {
  String proCount2 = '';
  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);

    if (widget.proCount != 'null') {
      proCount2 = widget.proCount;
    }
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.rSp)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.rSp),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 4,
              child: CachedNetworkImage(
                imageUrl: widget.proImage,
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
          horizontalSpace(2.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.rSp, top: 10.rSp, bottom: 10.rSp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                      title: widget.proName,
                      fontSize: 14.rSp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.mainColor,
                      style: Style.small,
                  ),
                  DefaultText(
                      title: '${widget.proPrice} ${appBloc.translationModel!.currency}',
                      fontSize: 14.rSp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.mainColor,
                      style: Style.small,
                  ),
                  DefaultText(
                      title: '${appBloc.translationModel!.quantity}: ${widget.proCount}',
                      fontSize: 14.rSp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.mainColor,
                      style: Style.small,
                  ),
                  verticalSpace(1.h),
                  horizontalSpace(10.w),
                  widget.proFeat1Value == '' || widget.proFeat1Value == '-' || widget.proFeat1Value == '_'
                      ? Container() :
                  !widget.proFeat1Value.contains('#')?
                  DefaultText(
                      title: widget.proFeat1Value,
                      fontSize: 14.rSp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.mainColor,
                      style: Style.small
                  ):
                  Container(
                    width: 60.rSp,
                    height: 25.rSp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.rSp)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(int.parse('0xff${
                              widget.proFeat1Value.replaceAll('#', '')
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
                          widget.proFeat1Value.replaceAll('#', '')
                      }')),
                    ),
                  ),

                  widget.proFeat2Value == '' || widget.proFeat2Value == '-' || widget.proFeat2Value == '_'
                      ? Container()
                      : !widget.proFeat2Value.contains('#')?
                  DefaultText(
                      title: widget.proFeat2Value,
                      fontSize: 14.rSp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.mainColor,
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
                              widget.proFeat2Value.replaceAll('#', '')
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
                          widget.proFeat2Value.replaceAll('#', '')
                      }')),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
