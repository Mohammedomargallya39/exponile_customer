import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'default_button.dart';
import 'default_text.dart';

class VersionDialog extends Dialog {
  final String message;
  final VoidCallback? pushButtonVoidCallback;
  final VoidCallback? popButtonVoidCallback;

  const VersionDialog({
    required this.message,
    this.pushButtonVoidCallback,
    this.popButtonVoidCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    return Dialog(
      backgroundColor: ColorsManager.whiteColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        height: 17.h,
        width: double.infinity,
        child: Padding(
          padding:  EdgeInsets.all(20.rSp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultText(
                  title: message,
                align: TextAlign.center,
                style: Style.medium,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                fontSize: 14.rSp,
              ),
              const Spacer(),
              Row(
                children: [
                  if(popButtonVoidCallback != null)
                  Expanded(
                    child: DefaultButton(
                      onPressed: popButtonVoidCallback,
                      text: appBloc.translationModel!.later,
                      fontSize: 16.rSp,
                      color: ColorsManager.mainColor,
                    ),
                  ),
                  if(pushButtonVoidCallback != null)
                  horizontalSpace(2.h),
                  if(pushButtonVoidCallback != null)
                    Expanded(
                    child: DefaultButton(
                      onPressed: pushButtonVoidCallback,
                      text: appBloc.translationModel!.update,
                      fontSize: 16.rSp,
                      color: ColorsManager.mainColor,
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
