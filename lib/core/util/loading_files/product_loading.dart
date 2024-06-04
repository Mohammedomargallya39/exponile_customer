import 'package:card_loading/card_loading.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/constants_manager.dart';

class ProductDetailsLoading extends StatelessWidget {
  const ProductDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CardLoading(
              height: 25.h,
              borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
              width: 100.w,
              margin: EdgeInsets.only(bottom: 10.rSp),
            ),
            verticalSpace(1.h),
            CardLoading(
              height: 5.h,
              borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
              width: 100.w,
              margin: EdgeInsets.only(bottom: 10.rSp),
            ),
            verticalSpace(2.h),
            CardLoading(
              height: 5.h,
              borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
              width: 100.w,
              margin: EdgeInsets.only(bottom: 10.rSp),
            ),
            verticalSpace(2.h),
            Row(
              children: [
                Expanded(
                  child: CardLoading(
                    height: 5.h,
                    borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
                    margin: EdgeInsets.only(bottom: 10.rSp),
                  ),
                ),
                horizontalSpace(2.w),
                Expanded(
                  child: CardLoading(
                    height: 5.h,
                    borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
                    margin: EdgeInsets.only(bottom: 10.rSp),
                  ),
                ),
                horizontalSpace(2.w),
                Expanded(
                  child: CardLoading(
                    height: 5.h,
                    borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
                    margin: EdgeInsets.only(bottom: 10.rSp),
                  ),
                ),
              ],
            ),
            verticalSpace(2.h),
            CardLoading(
              height: 5.h,
              borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
              width: 100.w,
              margin: EdgeInsets.only(bottom: 10.rSp),
            ),
            verticalSpace(2.h),
            CardLoading(
              height: 5.h,
              borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
              width: 100.w,
              margin: EdgeInsets.only(bottom: 10.rSp),
            ),
            verticalSpace(2.h),
            CardLoading(
              height: 5.h,
              borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
              width: 100.w,
              margin: EdgeInsets.only(bottom: 10.rSp),
            ),
            verticalSpace(2.h),
            CardLoading(
              height: 5.h,
              borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
              width: 100.w,
              margin: EdgeInsets.only(bottom: 10.rSp),
            ),
          ],
        ),
      ),
    );
  }
}
