import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import '../cubit/cubit.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'default_button.dart';
import 'default_text.dart';
import 'hideKeyboard.dart';

class DashboardDialog extends Dialog {
  final VoidCallback productsCategoryButtonVoidCallback;
  final VoidCallback productApprovalStatusButtonVoidCallback;
  final VoidCallback productStatusButtonVoidCallback;
  final VoidCallback productWarehouseButtonVoidCallback;

  const DashboardDialog({
    required this.productApprovalStatusButtonVoidCallback,
    required this.productsCategoryButtonVoidCallback,
    required this.productStatusButtonVoidCallback,
    required this.productWarehouseButtonVoidCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);

    List<String> dashboardFilter =
    [
      appBloc.translationModel!.productsCategory,
      appBloc.translationModel!.productApprovalStatus,
      appBloc.translationModel!.productStatus,
      appBloc.translationModel!.productWarehouse,
    ];
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: ColorsManager.white,
      //this right here
      child: HideKeyboardPage(
        child: SizedBox(
          height: 30.h,
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
                Row(
                  children: [
                    Expanded(
                      child: DefaultButton(
                        onPressed: productsCategoryButtonVoidCallback,
                        text: dashboardFilter[0],
                        fontSize: 10.rSp,
                      ),
                    ),
                    horizontalSpace(2.h),
                    Expanded(
                      child: DefaultButton(
                        onPressed: productApprovalStatusButtonVoidCallback,
                        text: dashboardFilter[1],
                        fontSize: 10.rSp,
                      ),
                    ),
                  ],
                ),
                verticalSpace(2.h),
                Row(
                  children: [
                    Expanded(
                      child: DefaultButton(
                        onPressed: productStatusButtonVoidCallback,
                        text: dashboardFilter[2],
                        fontSize: 10.rSp,
                      ),
                    ),
                    horizontalSpace(2.h),
                    Expanded(
                      child: DefaultButton(
                        onPressed: productWarehouseButtonVoidCallback,
                        text: dashboardFilter[3],
                        fontSize: 10.rSp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
