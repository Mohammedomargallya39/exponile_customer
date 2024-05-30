import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/cubit/state.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/two_option_dialog.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/versions_dialog.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {
        // if(state is AppInfoSuccessState && merchantVersion != state.appInfoEntity.merchantVersion){
        //   showDialog(
        //     context: context,
        //     barrierDismissible: state.appInfoEntity.merchantRequired == 'no' ? true : false,
        //     builder: (context) {
        //       return VersionDialog(
        //         message: appBloc.translationModel!.sure,
        //         popButtonVoidCallback: () {
        //
        //         },
        //         pushButtonVoidCallback: state.appInfoEntity.merchantRequired == 'no'?  () {
        //         Navigator.pop(context);
        //         } : null,
        //       );
        //     },
        //   );
        // }
      },

      builder: (context, state) {
          return  Directionality(
            textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: BlocBuilder<HomeCubit,HomeState>(
                builder: (context, state) {
                  return Scaffold(
                    bottomNavigationBar:  CurvedNavigationBar(
                      key: bottomNavigationKey,
                      index: homeCubit.currentNavIndex,
                      height: 7.h,
                      items:  <Widget>[
                        Icon(Icons.home_outlined,color: homeCubit.currentNavIndex == 0? ColorsManager.whiteColor:ColorsManager.black,),
                        Icon(Icons.production_quantity_limits_outlined,color: homeCubit.currentNavIndex == 1? ColorsManager.whiteColor:ColorsManager.black),
                        Icon(Icons.local_offer_outlined,color: homeCubit.currentNavIndex == 2? ColorsManager.whiteColor:ColorsManager.black),
                        Icon(Icons.shopping_bag_outlined,color: homeCubit.currentNavIndex == 3? ColorsManager.whiteColor:ColorsManager.black),
                        Icon(Icons.shop_outlined,color: homeCubit.currentNavIndex == 4? ColorsManager.whiteColor:ColorsManager.black),
                        Icon(Icons.settings_outlined,color: homeCubit.currentNavIndex == 5? ColorsManager.whiteColor:ColorsManager.black),
                      ],
                      color: ColorsManager.primary.withOpacity(0.05),
                      buttonBackgroundColor: ColorsManager.mainColor,
                      backgroundColor: Colors.transparent,
                      animationCurve: Curves.linear,
                      animationDuration: const Duration(milliseconds: 300),
                      onTap: (index)
                      {
                        homeCubit.changeNavBottomScreens(index);
                      },
                      letIndexChange: (index) => true,
                    ),
                    body:PopScope(
                        canPop: false,
                        onPopInvoked: (bool didPop){
                          didPop = true;
                          if(didPop && homeCubit.currentNavIndex == 0){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return TwoOptionsDialog(
                                      message: appBloc.translationModel!.exit,
                                      popButtonText: appBloc.translationModel!.cancel,
                                      pushButtonText: appBloc.translationModel!.yesOnly,
                                      pushButtonVoidCallback: (){
                                        SystemNavigator.pop();
                                      },
                                      popButtonVoidCallback: (){
                                        Navigator.pop(context);
                                      },
                                     colorEdit: ColorsManager.error,
                                  );
                                },
                            );
                          }else if (didPop && homeCubit.currentNavIndex != 0){
                            homeCubit.currentNavIndex = 0;
                            homeCubit.changeNavBottomScreens(0);
                          }
                        },
                        child: homeCubit.customer.elementAt(homeCubit.currentNavIndex)
                    ),
                  );
                },
            ),
          );
        },
    );
  }
}
