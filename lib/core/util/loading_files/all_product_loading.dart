import 'package:card_loading/card_loading.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../resources/constants_manager.dart';

class AllProductsLoading extends StatelessWidget {
  const AllProductsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: AnimationLimiter(
          child: Column(
            children: [
              SizedBox(
                height: 71.h,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 5.w,
                            crossAxisSpacing: 2.w,
                            mainAxisExtent: 40.h,
                            mainAxisSpacing: 2.h
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: index,
                            duration: const Duration(milliseconds: 1000),
                            child: ScaleAnimation(
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.fastLinearToSlowEaseIn,
                              scale: 1.5,
                              child: FadeInAnimation(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                                    child: Column(
                                      children: [
                                        CardLoading(
                                          height: 20.h,
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
                                        verticalSpace(1.h),
                                        CardLoading(
                                          height: 5.h,
                                          borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
                                          width: 100.w,
                                          margin: EdgeInsets.only(bottom: 10.rSp),
                                        ),
                                        verticalSpace(1.h),
                                        CardLoading(
                                          height: 2.h,
                                          borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
                                          width: 100.w,
                                          margin: EdgeInsets.only(bottom: 10.rSp),
                                        ),
                                      ],
                                    ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      verticalSpace(2.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
