import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'default_text.dart';

class ProgressDialog extends Dialog {
  final String message;

  const ProgressDialog({
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 20.h,
        color: ColorsManager.white,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultText(
                  title: message,
                  align: TextAlign.center,
                  style: Style.medium,
              ),
              verticalSpace(5.h),
              LinearProgressIndicator(
                backgroundColor: ColorsManager.darkGrey.withOpacity(0.5),
                color: ColorsManager.mainColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
