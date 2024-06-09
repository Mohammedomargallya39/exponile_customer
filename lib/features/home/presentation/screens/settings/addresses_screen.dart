import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/settings/add_new_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/widgets/progress.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
        textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: BlocConsumer<HomeCubit,HomeState>(
            listener: (context, state) {
              if (state is DeleteAddressSuccessState && state.deleteAddressEntity.success ==1) {
                Navigator.pop(context);
                homeCubit.accountData();
                designToastDialog(
                    context: context,
                    toast: TOAST.success,
                    text: state.deleteAddressEntity.message!);
              }
              if (state is DeleteAddressSuccessState && state.deleteAddressEntity.success == 0) {
                Navigator.pop(context);
                designToastDialog(
                    context: context,
                    toast: TOAST.error,
                    text: state.deleteAddressEntity.message!);
              }
              if (state is DeleteAddressErrorState) {
                Navigator.pop(context);
                designToastDialog(
                    context: context,
                    toast: TOAST.error,
                    text: state.failure.toString());
              }
              if(state is DeleteAddressLoadingState) {
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
                    title: appBloc.translationModel!.addresses,
                    isBack: true,
                    isLang: false
                ),
                floatingActionButton: DefaultIconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: ColorsManager.mainColor,
                    ),
                    onPressed: (){
                      navigateTo(context, const AddNewAddressScreen());
                    }
                ),
                body: homeCubit.accountDataEntity != null ?
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: homeCubit.accountDataEntity!.data.addresses!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorsManager.black,
                            width: 1.rSp
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.rSp)
                          ),
                          color: ColorsManager.lightGrey.withOpacity(0.4),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      homeCubit.accountDataEntity!.data.addresses![index].type == 'home'? Icons.home_outlined : Icons.work_history_outlined,
                                      color: ColorsManager.mainColor,
                                    ),
                                    horizontalSpace(2.w),
                                    DefaultText(
                                        title: homeCubit.accountDataEntity!.data.addresses![index].type!,
                                        style: Style.small,
                                        maxLines: 1,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.rSp,
                                        color: ColorsManager.mainColor,
                                    ),
                                  ],
                                ),
                                verticalSpace(2.h),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_city_outlined,
                                      color: ColorsManager.mainColor,
                                    ),
                                    horizontalSpace(2.w),
                                    DefaultText(
                                      title: '${homeCubit.accountDataEntity!.data.addresses![index].streetName??''} / ${homeCubit.accountDataEntity!.data.addresses![index].buildingName??''} / ${homeCubit.accountDataEntity!.data.addresses![index].floorNo??''} / ${homeCubit.accountDataEntity!.data.addresses![index].aptNo??''} / ${homeCubit.accountDataEntity!.data.addresses![index].postalNo??''}',
                                      style: Style.small,
                                      maxLines: 1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.rSp,
                                      color: ColorsManager.mainColor,
                                    ),
                                  ],
                                ),
                                verticalSpace(2.h),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.my_location_outlined,
                                      color: ColorsManager.mainColor,
                                    ),
                                    horizontalSpace(2.w),
                                    DefaultText(
                                      title: homeCubit.accountDataEntity!.data.addresses![index].governorateName!,
                                      style: Style.small,
                                      maxLines: 1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.rSp,
                                      color: ColorsManager.mainColor,
                                    ),
                                  ],
                                ),
                                verticalSpace(2.h),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: ColorsManager.mainColor,
                                    ),
                                    horizontalSpace(2.w),
                                    DefaultText(
                                      title: homeCubit.accountDataEntity!.data.addresses![index].areaName!,
                                      style: Style.small,
                                      maxLines: 1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.rSp,
                                      color: ColorsManager.mainColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: DefaultIconButton(
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: ColorsManager.error,
                                  ),
                                  onPressed: (){
                                    homeCubit.deleteAddress(
                                        addressID: homeCubit.accountDataEntity!.data.addresses![index].id
                                    );
                                  }
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ):
                Center(
                    child: svgImage(
                        path: Assets.images.svg.noImage
                    )
                ),
              );
            },
        )
    );
  }
}
