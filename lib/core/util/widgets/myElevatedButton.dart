import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton(
      {super.key,
        required this.text,
        required this.onPressed,
        this.height = 50.0,
        this.width = double.infinity,
        this.fontSize
      });

  final String text;
  final double height;
  final double width;
  final Function()? onPressed;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
