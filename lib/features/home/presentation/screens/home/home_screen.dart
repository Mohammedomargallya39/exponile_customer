import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/settings/add_new_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {
          if(state is AccountDataSuccessState && state.accountDataEntity.success == 1 && state.accountDataEntity.data.addresses!.isEmpty){
            navigateTo(
                context, const AddNewAddressScreen()
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: HideKeyboardPage(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    verticalSpace(0.1.h),
                    InkWell(
                      onTap: () {
                        navigateTo(
                            context, const AddNewAddressScreen()
                        );
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        color: ColorsManager.mainColor.withOpacity(0.7),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                          child: Row(
                            children: [
                              if(homeCubit.accountDataEntity!= null && homeCubit.accountDataEntity!.data.addresses!.isNotEmpty)
                                Icon(
                                  homeCubit.accountDataEntity!.data.addresses!.last.type == 'home' ?
                                  Icons.home_outlined : Icons.work_outline,
                                  color: ColorsManager.white,
                                ),
                                if(homeCubit.accountDataEntity == null || (homeCubit.accountDataEntity != null && homeCubit.accountDataEntity!.data.addresses!.isEmpty))
                                  const Icon(
                                Icons.location_on_outlined,
                                color: ColorsManager.white,
                              ),
                              horizontalSpace(2.w),
                              if(homeCubit.accountDataEntity!= null && homeCubit.accountDataEntity!.data.addresses!.isNotEmpty)
                              Expanded(
                                child: DefaultText(
                                  title: '${homeCubit.accountDataEntity!.data.addresses!.last.governorateName!} - ${homeCubit.accountDataEntity!.data.addresses!.last.areaName!} - ${homeCubit.accountDataEntity!.data.addresses!.last.streetName!} - ${homeCubit.accountDataEntity!.data.addresses!.last.buildingName!} - ${homeCubit.accountDataEntity!.data.addresses!.last.floorNo} - ${homeCubit.accountDataEntity!.data.addresses!.last.aptNo}',
                                  style: Style.medium,
                                  color: ColorsManager.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2,
                                ),
                              ),
                              if(homeCubit.accountDataEntity!= null && homeCubit.accountDataEntity!.data.addresses!.isEmpty)
                                Center(
                                  child: DefaultText(
                                    title: appBloc.translationModel!.addAddress,
                                    style: Style.medium,
                                    color: ColorsManager.white,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(0.1.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}