import 'package:flutter/material.dart';

class DefaultIconButton extends StatelessWidget {
  const DefaultIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });
  final Widget? icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        iconSize: 33,
        icon: icon!,
    );
  }
}
