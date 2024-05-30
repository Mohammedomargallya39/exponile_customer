import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/core/util/widgets/default_text_field.dart';
import 'package:flutter/material.dart';
import '../resources/assets.gen.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';

class ZonesSettingsDialog extends Dialog {
  final TextEditingController deliveryFeesController;
  final TextEditingController deliveryTimeController;

  const ZonesSettingsDialog({
    required this.deliveryFeesController,
    required this.deliveryTimeController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    return Dialog(
      backgroundColor: ColorsManager.whiteColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: SizedBox(
        height: 40.h,
        width: double.infinity,
        child: Padding(
          padding:  EdgeInsets.all(20.rSp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalSpace(1.h),
              DefaultTextField(
                  controller: deliveryFeesController,
                  hint: appBloc.translationModel!.deliveryFees,
                  isPassword: false,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'This field is Required';
                    }
                    return null;
                  },
                  onChanged: (value){
                    String replacedValue = replaceArabicNumbers(value!);
                    deliveryFeesController.value = TextEditingValue(
                      text: replacedValue,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: replacedValue.length),
                      ),
                    );
                  },
                  svgImg: Assets.images.svg.fees,
                  type: TextInputType.phone,
              ),
              verticalSpace(4.h),
              DefaultTextField(
                controller: deliveryTimeController,
                hint: appBloc.translationModel!.deliveryTime,
                isPassword: false,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'This field is Required';
                  }
                  return null;
                },
                onChanged: (value){
                  String replacedValue = replaceArabicNumbers(value!);
                  deliveryTimeController.value = TextEditingValue(
                    text: replacedValue,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: replacedValue.length),
                    ),
                  );
                },
                svgImg: Assets.images.svg.time,
                type: TextInputType.phone,
              ),

              verticalSpace(4.h),
              DefaultButton(
                  text: appBloc.translationModel!.save,
                  onPressed: (){
                    Navigator.pop(context);
                  },
              ),
              verticalSpace(2.h),
            ],
          ),
        ),
      ),
    );
  }
}
