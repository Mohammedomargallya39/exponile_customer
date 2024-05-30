import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/core/util/widgets/default_text_field.dart';
import 'package:flutter/material.dart';
import '../resources/assets.gen.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'hideKeyboard.dart';

class DeleteAccountDialog extends Dialog {
  final TextEditingController textEditingController;
  final VoidCallback function;

  const DeleteAccountDialog({
    required this.textEditingController,
    required this.function,
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
      child: HideKeyboardPage(
        child: SizedBox(
          height: 30.h,
          width: double.infinity,
          child: Padding(
            padding:  EdgeInsets.all(20.rSp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSpace(1.h),
                DefaultTextField(
                    controller: textEditingController,
                    hint: appBloc.translationModel!.password,
                    isPassword: false,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'This field is Required';
                      }
                      return null;
                    },
                     svgImg: Assets.images.svg.lock,

                ),
                verticalSpace(4.h),
                DefaultButton(
                    text: appBloc.translationModel!.deleteAccount,
                    color: ColorsManager.error,
                    onPressed: function,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
