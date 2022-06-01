import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onSurface: Colors.black,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// child: TextButton(
//         style: buttonStyle(hasBorder ?? false),
//         onPressed: onPressed,
//         child: Text(
//           text,
//           style: TextStyle(
//             color: colorLightest,
//             fontSize: fontSize,
//             fontWeight: fontWeight,
//           ),
//         ),
//       ),