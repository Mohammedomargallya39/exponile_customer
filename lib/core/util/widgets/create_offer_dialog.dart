import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import '../resources/constants_manager.dart';
import 'default_text.dart';
import 'hideKeyboard.dart';

class CreateOfferDialog extends Dialog {
  final String message;
  final Widget widget;


  const CreateOfferDialog({super.key,
    required this.message,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: HideKeyboardPage(
        child: SizedBox(
          height: 40.h,
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
                    fontSize: 14.rSp,
                    fontWeight: FontWeight.w700,
                ),
                verticalSpace(1.h,),
                widget,

              ],
            ),
          ),
        ),
      ),
    );
  }
}
