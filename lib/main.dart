import 'dart:io';
import 'package:exponile_customer/features/auth/forget_password/presentation/controller/forget_password_cubit.dart';
import 'package:exponile_customer/features/auth/login/presentation/controller/login_cubit.dart';
import 'package:exponile_customer/features/auth/register/presentation/controller/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/di/injection.dart' as di;
import 'core/di/injection.dart';
import 'core/network/local/cache_helper.dart';
import 'core/network/remote/servies.dart';
import 'core/util/cubit/cubit.dart';
import 'core/util/cubit/state.dart';
import 'core/util/resources/bloc_observer_manager.dart';
import 'core/util/resources/constants_manager.dart';
import 'features/home/presentation/controller/cubit.dart';
import 'features/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await di.init();

  isRTL = await sl<CacheHelper>().get('isRtl') ?? false;

  token = await sl<CacheHelper>().get('token');

  email = await sl<CacheHelper>().get('email');

  userName = await sl<CacheHelper>().get('userName');

  phone = await sl<CacheHelper>().get('phone');

  phoneWhatsapp = await sl<CacheHelper>().get('phoneWhatsApp');

  wallet = await sl<CacheHelper>().get('wallet');

  firstUpdate = await sl<CacheHelper>().get('firstUpdate');

  userId = await sl<CacheHelper>().get('userId');

  shopID = await sl<CacheHelper>().get('shopID');

  //token = null;

 // bool isRtl = false;

  customerVersion = '1.0.0';

  String translation = await rootBundle.loadString('assets/translations/${isRTL == true ? 'ar' : 'en'}.json');
  Bloc.observer = MyBlocObserver();
  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp(
    isRtl: isRTL!,
    translation: translation,
    widget: const SplashScreen(),
  ));
}

class MyApp extends StatelessWidget {
  final bool isRtl;
  final String translation;
  final Widget widget;

  const MyApp(
      {super.key,
        required this.isRtl,
        required this.translation,
        required this.widget,
      });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<AppBloc>()
            ..setThemes(
              rtl: isRtl,
            )
            ..setTranslation(
              translation: translation,
            )
            ..connectivityListener()
            ..getAppInfo(),
        ),
        BlocProvider(
          create: (BuildContext context) => sl<LoginCubit>(),
        ),
        BlocProvider(
          create: (BuildContext context) => sl<ForgetPasswordCubit>(),
        ),
        BlocProvider(
          create: (BuildContext context) => sl<RegisterCubit>()
        ),
        BlocProvider(
          create: (BuildContext context) => sl<HomeCubit>()..accountData()..getCities(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Customer',
            debugShowCheckedModeBanner: false,
            themeMode: AppBloc.get(context).isDark? ThemeMode.dark :ThemeMode.light,
            theme:  AppBloc.get(context).isDark? AppBloc.get(context).darkTheme : AppBloc.get(context).lightTheme,
            home: widget,
          );
        },
      ),
    );
  }
}
