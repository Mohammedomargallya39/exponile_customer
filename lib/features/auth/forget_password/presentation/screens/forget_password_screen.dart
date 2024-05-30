import 'dart:async';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/core/util/widgets/progress.dart';
import 'package:exponile_customer/features/auth/login/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/cubit/state.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/widgets/default_button.dart';
import '../../../../../core/util/widgets/default_text_field.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../controller/forget_password_cubit.dart';
import '../controller/forget_password_states.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ForgetPasswordCubit forgetPasswordCubit = ForgetPasswordCubit.get(context);
    return BlocBuilder<AppBloc,AppState>(
      builder: (context, state) {
        AppBloc appBloc = AppBloc.get(context);
        return Directionality(
          textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: MainAppBar(
              title: appBloc.translationModel!.forgetPasswordScreen,
              isBack: true,
              isLang: true,
            ),
            body: BlocConsumer<ForgetPasswordCubit,ForgetPasswordStates>(
              listener: (context, state) {
                if(state is ForgetPasswordSuccessState) {
                  Navigator.pop(context);
                  designToastDialog(
                      context: context,
                      toast: state.forgetPasswordEntity.success == 1? TOAST.success : TOAST.warning,
                      text: state.forgetPasswordEntity.message!
                  );
                }
                if(state is ForgetPasswordErrorState) {
                  Navigator.pop(context);
                  designToastDialog(
                      context: context,
                      toast: TOAST.success,
                      text: state.failure);
                }
                if(state is ForgetPasswordLoadingState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ProgressDialog(message: appBloc.translationModel!.loading);
                    },
                  );
                }
                if(state is OTPSuccessState) {
                  Navigator.pop(context);
                  designToastDialog(
                      context: context,
                      toast: state.otpEntity.success == 1? TOAST.success : TOAST.warning,
                      text: state.otpEntity.message!
                  );
                }
                if(state is OTPErrorState) {
                  Navigator.pop(context);
                  designToastDialog(
                      context: context,
                      toast: TOAST.success,
                      text: state.failure);
                }
                if(state is OTPLoadingState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ProgressDialog(message: appBloc.translationModel!.loading);
                    },
                  );
                }
                if(state is ResetPasswordSuccessState) {
                  Navigator.pop(context);
                  navigateAndFinish(context, LoginScreen());
                  designToastDialog(
                      context: context,
                      toast: state.resetPasswordEntity.success == 1? TOAST.success : TOAST.warning,
                      text: state.resetPasswordEntity.message!
                  );
                }
                if(state is ResetPasswordErrorState) {
                  Navigator.pop(context);
                  designToastDialog(
                      context: context,
                      toast: TOAST.success,
                      text: state.failure);
                }
                if(state is ResetPasswordLoadingState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ProgressDialog(message: appBloc.translationModel!.loading);
                    },
                  );
                }
              },
              builder: (context, state) {
                return HideKeyboardPage(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          children: [
                            Center(
                              child: Image.asset(
                                Assets.images.png.logo,
                                height: 30.h,
                                width: 60.w,
                              ),
                            ),
                            verticalSpace(5.h),
                            if(!forgetPasswordCubit.isSentCode && !forgetPasswordCubit.isFilledCode)
                              DefaultTextField(
                                onChanged: (value){
                                  String replacedValue = replaceArabicNumbers(value!);
                                  emailController.value = TextEditingValue(
                                    text: replacedValue,
                                    selection: TextSelection.fromPosition(
                                      TextPosition(offset: replacedValue.length),
                                    ),
                                  );
                                },
                                isPassword: false,
                                validate: (String? value) {
                                  bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value!);
                                  if (value.isEmpty) {
                                    return appBloc.translationModel!.requiredField;
                                  } else if (!emailValid) {
                                    return appBloc.translationModel!.emailFormatValidation;
                                  }
                                  return null;
                                },
                                controller: emailController,
                                hint: appBloc.translationModel!.email,
                                svgImg: Assets.images.svg.email,
                              ),
                            if(forgetPasswordCubit.isSentCode && !forgetPasswordCubit.isFilledCode)
                              PinCodeTextField(
                                appContext: context,
                                length: 6,
                                pastedTextStyle: TextStyle(
                                  color: ColorsManager.green.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                ),
                                obscureText: true,
                                obscuringCharacter: '*',
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                validator: (v) {
                                  if (v!.length < 6) {
                                    return appBloc.translationModel!.requiredField;
                                  } else {
                                    return null;
                                  }
                                },
                                pinTheme: PinTheme(
                                    activeColor: ColorsManager.black,
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 5.h,
                                    fieldWidth: 10.w,
                                    activeFillColor: Colors.white,
                                    inactiveFillColor: Colors.white,
                                    selectedFillColor: Colors.white
                                ),
                                cursorColor: Colors.black,
                                animationDuration: const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                errorAnimationController: errorController,
                                controller: otpController,
                                keyboardType: TextInputType.number,
                                boxShadows: const [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                            if(forgetPasswordCubit.isSentCode && forgetPasswordCubit.isFilledCode)
                              BlocBuilder<AppBloc,AppState>(
                                builder: (context, state) {
                                  AppBloc appBloc = AppBloc.get(context);
                                  return Column(
                                    children: [
                                      DefaultTextField(
                                        onChanged: (value){
                                          String replacedValue = replaceArabicNumbers(value!);
                                          passwordController.value = TextEditingValue(
                                            text: replacedValue,
                                            selection: TextSelection.fromPosition(
                                              TextPosition(offset: replacedValue.length),
                                            ),
                                          );
                                        },
                                        validate: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return appBloc.translationModel!.requiredField;
                                          }
                                          if (value.length < 8) {
                                            return appBloc.translationModel!.lengthPassword;
                                          }

                                          // Check for uppercase letter
                                          if (!value.contains(RegExp(r'[A-Z]'))) {
                                            return appBloc.translationModel!.passwordFirstValidation;
                                          }

                                          // Check for digit
                                          if (!value.contains(RegExp(r'[0-9]'))) {
                                            return appBloc.translationModel!.passwordSecondValidation;
                                          }

                                          // Check for special character
                                          if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
                                            return appBloc.translationModel!.passwordThirdValidation;
                                          }

                                          return null;
                                        },
                                        controller: passwordController,
                                        hint: appBloc.translationModel!.password,
                                        isPassword: appBloc.showPassword,
                                        svgImg: Assets.images.svg.lock,
                                        suffixIcon: IconButton(
                                          icon: Icon(appBloc.visibilityShowPassword),
                                          onPressed: () {
                                            debugPrintFullText(appBloc.showPassword.toString());
                                            appBloc.changePasswordVisibility();
                                          },
                                        ),
                                      ),
                                      DefaultTextField(
                                        onChanged: (value){
                                          String replacedValue = replaceArabicNumbers(value!);
                                          confirmPasswordController.value = TextEditingValue(
                                            text: replacedValue,
                                            selection: TextSelection.fromPosition(
                                              TextPosition(offset: replacedValue.length),
                                            ),
                                          );
                                        },
                                        validate: (String? value) {
                                          if (confirmPasswordController.value.text != passwordController.text) {
                                            return appBloc.translationModel!.passwordConfirmationValidation;
                                          }

                                          return null;
                                        },
                                        controller: confirmPasswordController,
                                        hint: appBloc.translationModel!.confirmPassword,
                                        isPassword: appBloc.showConfirmPassword,
                                        svgImg: Assets.images.svg.lock,
                                        suffixIcon: IconButton(
                                          icon: Icon(appBloc.visibilityShowConfirmPassword),
                                          onPressed: () {
                                            debugPrintFullText(appBloc.showConfirmPassword.toString());
                                            appBloc.changeConfirmPasswordVisibility();
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            verticalSpace(5.h),
                            DefaultButton(
                              text: forgetPasswordCubit.isSentCode && forgetPasswordCubit.isFilledCode ? appBloc.translationModel!.change:
                              appBloc.translationModel!.send,
                              onPressed: () async {
                                if(!forgetPasswordCubit.isSentCode && !forgetPasswordCubit.isFilledCode)
                                {
                                  if (formKey.currentState!.validate()) {
                                    forgetPasswordCubit.forgetPassword(
                                        email: emailController.text
                                    );
                                  } else {
                                    designToastDialog(
                                        context: context,
                                        toast: TOAST.warning,
                                        text: appBloc.translationModel!.fillData
                                    );
                                  }
                                }

                                if(forgetPasswordCubit.isSentCode && !forgetPasswordCubit.isFilledCode)
                                {
                                  if (formKey.currentState!.validate()) {
                                    forgetPasswordCubit.verifyOTP(
                                      email: emailController.text,
                                      otp: otpController.text,
                                    );
                                  } else {
                                    designToastDialog(
                                        context: context,
                                        toast: TOAST.warning,
                                        text: appBloc.translationModel!.fillData
                                    );
                                  }
                                }

                                if(forgetPasswordCubit.isSentCode && forgetPasswordCubit.isFilledCode)
                                {
                                  if (formKey.currentState!.validate()) {
                                    forgetPasswordCubit.resetPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        confirmPassword: confirmPasswordController.text
                                    );
                                  } else {
                                    designToastDialog(
                                        context: context,
                                        toast: TOAST.warning,
                                        text: appBloc.translationModel!.fillData
                                    );
                                  }
                                }

                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}