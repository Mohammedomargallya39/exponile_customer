import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import '../cubit/cubit.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'default_button.dart';
import 'default_text.dart';

class ShopRequestsDialog extends Dialog {
  final VoidCallback pendingRequest;
  final VoidCallback acceptedRequest;
  final VoidCallback rejectedRequest;

  const ShopRequestsDialog({
    required this.pendingRequest,
    required this.acceptedRequest,
    required this.rejectedRequest,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);

    List<String> shopRequestsFilter =
    [
      appBloc.translationModel!.pending,
      appBloc.translationModel!.rejected,
      appBloc.translationModel!.success,
    ];
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: ColorsManager.white,
      //this right here
      child: SizedBox(
        height: 35.h,
        width: double.infinity,
        child: Padding(
          padding:  EdgeInsets.all(5.rSp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultText(
                title: appBloc.translationModel!.filter,
                align: TextAlign.center,
                style: Style.medium,
                fontWeight: FontWeight.w600,
                fontSize: 16.rSp,
              ),
              verticalSpace(4.h),
              DefaultButton(
                onPressed: pendingRequest,
                text: shopRequestsFilter[0],
                fontSize: 10.rSp,
                color: ColorsManager.warning,
              ),
              verticalSpace(2.h),
              DefaultButton(
                onPressed: acceptedRequest,
                text: shopRequestsFilter[2],
                fontSize: 10.rSp,
                color: ColorsManager.success,
              ),
              verticalSpace(2.h),
              DefaultButton(
                onPressed: rejectedRequest,
                text: shopRequestsFilter[1],
                fontSize: 10.rSp,
                color: ColorsManager.error,
              ),
              verticalSpace(2.h),
            ],
          ),
        ),
      ),
    );
  }
}
