import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CartProductCard extends StatefulWidget {
  CartProductCard({
    super.key,
    required this.proImage,
    required this.proName,
    required this.proFeat1Name,
    required this.proFeat1Value,
    required this.proFeat2Name,
    required this.proFeat2Value,
    required this.proPrice,
    required this.proCount,
    required this.addOnTap,
    required this.subOnTap,
    required this.deleteOnTap,
    //required this.favOnTap,
  });

  final String proImage;
  final String proName;
  final String proFeat1Name;
  final String proFeat1Value;
  final String proFeat2Name;
  final String proFeat2Value;
   String proPrice;
   String proCount;
  final Function() addOnTap;
  final Function() subOnTap;
  final Function() deleteOnTap;
  //Function() favOnTap;

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  String proCount2 = '';
  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    if (widget.proCount != 'null') {
      proCount2 = widget.proCount;
    }
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.rSp)),
      child: Stack(
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
                  padding: EdgeInsets.only(left: 10.rSp, top: 3.h, bottom: 3.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                  title: widget.proName,
                                  fontSize: 12.rSp,
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
                              verticalSpace(1.h),
                            ],
                          ),
                          horizontalSpace(3.w),
                          Column(children: [
                            widget.proFeat1Value == '' || widget.proFeat1Value == '-' || widget.proFeat1Value == '_'
                                ? Container()
                                :
                            !widget.proFeat1Value.contains('#')?
                            DefaultText(
                                title: widget.proFeat1Value,
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
                                fontSize: 12.rSp,
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
                          ],)
                        ],
                      ),


                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: widget.proCount == '1'
                                ? widget.deleteOnTap
                                : () {
                                    widget.subOnTap();

                                    setState(() {
                                      widget.proCount =
                                          (int.parse(widget.proCount) - 1)
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
                                  color: ColorsManager.lightGrey),
                              child: Icon(
                                widget.proCount == '1'
                                    ? Icons.delete
                                    : Icons.remove,
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
                                  title: widget.proCount == 'null'
                                      ? proCount2
                                      : widget.proCount,
                                  fontSize: 14.rSp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.mainColor,
                                  style: Style.small,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.addOnTap();

                              setState(() {
                                widget.proCount =
                                    (int.parse(widget.proCount) + 1)
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
                                  color: ColorsManager.lightGrey),
                              child: Icon(
                                Icons.add,
                                color: ColorsManager.success,
                                size: 20.rSp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: widget.deleteOnTap,
              child: Container(
                height: 35.rSp,
                width: 50.rSp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.rSp),
                      bottomLeft: Radius.circular(10.rSp),
                      bottomRight: Radius.circular(10.rSp),
                    ),
                    color: ColorsManager.lightGrey),
                child: Icon(
                  Icons.delete_outline,
                  color: ColorsManager.error,
                  size: 25.rSp,
                ),
              ),
            ),
          ),
         /* Positioned(
            top: 30,
            right: 0,
            child: InkWell(
              onTap: widget.favOnTap,
              child: Container(
                height: 35,
                width: 50,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: statusBarColor),
                child: const Icon(
                  Icons.favorite_border,
                  color: whiteClr,
                  size: 20,
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
