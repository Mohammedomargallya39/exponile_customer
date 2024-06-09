import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {super.key,
      this.width = double.infinity,
      this.height,
      this.radius = 20.0,
      this.elevation = 0.0,
      required this.text,
      this.color = ColorsManager.mainColor,
      this.iconWidget,
      this.textOnly = true,
      this.onPressed,
      this.textStyle,
      this.fontSize,
      this.fontWeight});

  final Function()? onPressed;
  final String text;
  final double width;
  final double? height;
  final double radius;
  final double elevation;
  final Color? color;
  final Widget? iconWidget;
  final bool textOnly;
  final TextStyle? textStyle;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: color ?? Theme.of(context).backgroundColor,
        minWidth: width,
        height: height ?? 6.h,
        elevation: elevation,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: textOnly
            ? Text(
            text,
            style: textStyle ??
            Theme.of(context).textTheme.displaySmall!.copyWith(
            color: Colors.white,
            fontFamily: 'english',
            fontWeight: FontWeight.w600,
            fontSize: fontSize
             )
        )
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconWidget!,
                horizontalSpace(5.w),
                Text(
                    text,
                    style: textStyle ??
                    Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                    fontFamily: 'english',
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize
                    )
                ),
              ],
            ));
  }
}
