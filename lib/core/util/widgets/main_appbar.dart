import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/cubit/state.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.title,
    required this.isBack,
    required this.isLang,
    this.widget,
    this.isBackPress
  });
  final String? title;
  final Widget? widget;
  final bool? isBack;
  final bool? isLang;
  final VoidCallback? isBackPress;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder: (context, state) {
        AppBloc appBloc = AppBloc.get(context);
        return Directionality(
          textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: AppBar(
            actions: [
              if(isLang == true)
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  appBloc.changeLanguage(
                      code: appBloc.isArabic? 'en':'ar'
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    children: [
                      DefaultText(
                        title: appBloc.translationModel!.lang,
                        style: Style.medium,
                        color: ColorsManager.white,
                      ),
                      horizontalSpace(2.w),
                      const Icon(Icons.language_outlined,color: ColorsManager.white,)
                    ],
                  ),
                ),
              ),
              if(isLang == false)
              Container()
            ],
            title: title != null ?DefaultText(
              title: title!,
              style: Style.medium,
              fontWeight: FontWeight.w700,
              fontSize: 16.rSp,
              color: ColorsManager.white.withOpacity(0.9),
              maxLines: 1,
              fontFamily: 'splash',
              letterSpacing: 2.rSp,
            ): widget,
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: isBack == true ? DefaultIconButton(
                icon: Icon(Icons.arrow_back_ios,color: ColorsManager.white.withOpacity(0.9),),
                onPressed:
                    isBackPress ?? ()
                {
                  Navigator.pop(context);
                },
              ) : title == null ? Image.asset(Assets.images.png.logo):null,
            ),
            elevation: 0,
            backgroundColor: ColorsManager.mainColor,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        );
      },
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
