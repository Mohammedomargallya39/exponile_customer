import 'dart:async';
import 'dart:io';
import 'package:exponile_customer/core/util/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/default_text.dart';
import 'assets.gen.dart';
import 'extensions_manager.dart';
import '/core/util/resources/colors_manager.dart';
import '/core/util/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'font_manager.dart';

class ConstantsManger {
}

bool isArabic = true;

List<Color> gradientColors = [
  ColorsManager.white,
  ColorsManager.whiteColor,
];

/// Translate error message
const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';

EdgeInsetsGeometry designApp =  EdgeInsets.all(25.rSp);

Widget svgImage({required String path,Color? color,double? height,double? width}){
  return color != null ?
  SvgPicture.asset(path ,color: color,height: height ?? 28,width: width ?? 28,) :
  SvgPicture.asset(path,height: height,width: width,) ;
}

String? token;
String? customerVersion;
int? firstUpdate;
bool locationPermission = false;
bool locationServiceEnabled = false;
String? deviceToken = '';
String? email = '';
String? userName = '';
String? phone = '';
String? phoneWhatsapp = '';
String? wallet = '';
int? userId = 0;
int? shopID = 0;
int? subscriptionID = 0;
bool isCoachLogin = false;
double? currentLat = 0;
double? currentLng = 0;

String? currentCity = '';
String? currentCountry = '';
String? currentGovernment = '';



enum Style {
  extraSmall,
  small,
  medium,
  large,
  headLarge,
  headMedium,
}



void navigateTo(context,Widget widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context,Widget widget,) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,),
      (route) {
    return false;
  },
);

AppBar defaultAppBar({
  required String title,
  required BuildContext context,
  List<Widget>? actions,
  bool prevPage = false,
  //RegisterCubit? cubit,
  Color? color = ColorsManager.white,
  Color? fontColor = ColorsManager.black,
  Function()? onPressed,
}) {
  return AppBar(
    backgroundColor: color!,
    centerTitle: true,
    title: DefaultText(
      title:title,
      style: Style.small,
      fontWeight: FontWeight.bold,
      color: fontColor,
      ),
    actions: actions,
    leading: IconButton(
      icon: svgImage(path: Assets.images.svg.arrow_back,),
      onPressed: onPressed ?? ()
      {
       // prevPage ? cubit!.nextPage(false,context) :
        Navigator.pop(context);
      },
    ),
  );
}


String localised({
  required BuildContext context,
  required String ar,
  required String en,
}) {
  if (AppBloc.get(context).isArabic) {
    return ar;
  }
  return en;
}





void debugPrintFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}




Future<void> designToastDialog({
  required BuildContext context,
  required TOAST toast,
  String text = '',
  bool isDismissible = true,
}) async {

  return showDialog(
    barrierDismissible: isDismissible,
    context: context,
    builder: (context) =>
        BlocBuilder<AppBloc,AppState>(
          builder: (context, state) {
            AppBloc appBloc = AppBloc.get(context);
            return Dialog(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Directionality(
                textDirection: AppBloc.get(context).isArabic
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: ColorsManager.white,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 1.h,
                            color: chooseColor(toast),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(15.rSp),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 15.0,
                                  backgroundColor: chooseColor(toast),
                                  child: Icon(
                                    chooseIcon(toast),
                                    color: ColorsManager.white,
                                    size: 18.0,
                                  ),
                                ),
                                horizontalSpace(20.rSp),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            chooseTitle(toast, context),
                                            style:
                                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                              color: ColorsManager.darkGrey,
                                              fontWeight: FontWeightManager.bold,
                                              fontSize: 18.0.rSp,
                                            ),
                                          ),
                                          const Spacer(),
                                          if (isDismissible)
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                //navigateAndFinish(context, const MainPage());
                                              },
                                              child: const CircleAvatar(
                                                backgroundColor: ColorsManager.surfaceLight,
                                                radius: 10.0,
                                                child: Icon(
                                                  Icons.close,
                                                  size: 10.0,
                                                  color: ColorsManager.textPrimaryBlue,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      verticalSpace(4.rSp),
                                      Text(
                                        text.isNotEmpty
                                            ? text
                                            : appBloc.translationModel!.deleteMessage,
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorsManager.darkGrey,
                                            fontWeight: FontWeightManager.regular,
                                            fontSize: 14.0.rSp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
  );
}

enum TOAST { success, error, info, warning }

IconData chooseIcon(TOAST toast) {
  late IconData iconData;

  switch (toast) {
    case TOAST.success:
      iconData = FontAwesomeIcons.check;
      break;
    case TOAST.error:
      iconData = FontAwesomeIcons.times;
      break;
    case TOAST.info:
      iconData = FontAwesomeIcons.info;
      break;
    case TOAST.warning:
      iconData = FontAwesomeIcons.exclamation;
      break;
  }

  return iconData;
}

Color chooseColor(TOAST toast) {
  late Color color;

  switch (toast) {
    case TOAST.success:
      color = ColorsManager.success;
      break;
    case TOAST.error:
      color = ColorsManager.error;
      break;
    case TOAST.info:
      color = ColorsManager.info;
      break;
    case TOAST.warning:
      color = ColorsManager.warning;
      break;
  }

  return color;
}

String chooseTitle(TOAST toast, context) {
  late String title;
  AppBloc appBloc = AppBloc.get(context);

  switch (toast) {
    case TOAST.success:
      title = appBloc.translationModel!.success;
      break;
    case TOAST.error:
      title = appBloc.translationModel!.error;
      break;
    case TOAST.info:
      title = appBloc.translationModel!.info;
      break;
    case TOAST.warning:
      title = appBloc.translationModel!.warning;
      break;
  }

  return title;
}

SizedBox verticalSpace(double size) => SizedBox(height: size);

SizedBox horizontalSpace(double size) => SizedBox(width: size);

BorderRadius borderRadius(double radius) => BorderRadius.circular(radius);

String displayTranslatedText({
  required BuildContext context,
  required String ar,
  required String en,
}) =>
    AppBloc.get(context).isArabic ? ar : en;

File? userPicRegister;
String? genderRegister = '';
String? bio = '';
String? bodyFatRegister = '';
String? countryRegister = '';
String? governmentRegister = '';
String? cityRegister = '';
String? userNameRegister = '';
String? firstNameRegister = '';
String? lastNameRegister = '';
String? fullNameRegister = '';
String? ageRegister = '';
String? emailRegister = '';
String? phoneRegister = '';
String? passwordRegister = '';
String? confirmPasswordRegister = '';
int? currentTallRegister = 0;
int? currentWeightRegister = 0;
int? fixedPriceRegister = 0;
String? facebookLinkRegister = '';
String? instagramLinkRegister = '';
String? youtubeLinkRegister = '';
String? tiktokLinkRegister = '';
int? experienceRegister = 0;
bool isCoachRegister = false;

bool isCoachFilter = false;


String? errorMessage;

String? constClientVariable;
bool? constClientSearchVariable;
bool? constPlanSearchVariable;
bool? constExerciseSearchVariable;
bool? constNutritionSearchVariable;
String testCity = 'cairo';



bool? isRTL;


// int? countProgressVideoUpload=0;
// int? totalProgressVideoUpload=0;


