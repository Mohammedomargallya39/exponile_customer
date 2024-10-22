import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'default_text.dart';

class MyListTitle extends StatelessWidget {
  const MyListTitle({super.key,
  required this.title,
  this.svgImg,
  this.icon,
  this.onClick,
  this.onLongClick,
  this.styleText,

  });
  final String title;
  final Style? styleText;
  final String? svgImg;
  final IconData? icon;
  final VoidCallback? onClick;
  final VoidCallback? onLongClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.08.rSp,
      decoration: BoxDecoration(
        color: ColorsManager.textFieldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onClick,
        onLongPress: onLongClick,
        leading: svgImg !=null ?
        svgImage(path: svgImg! ,
          color: ColorsManager.iconColor,):
        Icon(icon),
        title: DefaultText(
          title: title,
          style: styleText ?? Style.small,
        ),
      ),
    );
  }
}
