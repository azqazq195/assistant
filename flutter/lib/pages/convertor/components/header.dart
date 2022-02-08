import 'package:assistant/constants/custom_color.dart';
import 'package:assistant/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Code",
          size: 26,
          color: CustomColor.fontColor,
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}
