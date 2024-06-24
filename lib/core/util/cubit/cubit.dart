import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../features/home/domain/entities/app_info_entity.dart';
import '../../../features/home/domain/usecase/app_info_usecase.dart';
import '../../error/failures.dart';
import '../../usecase/use_case.dart';
import '../resources/constants_manager.dart';
import '/core/util/cubit/state.dart';
import '/core/util/resources/colors_manager.dart';
import '/core/util/resources/translation_manager.dart';
import '../../di/injection.dart';
import '../../network/local/cache_helper.dart';


class AppBloc extends Cubit<AppState> {
  final AppInfoUseCase _appInfoUseCase;

  AppBloc(
      {
    required AppInfoUseCase appInfoUseCase,
  }
  ) :
        _appInfoUseCase = appInfoUseCase,
        super(Empty());

  static AppBloc get(context) => BlocProvider.of(context);

  bool isArabic = false;

  bool isDark = false;

  IconData dark = Icons.dark_mode;

  late ThemeData lightTheme;

  late ThemeData darkTheme;

  late String family;

  void setThemes({
    required bool rtl,
  }) {
    emit(InitState());
    isArabic = rtl;
    changeTheme();
    emit(ThemeLoaded());
  }

  void changeDarkMode() {
    emit(InitState());
    isDark = !isDark;
    dark = !isDark ? Icons.dark_mode : Icons.light_mode;
    emit(ThemeChanged());
  }

  void changeTheme() {
    family = 'Sofia';
    lightTheme = ThemeData(
      scaffoldBackgroundColor: ColorsManager.white,
      timePickerTheme: TimePickerThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.white,
        elevation: 0.0,
        titleSpacing: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20.0,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: family,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.textPrimaryBlue,
        elevation: 50.0,
        selectedItemColor: ColorsManager.primary,
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1,
        ),
      ),
      //primarySwatch: MaterialColor(int.parse('0xff0075ff'), color),
      colorScheme: const ColorScheme(
        primary: ColorsManager.primary,
        onPrimary: ColorsManager.primary,
        primaryContainer: ColorsManager.orangePrimary,
        secondary: ColorsManager.textPrimaryBlue,
        onSecondary: ColorsManager.onSecondaryLight,
        secondaryContainer: ColorsManager.secondaryContainerLight,
        onSecondaryContainer: ColorsManager.textPrimaryBlue,
        tertiary: ColorsManager.textPrimaryBlue,
        onTertiary: ColorsManager.onTertiaryLight,
        surface: ColorsManager.surfaceLight,
        onSurface: ColorsManager.onSurfaceLight,
        background: ColorsManager.textPrimaryBlue,
        onBackground: ColorsManager.onSurfaceLight,
        error: ColorsManager.white,
        onError: ColorsManager.onSurfaceLight,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 34.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: ColorsManager.textPrimaryBlue,
          overflow: TextOverflow.ellipsis
        ),
        titleMedium: TextStyle(
          fontSize: 26.0,
          fontFamily: family,
          fontWeight: FontWeight.w500,
          color: ColorsManager.onSecondaryLight,
          overflow: TextOverflow.ellipsis

        ),
        titleSmall: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.textPrimaryBlue,
          overflow: TextOverflow.ellipsis

        ),
        labelLarge: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: ColorsManager.textPrimaryBlue,
          overflow: TextOverflow.ellipsis

        ),
        displaySmall: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.onSecondaryLight,
          overflow: TextOverflow.ellipsis

        ),
        displayMedium: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.onSecondaryLight,
          overflow: TextOverflow.ellipsis

        ),
        displayLarge: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.textPrimaryBlue,
          overflow: TextOverflow.ellipsis

        ),
        bodySmall: TextStyle(
          fontSize: 13.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: ColorsManager.textPrimaryBlue,
          overflow: TextOverflow.ellipsis

        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w500,
          color: ColorsManager.secondaryContainerLight,
          overflow: TextOverflow.ellipsis

        ),
        bodyLarge: TextStyle(
          fontSize: 19.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: ColorsManager.textPrimaryBlue,
          overflow: TextOverflow.ellipsis
        ),
      ),
    );
    darkTheme = ThemeData(
      //useMaterial3: true,
      scaffoldBackgroundColor: ColorsManager.black,
      timePickerTheme: TimePickerThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.black,
        elevation: 0.0,
        titleSpacing: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 20.0,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: family,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.textPrimaryBlue,
        elevation: 50.0,
        selectedItemColor: ColorsManager.primary,
        unselectedItemColor: Colors.grey[700],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorsManager.mainColor
      ),
      //primarySwatch: MaterialColor(int.parse('0xff0075ff'), color),
      colorScheme: const ColorScheme(
        primary: ColorsManager.primary,
        onPrimary: ColorsManager.primary,
        primaryContainer: ColorsManager.orangePrimary,
        secondary: ColorsManager.textPrimaryBlue,
        onSecondary: ColorsManager.onSecondaryLight,
        secondaryContainer: ColorsManager.secondaryContainerLight,
        onSecondaryContainer: ColorsManager.textPrimaryBlue,
        tertiary: ColorsManager.textPrimaryBlue,
        onTertiary: ColorsManager.onTertiaryLight,
        surface: ColorsManager.surfaceLight,
        onSurface: ColorsManager.onSurfaceLight,
        background: ColorsManager.textPrimaryBlue,
        onBackground: ColorsManager.onSurfaceLight,
        error: ColorsManager.black,
        onError: ColorsManager.onSurfaceLight,
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 34.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: ColorsManager.whiteColor,
        ),
        titleMedium: TextStyle(
          fontSize: 26.0,
          fontFamily: family,
          fontWeight: FontWeight.w500,
          color: ColorsManager.whiteColor,
        ),
        titleSmall: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.whiteColor,
        ),
        labelLarge: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: ColorsManager.whiteColor,
        ),
        displaySmall: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.whiteColor,
        ),
        displayMedium: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.whiteColor,
        ),
        displayLarge: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.whiteColor,
        ),
        bodySmall: TextStyle(
          fontSize: 13.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: ColorsManager.whiteColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w500,
          color: ColorsManager.whiteColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 19.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: ColorsManager.whiteColor,
        ),

      ),
    );
    emit(InitState());
  }


    String lang = 'ar';
    TranslationModel? translationModel;
  void setTranslation({
    required String translation,
  }) {
    emit(InitState());
    translationModel = TranslationModel.fromJson(jsonDecode(translation));
    emit(LanguageLoaded());
  }

  String languageCode = 'en';
  void changeLanguage({
    required String code,
  }) async {
    debugPrint(code);
    emit(InitState());
    languageCode = code;
    if (code == 'ar') {
      isArabic = true;
      isRTL = true;
    } else {
      isArabic = false;
      isRTL = false;
    }
    sl<CacheHelper>().put('isRtl', isArabic);
    String translation = await rootBundle.loadString('assets/translations/${isArabic ? 'ar' : 'en'}.json');
    changeTheme();
    setTranslation(
      translation: translation,
    );
    emit(ChangeLanguage());
  }


  // bool isAppConnected = true;
  // void connectivityListener() async {
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     if (result == ConnectivityResult.mobile ||
  //         result == ConnectivityResult.wifi) {
  //       isAppConnected = true;
  //     } else {
  //       isAppConnected = false;
  //     }
  //     debugPrint('isAppConnected: $isAppConnected');
  //     emit(ConnectivityChanged());
  //   }).onError(
  //         (error) {
  //       log(error.toString());
  //       emit(ConnectivityChangedError());
  //     },
  //   );
  // }

  IconData visibilityShowPassword = Icons.visibility_outlined;
  bool showPassword = true;

  void changePasswordVisibility(){
    emit(InitState());
    showPassword = !showPassword;
    log('showPassword is $showPassword');
    visibilityShowPassword = showPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  IconData visibilityShowConfirmPassword = Icons.visibility_outlined;
  bool showConfirmPassword = true;

  void changeConfirmPasswordVisibility(){
    showConfirmPassword = !showConfirmPassword;
    visibilityShowConfirmPassword = showConfirmPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeConfirmPasswordVisibilityState());
  }


  AppInfoEntity? appInfoEntity;
  void getAppInfo() async {
    emit(AppInfoLoadingState());
    final result = await _appInfoUseCase(NoParams());
    result.fold((failure) {
      emit(AppInfoErrorState(
          failure: mapFailureToMessage(failure)
      ));
    }, (data) {
      appInfoEntity = data;
      emit(AppInfoSuccessState(
          appInfoEntity: data
      ));
    });
  }


  void launchGooglePlayStore({required String storeLink}) async {
    emit(InitState());
    if (await canLaunch(storeLink)) {
      await launch(storeLink);
    } else {
      throw 'Could not launch $storeLink';
    }
    emit(ChangeStates());
  }


}