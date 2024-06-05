import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';

class BuyGetProductCard extends StatelessWidget {
  const BuyGetProductCard(
      {super.key,
      required this.productImagePath,
      required this.productName,
      required this.productPrice,
      required this.getProductPrice,
      required this.isGet,
      required this.onDeleteTap});
  final String productImagePath;
  final String productName;
  final String productPrice;
  final String getProductPrice;
  final bool isGet;
  final  Function() onDeleteTap;
  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width / 2,
                child: CachedNetworkImage(
                  imageUrl: productImagePath ,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                      title: productName,
                      style: Style.medium,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.rSp,
                  ),
                  verticalSpace(1.h),
                  isGet == true
                      ? Row(
                          children: [
                            DefaultText(
                              title: '0.00 ${appBloc.translationModel!.currency} ',
                              style: Style.medium,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.rSp,
                            ),
                            DefaultText(
                              title: productPrice,
                              style: Style.medium,
                              fontWeight: FontWeight.w700,
                              fontSize: isGet == true ? 14.rSp : 16.rSp,
                              color: isGet == true ? ColorsManager.darkGrey : ColorsManager.mainColor,
                            ),
                          ],
                        )
                      :
                  DefaultText(
                    title: productPrice,
                    style: Style.medium,
                    fontWeight: FontWeight.w700,
                    fontSize: isGet == true ? 14.rSp : 16.rSp,
                    color: isGet == true ? ColorsManager.darkGrey : ColorsManager.mainColor,
                  ),
                  verticalSpace(1.h),
                  // button(
                  //     text: localization.selected,
                  //     isUpperCase: false,
                  //     onPress: () {},
                  //     radius: 5.rSp,
                  //     width: 130.rSp,
                  //     fontSize: 11.rSp,
                  //     height: 40.rSp),
                ],
              ),
            ],
          ),
          Positioned(
              top: 5,
              left: 5,
              child: DefaultIconButton(
              icon:const Icon(Icons.delete, color: ColorsManager.error),
                  onPressed: onDeleteTap
              ),
          )
        ],
      ),
    );
  }
}
