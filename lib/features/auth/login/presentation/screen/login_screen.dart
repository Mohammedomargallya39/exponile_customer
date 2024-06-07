import 'dart:io';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/screens/main_layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/network/local/cache_helper.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/cubit/state.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_button.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/default_text_field.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../../../../core/util/widgets/loading_page.dart';
import '../../../../../core/util/widgets/progress.dart';
import '../../../../../core/util/widgets/versions_dialog.dart';
import '../../../forget_password/presentation/screens/forget_password_screen.dart';
import '../../../register/presentation/screens/register_screen.dart';
import '../controller/login_cubit.dart';
import '../controller/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {});
    LoginCubit loginCubit = LoginCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);

    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {
        AppBloc appBloc = AppBloc.get(context);
        if(state is AppInfoSuccessState && customerVersion != state.appInfoEntity.customerVersion) {
          showDialog(
            context: context,
            barrierDismissible: state.appInfoEntity.customerRequired == 'no' ? true : false,
            builder: (context) {
              return VersionDialog(
                message: appBloc.translationModel!.sure,
                popButtonVoidCallback:
                state.appInfoEntity.customerRequired == 'no'?  () {
                  Navigator.pop(context);
                } : null,

                pushButtonVoidCallback: () {
                  Platform.isAndroid ?
                  appBloc.launchGooglePlayStore(
                      storeLink: state.appInfoEntity.customerAndroidLink!
                  ) :
                  appBloc.launchGooglePlayStore(
                      storeLink: state.appInfoEntity.customerIosLink!
                  );
                },
              );
            },
          );
        }
      },
      builder: (context, state) {
          return Directionality(
            textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              appBar: MainAppBar(
                title: appBloc.translationModel!.exponile,
                isBack: false,
                isLang: true,
              ),
              body: BlocConsumer<LoginCubit, LoginStates>(
                listener: (context, state) {
                  if (state is LoginSuccessState && state.loginEntity.success ==1) {
                    Navigator.pop(context);
                    sl<CacheHelper>().put('token', state.loginEntity.data!.token);
                    sl<CacheHelper>().put('userId', state.loginEntity.data!.user!.id);
                    sl<CacheHelper>().put('shopID', state.loginEntity.data!.user!.shop!.shopID);
                    sl<CacheHelper>().put('email', state.loginEntity.data!.user!.email);
                    sl<CacheHelper>().put('userName', state.loginEntity.data!.user!.username);
                    sl<CacheHelper>().put('phone', state.loginEntity.data!.user!.mobile);
                    sl<CacheHelper>().put('phoneWhatsApp', state.loginEntity.data!.user!.whatsMobile);
                    sl<CacheHelper>().put('wallet', state.loginEntity.data!.user!.wallet);
                    sl<CacheHelper>().put('firstUpdate', state.loginEntity.data!.user!.shop!.firstUpdate);

                    userId = state.loginEntity.data!.user!.id;
                    shopID = state.loginEntity.data!.user!.shop!.shopID;
                    token = state.loginEntity.data!.token;
                    firstUpdate = state.loginEntity.data!.user!.shop!.firstUpdate;
                    email = state.loginEntity.data!.user!.email;

                    userName = state.loginEntity.data!.user!.username;
                    phone = state.loginEntity.data!.user!.mobile;
                    phoneWhatsapp = state.loginEntity.data!.user!.whatsMobile;
                    wallet = state.loginEntity.data!.user!.wallet;

                    HomeCubit homeCubit = HomeCubit.get(context);
                    homeCubit.currentNavIndex = 0;

                    navigateAndFinish(context, const MainLayout());

                    debugPrintFullText(token!);
                  }

                  if (state is LoginSuccessState && state.loginEntity.success ==0) {
                    Navigator.pop(context);
                    designToastDialog(
                        context: context,
                        toast: TOAST.error,
                        text: state.loginEntity.message!);
                  }

                  if (state is LoginErrorState) {
                    Navigator.pop(context);
                    designToastDialog(
                        context: context,
                        toast: TOAST.error,
                        text: state.failure.toString());
                  }

                  if(state is LoginLoadingState) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ProgressDialog(message: appBloc.translationModel!.loading);
                      },
                    );
                  }
                },
                builder: (context, state) {
                  return state is LoginLoadingState
                      ? const LoadingPage()
                      : HideKeyboardPage(
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
                                      padding: EdgeInsets.all(20.rSp),
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
                                      child: Column(
                                        children: [
                                          DefaultText(
                                            title: appBloc.translationModel!.login,
                                            color: ColorsManager.mainColor,
                                            fontFamily: 'splash',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 25.rSp,
                                            maxLines: 1,
                                            style: Style.large,
                                            align: TextAlign.center,
                                          ),
                                          verticalSpace(2.h,),
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
                                              if (value!.isEmpty) {
                                                return appBloc.translationModel!.requiredField;
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
                                              passwordController.value = TextEditingValue(
                                                text: replacedValue,
                                                selection: TextSelection.fromPosition(
                                                  TextPosition(offset: replacedValue.length),
                                                ),
                                              );
                                            },
                                            validate: (String? value) {
                                              if (value!.isEmpty) {
                                                return appBloc.translationModel!.requiredField;
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
                                          Row(
                                            children: [
                                              Container(),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  navigateTo(context, ForgetPasswordScreen());
                                                },
                                                child: DefaultText(
                                                  title: appBloc.translationModel!.forget,
                                                  color: ColorsManager.mainColor,
                                                  fontFamily: 'splash',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.rSp,
                                                  maxLines: 1,
                                                  style: Style.medium,
                                                  align: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),

                                          verticalSpace(4.h,),
                                          DefaultButton(
                                            text: appBloc.translationModel!.login,
                                            onPressed: () async {
                                              if (formKey.currentState!.validate()) {
                                                loginCubit.logIn(
                                                    email: emailController.text,
                                                    password: passwordController.text
                                                );
                                              } else {
                                                designToastDialog(
                                                    context: context,
                                                    toast: TOAST.warning,
                                                    text: appBloc.translationModel!.fillData
                                                );
                                              }
                                            },
                                          ),

                                          verticalSpace(4.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,

                                            children: [
                                              DefaultText(
                                                title: appBloc.translationModel!.newUser,
                                                color: ColorsManager.mainColor,
                                                fontFamily: 'splash',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.rSp,
                                                maxLines: 1,
                                                style: Style.medium,
                                                align: TextAlign.end,
                                              ),
                                              horizontalSpace(2.w),
                                              InkWell(
                                                onTap: () {
                                                  navigateTo(context, RegisterScreen());
                                                },
                                                child: DefaultText(
                                                  title: appBloc.translationModel!.registerNow,
                                                  color: ColorsManager.orangePrimary,
                                                  fontFamily: 'splash',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.rSp,
                                                  maxLines: 1,
                                                  style: Style.medium,
                                                  align: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                          verticalSpace(2.h),
                                          Row(
                                            children: [
                                              svgImage(
                                                path: Assets.images.svg.guest,
                                                color: ColorsManager.black,
                                                width: 3.w,
                                                height: 3.h,
                                              ),
                                              horizontalSpace(2.w),
                                              DefaultText(
                                                title: appBloc.translationModel!.guest,
                                                color: ColorsManager.mainColor,
                                                fontFamily: 'splash',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.rSp,
                                                maxLines: 1,
                                                style: Style.medium,
                                                align: TextAlign.end,
                                              ),
                                              const Spacer(),
                                              DefaultIconButton(
                                                  icon: const Icon(Icons.login,color: ColorsManager.success,),
                                                  onPressed: (){
                                                    HomeCubit homeCubit = HomeCubit.get(context);
                                                    homeCubit.currentNavIndex = 0;
                                                    navigateAndFinish(context, const MainLayout());
                                                  }
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    verticalSpace(10.h,),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
