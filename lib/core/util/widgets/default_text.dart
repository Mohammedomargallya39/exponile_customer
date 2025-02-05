import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import '../resources/constants_manager.dart';

class DefaultText extends StatelessWidget {
  const DefaultText({super.key,
    required this.title,
    required this.style,
    this.align,
    this.color,
    this.letterSpacing,
    this.fontFamily = 'english',
    this.fontWeight,
    this.fontSize,
    this.maxLines,
    this.decoration,

  });
  final String title;
  final Style style;
  final TextAlign? align;
  final Color? color;
  final String? fontFamily;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLines;
  final TextDecoration? decoration;


  @override
  Widget build(BuildContext context) {
    return Text(title,
      textAlign: align ?? TextAlign.start,
      maxLines: maxLines,
      overflow: maxLines != null? TextOverflow.ellipsis:null,
      style: getStyle(context).copyWith(
        color: color ?? getStyle(context).color,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? Theme.of(context).textTheme.displayMedium!.fontWeight,
        fontSize: fontSize,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: ColorsManager.error,
        decorationThickness: 2.rSp
      ),);
  }

  TextStyle getStyle(BuildContext context) {
    switch (style) {
      case Style.extraSmall:
        return Theme.of(context).textTheme.bodySmall!;
      case Style.small:
        return Theme.of(context).textTheme.displaySmall!;
      case Style.medium:
        return Theme.of(context).textTheme.displayMedium!;
      case Style.large:
        return Theme.of(context).textTheme.displayLarge!;
      case Style.headMedium:
        return Theme.of(context).textTheme.headlineMedium!;
      case Style.headLarge:
        return Theme.of(context).textTheme.headlineLarge!;
    }
  }
}
