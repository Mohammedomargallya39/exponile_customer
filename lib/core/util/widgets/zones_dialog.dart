import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'default_text.dart';

class ZonesDialog extends Dialog {
  final Widget widget;
  final String title;

  const ZonesDialog({
    required this.widget,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorsManager.whiteColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: SizedBox(
        height: 40.h,
        width: double.infinity,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultText(
                title: title,
                align: TextAlign.center,
                style: Style.medium,
                fontWeight: FontWeight.w600,
              ),
              verticalSpace(2.h),
              widget
            ],
          ),
        ),
      ),
    );
  }
}
