import 'package:exponile_customer/core/network/remote/api_endpoints.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:exponile_customer/features/auth/login/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/cubit/state.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_button.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/default_text_field.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../../../../core/util/widgets/loading_page.dart';
import '../../../../../core/util/widgets/main_appbar.dart';
import '../../../../../core/util/widgets/progress.dart';
import '../../../login/presentation/controller/login_states.dart';
import '../controller/register_cubit.dart';
import '../controller/register_states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController mobileNumberController = TextEditingController();

  final TextEditingController whatsAppNumberController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {});
    return BlocBuilder<AppBloc,AppState>(
      builder: (context, state) {
        AppBloc appBloc = AppBloc.get(context);
        return Directionality(
          textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: MainAppBar(
              title: appBloc.translationModel!.exponile,
              isBack: false,
              isLang: true,
            ),
            body: BlocConsumer<RegisterCubit, RegisterStates>(
              listener: (context, state) {
                if (state is RegisterSuccessState && state.registerEntity.success ==1) {
                  Navigator.pop(context);
                  navigateAndFinish(context, LoginScreen());
                  designToastDialog(
                      context: context,
                      toast: TOAST.success,
                      text: state.registerEntity.message);
                }
                if (state is RegisterSuccessState && state.registerEntity.success == 0) {
                  Navigator.pop(context);
                  designToastDialog(
                      context: context,
                      toast: TOAST.error,
                      text: state.registerEntity.message);
                }
                if (state is RegisterErrorState) {
                  Navigator.pop(context);
                  designToastDialog(
                      context: context,
                      toast: TOAST.error,
                      text: state.failure.toString());
                }
                if(state is RegisterLoadingState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ProgressDialog(message: appBloc.translationModel!.loading);
                    },
                  );
                }
              },
              builder: (context, state) {
                RegisterCubit registerCubit = RegisterCubit.get(context);
                if (state is LoginLoadingState) {
                  return const LoadingPage();
                } else {
                  return HideKeyboardPage(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 17.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:BorderRadius.only(bottomLeft: Radius.circular(10.rSp),bottomRight: Radius.circular(10.rSp)),
                                  color: ColorsManager.mainColor.withOpacity(0.9),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(30.rSp),
                                  child: Image.asset(
                                    Assets.images.png.logo,
                                  ),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height - 17.h,
                                width: double.infinity,
                                color: ColorsManager.whiteColor,
                              ),
                            ],
                          ),
                          Positioned(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15.rSp),
                                    margin: EdgeInsets.only(top: 15.h,left: 5.w,right: 5.w),
                                    decoration: BoxDecoration(
                                      color: ColorsManager.whiteColor,
                                      borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2), // Shadow color
                                          spreadRadius: 1, // Spread radius
                                          blurRadius: 1, // Blur radius
                                          offset: const Offset(0, 2), // Offset to bottom right
                                        ),
                                      ],
                                      //  border: Border.all(width: 1.rSp,color: blackClr.withOpacity(0.2))
                                    ),
                                    child: SizedBox(
                                      height: 70.h,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: DefaultIconButton(
                                                      icon: const Icon(Icons.arrow_back_ios),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: DefaultText(
                                                      title: appBloc.translationModel!.register,
                                                      color: ColorsManager.mainColor,
                                                      fontFamily: 'splash',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 25.rSp,
                                                      maxLines: 1,
                                                      style: Style.large,
                                                      align: TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container()
                                                  )
                                                ],
                                              ),
                                              verticalSpace(2.h,),
                                              DefaultTextField(
                                                onChanged: (value){
                                                  String replacedValue = replaceArabicNumbers(value!);
                                                  userNameController.value = TextEditingValue(
                                                    text: replacedValue,
                                                    selection: TextSelection.fromPosition(
                                                      TextPosition(offset: replacedValue.length),
                                                    ),
                                                  );
                                                },
                                                isPassword: false,
                                                validate: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return appBloc.translationModel!.requiredField;
                                                  }
                                                  return null;
                                                },
                                                controller: userNameController,
                                                hint: appBloc.translationModel!.userName,
                                                svgImg: Assets.images.svg.person,
                                              ),
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
                                              DefaultTextField(
                                                onChanged: (value){
                                                  String replacedValue = replaceArabicNumbers(value!);
                                                  mobileNumberController.value = TextEditingValue(
                                                    text: replacedValue,
                                                    selection: TextSelection.fromPosition(
                                                      TextPosition(offset: replacedValue.length),
                                                    ),
                                                  );
                                                },
                                                isPassword: false,
                                                validate: (String? value) {
                                                  if(value!.isEmpty){
                                                    return appBloc.translationModel!.requiredField;
                                                  }
                                                  if(value.length < 11){
                                                    return appBloc.translationModel!.lengthPhone;
                                                  }
                                                  if(!value.startsWith('01')){
                                                    return appBloc.translationModel!.startPhoneValidation;
                                                  }
                                                  return null;
                                                },
                                                maxLength: 11,
                                                type: TextInputType.phone,
                                                controller: mobileNumberController,
                                                hint: appBloc.translationModel!.mobile,
                                                svgImg: Assets.images.svg.phone,
                                              ),
                                              DefaultTextField(
                                                onChanged: (value){
                                                  String replacedValue = replaceArabicNumbers(value!);
                                                  whatsAppNumberController.value = TextEditingValue(
                                                    text: replacedValue,
                                                    selection: TextSelection.fromPosition(
                                                      TextPosition(offset: replacedValue.length),
                                                    ),
                                                  );
                                                },
                                                isPassword: false,
                                                validate: (String? value) {
                                                  if(value!.isEmpty){
                                                    return null;
                                                  }
                                                  if(!value.startsWith('01')){
                                                    return appBloc.translationModel!.startPhoneValidation;
                                                  }
                                                  if(value.length < 11){
                                                    return appBloc.translationModel!.lengthPhone;
                                                  }
                                                  return null;
                                                },
                                                maxLength: 11,
                                                type: TextInputType.phone,
                                                controller: whatsAppNumberController,
                                                hint: appBloc.translationModel!.whatsapp,
                                                svgImg: Assets.images.svg.whatsapp,
                                              ),
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
                                              ),
                                              verticalSpace(1.h),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          registerCubit.selectGander(
                                                              isSelectedMale: true,
                                                              isSelectedFemale: false
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 2.h,
                                                          width: 4.w,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: ColorsManager.black,
                                                                  width: 1.rSp
                                                              ),
                                                              color: registerCubit.isMale ? ColorsManager.success : Colors.transparent
                                                          ),
                                                        ),
                                                      ),
                                                      horizontalSpace(3.w),
                                                      DefaultText(
                                                        title: 'Male',
                                                        style: Style.medium,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12.rSp,
                                                      ),
                                                    ],
                                                  ),
                                                  ),
                                                  horizontalSpace(2.w),
                                                  Expanded(
                                                    child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          registerCubit.selectGander(
                                                              isSelectedMale: false,
                                                              isSelectedFemale: true
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 2.h,
                                                          width: 4.w,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: ColorsManager.black,
                                                                  width: 1.rSp
                                                              ),
                                                              color: registerCubit.isFemale ? ColorsManager.success : Colors.transparent
                                                          ),
                                                        ),
                                                      ),
                                                      horizontalSpace(3.w),
                                                      DefaultText(
                                                        title: 'Female',
                                                        style: Style.medium,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12.rSp,
                                                      ),
                                                    ],
                                                  ),
                                                  )
                                                ],
                                              ),
                                              verticalSpace(4.h),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      registerCubit.acceptTerm();
                                                    },
                                                    child: Container(
                                                      height: 2.h,
                                                      width: 4.w,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: ColorsManager.black,
                                                              width: 1.rSp
                                                          ),
                                                          color: registerCubit.isAccepted ? ColorsManager.success : Colors.transparent
                                                      ),
                                                    ),
                                                  ),
                                                  horizontalSpace(3.w),
                                                  DefaultText(
                                                    title: appBloc.translationModel!.read,
                                                    style: Style.medium,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.rSp,
                                                  ),
                                                  horizontalSpace(3.w),
                                                  InkWell(
                                                    onTap: () async{
                                                      !await launchUrl(
                                                          Uri.parse(termsURL),
                                                          mode: LaunchMode.externalApplication);
                                                    },
                                                    child: DefaultText(
                                                      title: appBloc.translationModel!.terms,
                                                      style: Style.medium,
                                                      fontWeight: FontWeight.bold,
                                                      color: ColorsManager.success,
                                                      fontSize: 10.rSp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              verticalSpace(2.h,),
                                              DefaultButton(
                                                text: AppString.register,
                                                onPressed: ()
                                                {
                                                  if(formKey.currentState!.validate()){
                                                    if(registerCubit.isAccepted){
                                                      if(registerCubit.isMale && registerCubit.isFemale){
                                                        designToastDialog(
                                                            context: context,
                                                            toast: TOAST.warning,
                                                            text: appBloc.translationModel!.fillData
                                                        );
                                                      }else{
                                                        registerCubit.register(
                                                            userName: userNameController.text,
                                                            email: emailController.text.replaceAll(' ', ''),
                                                            password: passwordController.text,
                                                            passwordConfirmation: confirmPasswordController.text,
                                                            mobile: mobileNumberController.text,
                                                            whatsMobile: whatsAppNumberController.text,
                                                            terms: registerCubit.isAccepted ? 1: 0,
                                                            gender: registerCubit.isMale ? 'male' : 'female'
                                                        );
                                                      }
                                                    }else{
                                                      designToastDialog(
                                                          context: context,
                                                          toast: TOAST.warning,
                                                          text: appBloc.translationModel!.termsAndConditions
                                                      );
                                                    }
                                                  } else {
                                                    designToastDialog(
                                                        context: context,
                                                        toast: TOAST.warning,
                                                        text: appBloc.translationModel!.fillData
                                                    );
                                                  }

                                                },
                                              ),
                                              if(state is RegisterSuccessState && state.registerEntity.success == 0 && registerCubit.registerEntity!.data!.emailValidation != null)
                                                Column(
                                                  children: [
                                                    verticalSpace(2.h,),
                                                    Align(
                                                      alignment: Alignment.bottomLeft,
                                                      child: DefaultText(
                                                        align: TextAlign.start,
                                                        title: '*${registerCubit.registerEntity!.data!.emailValidation![0]}*',
                                                        style: Style.extraSmall,
                                                        fontSize: 10.rSp,
                                                        fontWeight: FontWeight.bold,
                                                        color: ColorsManager.error,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if(state is RegisterSuccessState && state.registerEntity.success == 0 && registerCubit.registerEntity!.data!.username != null)
                                                Column(
                                                  children: [
                                                    verticalSpace(2.h,),
                                                    Align(
                                                      alignment: Alignment.bottomLeft,
                                                      child: DefaultText(
                                                        align: TextAlign.start,
                                                        title: '*${registerCubit.registerEntity!.data!.username![0]}*',
                                                        style: Style.extraSmall,
                                                        fontSize: 10.rSp,
                                                        fontWeight: FontWeight.bold,
                                                        color: ColorsManager.error,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if(state is RegisterSuccessState && state.registerEntity.success == 0 && registerCubit.registerEntity!.data!.mobile != null)
                                                Column(
                                                  children: [
                                                    verticalSpace(2.h,),
                                                    Align(
                                                      alignment: Alignment.bottomLeft,
                                                      child: DefaultText(
                                                        align: TextAlign.start,
                                                        title: '*${registerCubit.registerEntity!.data!.mobile![0]}*',
                                                        style: Style.extraSmall,
                                                        fontSize: 10.rSp,
                                                        fontWeight: FontWeight.bold,
                                                        color: ColorsManager.error,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if(state is RegisterSuccessState && state.registerEntity.success == 0 && registerCubit.registerEntity!.data!.whatsMobile != null)
                                                Column(
                                                  children: [
                                                    verticalSpace(2.h,),
                                                    Align(
                                                      alignment: Alignment.bottomLeft,
                                                      child: DefaultText(
                                                        align: TextAlign.start,
                                                        title: '*${registerCubit.registerEntity!.data!.whatsMobile![0]}*',
                                                        style: Style.extraSmall,
                                                        fontSize: 10.rSp,
                                                        fontWeight: FontWeight.bold,
                                                        color: ColorsManager.error,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
