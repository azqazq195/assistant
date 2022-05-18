import 'package:assistant/utils/variable.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    this.fontSize,
    this.hasBorder,
    this.onPressed,
  }) : super(key: key);

  final double height;
  final double width;
  final String text;
  final double? fontSize;
  final bool? hasBorder;
  final VoidCallback? onPressed;

  ButtonStyle? buttonStyle(bool hasBorder) {
    if (hasBorder) {
      return ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        side: MaterialStateProperty.all(
          const BorderSide(
            width: 1,
            color: greyLightest,
          ),
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: buttonStyle(hasBorder ?? false),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: colorLightest,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
