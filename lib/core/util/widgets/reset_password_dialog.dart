import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/cubit/state.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/core/util/widgets/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../resources/assets.gen.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';

class ResetPasswordDialog extends Dialog {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmNPasswordController;
  final VoidCallback function;

  ResetPasswordDialog({
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.confirmNPasswordController,
    required this.function,
    super.key,
  });
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    return BlocBuilder<AppBloc,AppState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Dialog(
            backgroundColor: ColorsManager.whiteColor,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: SizedBox(
              height: 45.h,
              width: double.infinity,
              child: Padding(
                padding:  EdgeInsets.all(20.rSp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    verticalSpace(1.h),
                    DefaultTextField(
                      controller: oldPasswordController,
                      hint: appBloc.translationModel!.oldPassword,
                      isPassword: true,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'This field is Required';
                        }
                        return null;
                      },
                      svgImg: Assets.images.svg.lock,

                    ),
                    verticalSpace(1.h),
                    DefaultTextField(
                      controller: newPasswordController,
                      hint: appBloc.translationModel!.password,
                      isPassword: true,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }

                        // Check for uppercase letter
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter';
                        }

                        // Check for digit
                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'Password must contain at least one digit';
                        }

                        // Check for special character
                        if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
                          return 'Password must contain at least one special character';
                        }

                        return null;
                      },
                      svgImg: Assets.images.svg.lock,

                    ),
                    verticalSpace(1.h),
                    DefaultTextField(
                      controller: confirmNPasswordController,
                      hint: appBloc.translationModel!.confirmNewPassword,
                      isPassword: true,
                      validate: (String? value) {
                        if (newPasswordController.text != confirmNPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      svgImg: Assets.images.svg.lock,

                    ),


                    verticalSpace(4.h),
                    DefaultButton(
                      text: appBloc.translationModel!.resetPassword,
                      color: ColorsManager.success,
                      onPressed: oldPasswordController.text.isNotEmpty || newPasswordController.text.isNotEmpty || confirmNPasswordController.text.isNotEmpty

                          ?
                      function : (){
                        designToastDialog(
                            context: context,
                            toast: TOAST.warning,
                            text: 'Please, fill your data'
                        );
                      },
                    )

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
