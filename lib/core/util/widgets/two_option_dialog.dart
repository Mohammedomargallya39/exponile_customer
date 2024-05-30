import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'default_button.dart';
import 'default_text.dart';

class TwoOptionsDialog extends Dialog {
  final String message;
  final String pushButtonText;
  final String popButtonText;
  final VoidCallback pushButtonVoidCallback;
  final VoidCallback popButtonVoidCallback;
  final double height;
  final Color? color;
  final Color? colorEdit;

  const TwoOptionsDialog({
    required this.message,
    required this.popButtonText,
    required this.pushButtonText,
    required this.pushButtonVoidCallback,
    required this.popButtonVoidCallback,
    this.height = 160.0,
    this.color = ColorsManager.mainColor,
    this.colorEdit = ColorsManager.mainColor,
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
        height: height,
        width: double.infinity,
        child: Padding(
          padding:  EdgeInsets.all(20.rSp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultText(
                  title: message, align: TextAlign.center, style: Style.medium, fontWeight: FontWeight.w600,),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: DefaultButton(
                      onPressed: popButtonVoidCallback,
                      text: popButtonText,
                      fontSize: 16.rSp,
                      color: color!,
                    ),
                  ),
                  horizontalSpace(2.h),
                  Expanded(
                    child: DefaultButton(
                      onPressed: pushButtonVoidCallback,
                      text: pushButtonText,
                      fontSize: 16.rSp,
                      color: colorEdit!,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
