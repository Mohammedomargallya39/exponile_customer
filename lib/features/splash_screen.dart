import 'dart:async';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/cubit/state.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/util/resources/assets.gen.dart';
import '../core/util/resources/constants_manager.dart';
import '../core/util/resources/extensions_manager.dart';
import '../core/util/widgets/default_text.dart';
import 'auth/login/presentation/screen/login_screen.dart';
import 'home/presentation/screens/main_layout/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
      Timer(const Duration(seconds: 1),() {
        navigateAndFinish(context, token != null ? const MainLayout() : LoginScreen());
      });

  }

  @override
  Widget build(BuildContext context) {

    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<AppBloc,AppState>(
      builder: (context, state) {
        AppBloc appBloc = AppBloc.get(context);
        return Directionality(
          textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.images.png.logo,
                    height: 20.h,
                    width: 70.w,
                  ),
                  verticalSpace(10.h),
                  DefaultText(
                    title: appBloc.translationModel!.welcome ,
                    style: Style.large,
                    fontFamily: 'splash',
                    color: ColorsManager.mintGreen,
                    fontSize: 20.rSp,
                    letterSpacing: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
