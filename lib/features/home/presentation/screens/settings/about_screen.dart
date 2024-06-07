import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/core/util/widgets/default_text_field.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../../../../core/util/widgets/progress.dart';

class AboutExponileScreen extends StatefulWidget {
  const AboutExponileScreen({super.key});

  @override
  State<AboutExponileScreen> createState() => _AboutExponileScreenState();
}

class _AboutExponileScreenState extends State<AboutExponileScreen> {

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.aboutExponile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);

    return Directionality(
        textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: BlocConsumer<HomeCubit,HomeState>(
          listener: (context, state) {
            if (state is SubmitComplainSuccessState && state.submitComplainEntity.success ==1) {
              Navigator.pop(context);
              homeCubit.contactUsNameController.text = '';
              homeCubit.contactUsEmailController.text = '';
              homeCubit.contactUsPhoneController.text = '';
              homeCubit.contactUsMessageController.text = '';
              designToastDialog(
                  context: context,
                  toast: TOAST.success,
                  text: state.submitComplainEntity.message!);
            }
            if (state is SubmitComplainSuccessState && state.submitComplainEntity.success == 0) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.submitComplainEntity.message!);
            }
            if (state is SubmitComplainErrorState) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.failure.toString());
            }
            if(state is SubmitComplainLoadingState) {
              showDialog(
                context: context,
                builder: (context) {
                  return ProgressDialog(message: appBloc.translationModel!.loading);
                },
              );
            }
          },
            builder: (context, state) {
              return Scaffold(
                appBar: MainAppBar(
                    title: appBloc.translationModel!.about,
                    isBack: true,
                    isLang: false
                ),
                body: SingleChildScrollView(
                  child: HideKeyboardPage(
                    child: Form(
                      key: homeCubit.contactUsFormKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            verticalSpace(2.h),
                            Center(
                                child: Image.asset(
                                    Assets.images.png.logo,
                                  height: 15.h,
                    
                                )
                            ),
                            verticalSpace(4.h),
                            Row(
                              children: [
                                const Icon(Icons.info_outline,color: ColorsManager.mainColor),
                                horizontalSpace(2.w),
                                DefaultText(
                                  title: appBloc.translationModel!.about,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                  color: ColorsManager.mainColor,
                                ),
                              ],
                            ),
                            verticalSpace(2.h),
                            DefaultText(
                              title: appBloc.translationModel!.aboutExponile,
                              style: Style.small,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.rSp,
                              letterSpacing: 1.rSp,
                              maxLines: 10,
                              color: ColorsManager.mainColor,
                            ),
                            verticalSpace(4.h),
                            Row(
                              children: [
                                const Icon(Icons.contact_support_outlined,color: ColorsManager.mainColor),
                                horizontalSpace(2.w),
                                DefaultText(
                                  title: appBloc.translationModel!.contactUs,
                                  style: Style.small,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  letterSpacing: 1.rSp,
                                  maxLines: 1,
                                  color: ColorsManager.mainColor,
                                ),
                              ],
                            ),
                            if(homeCubit.aboutExponileEntity != null)
                            Column(
                              children: [
                                verticalSpace(2.h),
                                Row(
                                  children: [
                                    const Icon(Icons.email,color: ColorsManager.mainColor),
                                    horizontalSpace(2.w),
                                    Expanded(
                                      child: DefaultText(
                                        title: homeCubit.aboutExponileEntity!.data!.email!,
                                        style: Style.small,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.rSp,
                                        letterSpacing: 1.rSp,
                                        maxLines: 1,
                                        color: ColorsManager.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(2.h),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined,color: ColorsManager.mainColor),
                                    horizontalSpace(2.w),
                                    Expanded(
                                      child: DefaultText(
                                        title: homeCubit.aboutExponileEntity!.data!.address!,
                                        style: Style.small,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.rSp,
                                        letterSpacing: 1.rSp,
                                        maxLines: 2,
                                        color: ColorsManager.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(2.h),
                                Row(
                                  children: [
                                    const Icon(Icons.phone,color: ColorsManager.mainColor),
                                    horizontalSpace(2.w),
                                    Expanded(
                                      child: DefaultText(
                                        title: homeCubit.aboutExponileEntity!.data!.phone!,
                                        style: Style.small,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.rSp,
                                        letterSpacing: 1.rSp,
                                        maxLines: 1,
                                        color: ColorsManager.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            verticalSpace(4.h),
                            DefaultTextField(
                              onChanged: (value){
                                String replacedValue = replaceArabicNumbers(value!);
                                homeCubit.contactUsNameController.value = TextEditingValue(
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
                              controller: homeCubit.contactUsNameController,
                              hint: appBloc.translationModel!.name,
                              svgImg: Assets.images.svg.person,
                            ),
                            DefaultTextField(
                              onChanged: (value){
                                String replacedValue = replaceArabicNumbers(value!);
                                homeCubit.contactUsEmailController.value = TextEditingValue(
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
                              controller: homeCubit.contactUsEmailController,
                              hint: appBloc.translationModel!.email,
                              svgImg: Assets.images.svg.email,
                            ),
                            DefaultTextField(
                              onChanged: (value){
                                String replacedValue = replaceArabicNumbers(value!);
                                homeCubit.contactUsPhoneController.value = TextEditingValue(
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
                              controller: homeCubit.contactUsPhoneController,
                              hint: appBloc.translationModel!.mobile,
                              svgImg: Assets.images.svg.phone,
                            ),
                            DefaultTextField(
                              onChanged: (value){
                                String replacedValue = replaceArabicNumbers(value!);
                                homeCubit.contactUsMessageController.value = TextEditingValue(
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
                              controller: homeCubit.contactUsMessageController,
                              hint: appBloc.translationModel!.complain,
                             // svgImg: Assets.images.svg.complain,
                              maxLines: 10,
                            ),
                            verticalSpace(2.h),
                            DefaultButton(
                                text: appBloc.translationModel!.submit,
                                onPressed: (){
                                  if(homeCubit.contactUsFormKey.currentState!.validate()){
                                     homeCubit.submitComplain(
                                         name: homeCubit.contactUsNameController.text,
                                         email: homeCubit.contactUsEmailController.text,
                                         phone: homeCubit.contactUsPhoneController.text,
                                         complain: homeCubit.contactUsMessageController.text
                                     );
                                  }
                                },
                            ),
                            verticalSpace(2.h),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
        )
    );
  }
}
