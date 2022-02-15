import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final String? fontFamily;

  const CustomText(
      {Key? key,
      required this.text,
      this.size,
      this.color,
      this.weight,
      this.fontFamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 16,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
        fontFamily: fontFamily,
      ),
    );
  }
}
