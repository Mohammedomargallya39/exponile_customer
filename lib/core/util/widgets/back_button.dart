import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../resources/assets.gen.dart';


class DefaultBackButton extends StatelessWidget {
   const DefaultBackButton({super.key,required this.function});



  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:function,
      child: SvgPicture.asset(Assets.images.svg.arrow_back)
    );
  }
}
