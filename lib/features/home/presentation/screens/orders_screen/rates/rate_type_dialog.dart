import 'dart:developer';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:exponile_customer/features/home/presentation/screens/orders_screen/rates/rates.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../core/util/resources/assets.gen.dart';

class RateDialogWidget extends StatefulWidget {
  const RateDialogWidget({super.key,this.orderId,this.productId,this.storeId});

  final int? orderId;
  final int? productId;
  final int? storeId;
  @override
  _RateDialogWidgetState createState() => _RateDialogWidgetState();
}

class _RateDialogWidgetState extends State<RateDialogWidget> {
  int _selectedIndex = -1;

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final ScrollController _firstController = ScrollController();


  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    String rateImage= Assets.images.lotti.rate;
    List<String> titles= [appBloc.translationModel!.rateStore,appBloc.translationModel!.rateProduct];

    return Dialog(
      backgroundColor: ColorsManager.whiteColor,
      insetPadding: const EdgeInsets.all(1),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 1.5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultText(
                    title: appBloc.translationModel!.select,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.rSp,
                    style: Style.extraSmall,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 5.w,
                      height: 2.5.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.mainColor,
                        borderRadius: BorderRadius.circular(25.rSp),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20.rSp,
                      ),
                    ),
                  )
                ],
              ),
              verticalSpace(3.h),

              Lottie.asset(
                rateImage,
                height: MediaQuery.of(context).size.width / 10,
              ),
              verticalSpace(3.h),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                child:  ListView.builder(
                    controller: _firstController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          _onSelected(index);
                          log(_selectedIndex.toString());
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.rSp),
                          width: MediaQuery.of(context).size.width / 1.8,
                          //height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: _selectedIndex == index
                                ? ColorsManager.darkGrey.withOpacity(.3)
                                : ColorsManager.lightGrey.withOpacity(.2),
                            shape: BoxShape.rectangle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DefaultText(
                                title: titles[index],
                                fontWeight: FontWeight.bold,
                                fontSize: 16.rSp,
                                style: Style.small,
                              ),
                              verticalSpace(3.h),
                              DefaultButton(
                                onPressed: () async {
                                  _onSelected(index);
                                  log(_selectedIndex.toString());
                                  setState(() {});
                                },
                                text: appBloc.translationModel!.select,
                                width: 0.2.rSp,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              const Spacer(),
              DefaultButton(
                  onPressed: () async {
                    //Navigator.pop(context);
                    if (_selectedIndex != 0) {
                      log('product');
                      showProductRateDialog(context, orderNumber: widget.orderId!, productId: widget.productId!);

                    } else {
                      log('store');
                      showStoreRateDialog(context, orderNumber: widget.orderId!, storeId: widget.storeId!);
                    }
                  },
                  text: appBloc.translationModel!.next
              ),
            ],
          ),
        ),
      ),
    );
  }
}