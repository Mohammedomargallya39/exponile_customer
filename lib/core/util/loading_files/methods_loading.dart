import 'package:card_loading/card_loading.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';

class MethodsLoading extends StatelessWidget {
  const MethodsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
      child: AnimationLimiter(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 1000),
              child: ScaleAnimation(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastLinearToSlowEaseIn,
                scale: 1.5,
                child: FadeInAnimation(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: ColorsManager.lightGrey.withOpacity(0.5),
                            border: Border.all(
                              color: ColorsManager.black.withOpacity(0.3),
                              width: 0.5.rSp,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10.rSp))
                        ),
                        child: CardLoading(
                          height: 5.h,
                          borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
                          width: 100.w,
                          margin: EdgeInsets.only(bottom: 10.rSp),
                        ),
                      ),
                      verticalSpace(3.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
