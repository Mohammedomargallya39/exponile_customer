import 'dart:io';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/features/home/presentation/screens/settings/about_screen.dart';
import 'package:exponile_customer/features/home/presentation/screens/settings/addresses_screen.dart';
import 'package:exponile_customer/features/home/presentation/screens/settings/favourites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/network/local/cache_helper.dart';
import '../../../../../core/network/remote/api_endpoints.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/cubit/state.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/delete_account_dialog.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../../../../core/util/widgets/progress.dart';
import '../../../../../core/util/widgets/reset_password_dialog.dart';
import '../../../../../core/util/widgets/two_option_dialog.dart';
import '../../../../auth/login/presentation/screen/login_screen.dart';
import '../../controller/cubit.dart';
import '../../controller/state.dart';

class SettingsScreen extends StatelessWidget {
   const SettingsScreen({super.key});



  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocBuilder<AppBloc,AppState>(
      builder: (context, state) {
        return BlocConsumer<HomeCubit,HomeState>(
          listener: (context, state) {

              if(state is DeleteAccountSuccessState && state.deleteAccountEntity.success ==1) {
                Navigator.pop(context);
                navigateAndFinish(context, LoginScreen());
                token = null;
                 sl<CacheHelper>().clear('token');
              }

              if (state is DeleteAccountSuccessState && state.deleteAccountEntity.success ==0) {
                Navigator.pop(context);
                designToastDialog(
                    context: context,
                    toast: TOAST.warning,
                    text: state.deleteAccountEntity.message.toString());
              }

              if (state is DeleteAccountErrorState) {
                Navigator.pop(context);
                designToastDialog(
                    context: context,
                    toast: TOAST.error,
                    text: state.failure.toString());
              }

              if(state is DeleteAccountLoadingState) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ProgressDialog(message: appBloc.translationModel!.loading);
                  },
                );
              }



              if(state is ResetPasswordSuccessState && state.resetPasswordEntity.success == 1) {
                Navigator.pop(context);
                designToastDialog(
                    context: context,
                    toast: TOAST.success,
                    text: state.resetPasswordEntity.message.toString());
              }

              if(state is ResetPasswordSuccessState && state.resetPasswordEntity.success == 0) {
                Navigator.pop(context);
                designToastDialog(
                    context: context,
                    toast: TOAST.warning,
                    text: state.resetPasswordEntity.message.toString());
              }

              if (state is ResetPasswordErrorState) {
                Navigator.pop(context);
                designToastDialog(
                    context: context,
                    toast: TOAST.error,
                    text: state.failure.toString());
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
            return Directionality(
              textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: Scaffold(
                body: HideKeyboardPage(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ///account info
                          verticalSpace(3.h),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50.rSp)
                                    ),
                                    border: Border.all(
                                        color: ColorsManager.black,
                                        width: 1.rSp
                                    )
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10.rSp),
                                  child: svgImage(
                                      path: Assets.images.svg.person,
                                      width: 10.w,
                                      height: 6.h,
                                      color: ColorsManager.mainColor.withOpacity(0.6)
                                  ),
                                ),
                              ),
                              horizontalSpace(5.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DefaultText(
                                      title: email!,
                                      style: Style.small,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.rSp,
                                      letterSpacing: 1.rSp,
                                      maxLines: 1,

                                    ),
                                    verticalSpace(1.h),
                                    DefaultText(
                                      title: userName!,
                                      style: Style.small,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.rSp,
                                      letterSpacing: 1.rSp,
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(3.h),
                          Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),

                          ///account notifications
                          verticalSpace(3.h),
                          InkWell(
                            onTap: () {
                              designToastDialog(
                                  context: context,
                                  toast: TOAST.warning,
                                  text: appBloc.translationModel!.notAvailable
                              );
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                DefaultText(
                                  title: appBloc.translationModel!.notifications,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                ),
                                const Spacer(),
                                const Icon(Icons.notifications_active_outlined,color: ColorsManager.mainColor),
                              ],
                            ),
                          ),
                          verticalSpace(3.h),
                          Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),


                          ///account wallet
                          verticalSpace(3.h),
                          Row(
                            children: [
                              DefaultText(
                                title: appBloc.translationModel!.wallet,
                                style: Style.small,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.rSp,
                                letterSpacing: 1.rSp,
                                maxLines: 1,
                              ),
                              const Spacer(),
                              DefaultText(
                                title: '${wallet!} ${appBloc.translationModel!.currency}',
                                style: Style.small,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.rSp,
                                letterSpacing: 1.rSp,
                                color: ColorsManager.mainColor,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          verticalSpace(3.h),
                          Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),


                          ///account Favourites
                          verticalSpace(3.h),
                          InkWell(
                            onTap: (){
                              navigateTo(context, const FavouritesScreen());
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                DefaultText(
                                  title: appBloc.translationModel!.favourites,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                ),
                                const Spacer(),
                                const Icon(Icons.favorite_border,color: ColorsManager.mainColor),
                              ],
                            ),
                          ),
                          verticalSpace(3.h),
                          Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),


                          ///account address
                          verticalSpace(3.h),
                          InkWell(
                            onTap: (){
                                navigateTo(context, const AddressesScreen());
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                DefaultText(
                                  title: appBloc.translationModel!.addresses,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                ),
                                const Spacer(),
                                const Icon(Icons.location_on_outlined,color: ColorsManager.mainColor),
                              ],
                            ),
                          ),
                          verticalSpace(3.h),
                          Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),


                          ///change Password
                          verticalSpace(3.h),
                          InkWell(
                            onTap: ()
                            {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ResetPasswordDialog(
                                      oldPasswordController: homeCubit.oldPasswordController,
                                      newPasswordController: homeCubit.newPasswordController,
                                      confirmNPasswordController: homeCubit.confirmNewPasswordController,
                                      function: (){
                                        homeCubit.resetPassword(
                                            oldPassword: homeCubit.oldPasswordController.text,
                                            newPassword: homeCubit.newPasswordController.text,
                                            confirmNewPassword: homeCubit.confirmNewPasswordController.text
                                        );
                                      }
                                  );
                                },
                              );
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                DefaultText(
                                  title: appBloc.translationModel!.resetPassword,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                ),
                                const Spacer(),
                                const Icon(Icons.lock_reset,color: ColorsManager.mainColor),
                              ],
                            ),
                          ),
                          verticalSpace(3.h),
                          Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),

                          /// change language
                          verticalSpace(3.h),
                          InkWell(
                            onTap: () {
                              appBloc.changeLanguage(
                                  code: appBloc.isArabic? 'en':'ar'
                              );
                              appBloc.isArabic? homeCubit.filterMainSearch['product'] = 'المنتجات' : homeCubit.filterMainSearch['product'] = 'Products';
                              appBloc.isArabic? homeCubit.filterMainSearch['store'] = 'المتاجر' : homeCubit.filterMainSearch['store'] = 'Stores';
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                DefaultText(
                                  title: appBloc.translationModel!.language,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                ),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Row(
                                    children: [
                                      DefaultText(
                                        title: appBloc.translationModel!.lang,
                                        style: Style.medium,
                                        color: ColorsManager.mainColor,
                                        fontSize: 12.rSp,
                                      ),
                                      horizontalSpace(2.w),
                                      const Icon(Icons.language_outlined,color: ColorsManager.mainColor)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          verticalSpace(3.h),
                          Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),


                          ///about exponile
                          verticalSpace(3.h),
                          InkWell(
                            onTap: () {
                              navigateTo(context, const AboutExponileScreen());
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                DefaultText(
                                  title: appBloc.translationModel!.about,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                ),
                                const Spacer(),
                                const Icon(Icons.info_outline,color: ColorsManager.mainColor),
                              ],
                            ),
                          ),
                          verticalSpace(3.h),
                          Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),


                          ///Terms and Conditions
                          verticalSpace(3.h),
                          InkWell(
                            onTap: () async{
                              !await launchUrl(
                                  Uri.parse(termsURL),
                                  mode: LaunchMode.externalApplication
                              );
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                DefaultText(
                                  title: appBloc.translationModel!.terms,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                ),
                                const Spacer(),
                                const Icon(Icons.report_gmailerrorred,color: ColorsManager.mainColor),
                              ],
                            ),
                          ),
                          verticalSpace(3.h),
                          Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),


                          ///Become Merchant
                          verticalSpace(3.h),
                          InkWell(
                            onTap: () async{
                              Platform.isAndroid ?
                              appBloc.launchGooglePlayStore(
                                  storeLink: appBloc.appInfoEntity!.merchantAndroidLink!
                              ) :
                              appBloc.launchGooglePlayStore(
                                  storeLink: appBloc.appInfoEntity!.merchantIosLink!
                              );
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                DefaultText(
                                  title: appBloc.translationModel!.becomeMerchant,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                ),
                                const Spacer(),
                                const Icon(Icons.person_pin_circle_outlined,color: ColorsManager.mainColor),
                              ],
                            ),
                          ),
                          verticalSpace(3.h),
                          Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),


                          /// delete account
                          if(token != null)
                            verticalSpace(3.h),
                          if(token != null)
                            InkWell(
                            onTap: ()
                            {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DeleteAccountDialog(
                                      textEditingController: homeCubit.passwordController,
                                      function: (){
                                        homeCubit.deleteAccount(
                                            password: homeCubit.passwordController.text
                                        );
                                      }
                                  );
                                },
                              );
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                DefaultText(
                                  title: appBloc.translationModel!.deleteAccount,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                ),
                                const Spacer(),
                                const Icon(Icons.delete,color: ColorsManager.error),
                              ],
                            ),
                          ),
                          if(token != null)
                            verticalSpace(3.h),
                          if(token != null)
                            Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),

                          /// logout
                          if(token != null)
                            verticalSpace(3.h),
                          if(token != null)
                            InkWell(
                            onTap: ()
                            {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return TwoOptionsDialog(
                                      message: appBloc.translationModel!.logout,
                                      popButtonText: appBloc.translationModel!.cancel,
                                      pushButtonText: appBloc.translationModel!.yesOnly,
                                      colorEdit: ColorsManager.error,
                                      pushButtonVoidCallback: ()
                                      async {
                                        navigateAndFinish(context, LoginScreen());
                                        token = null;
                                        await sl<CacheHelper>().clear('token');
                                      },
                                      popButtonVoidCallback: (){
                                        Navigator.pop(context);
                                      }
                                  );
                                },
                              );

                              // navigateAndFinish(context, LoginScreen());
                              // token = null;
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                DefaultText(
                                  title: appBloc.translationModel!.logout,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                ),
                                const Spacer(),
                                const Icon(Icons.logout,color: ColorsManager.error,),
                              ],
                            ),
                          ),
                          if(token != null)
                            verticalSpace(3.h),
                          if(token != null)
                            Divider(
                            height: 1.rSp,
                            thickness: 1.rSp,
                            color: ColorsManager.black.withOpacity(0.2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
