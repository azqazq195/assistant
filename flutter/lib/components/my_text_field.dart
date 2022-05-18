// import 'package:assistant/utils/variable.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.height,
    required this.width,
    required this.hintText,
    this.fontSize,
    this.obscureText,
    required this.controller,
  }) : super(key: key);

  final double height;
  final double width;
  final String hintText;
  final double? fontSize;
  final bool? obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        obscureText: obscureText ?? false,
        controller: controller,
        textInputAction: TextInputAction.next,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
