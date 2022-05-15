import 'package:assistant/utils/utils.dart';
import 'package:assistant/utils/variable.dart';
import 'package:flutter/material.dart';

class MyFieldCard extends StatelessWidget {
  const MyFieldCard(
      {Key? key,
      this.height,
      this.width,
      required this.title,
      required this.content,
      required this.onPressed})
      : super(key: key);

  final double? height;
  final double? width;
  final String title;
  final String content;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        color: const Color(0xFFE8DEF8),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: height ?? 80,
              width: width ?? 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  spacerH,
                  Text(content),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
