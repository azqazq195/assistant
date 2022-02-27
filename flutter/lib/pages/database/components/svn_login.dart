import 'package:flutter/material.dart';
import 'package:assistant/constants/color.dart';
import 'package:assistant/widgets/custom_text.dart';

void svnLoginAlert(BuildContext context) {
  var _usernameField = const TextField(
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderFocused, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderGrey, width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      isDense: true,
      hintText: '계정 이름',
      hintStyle: TextStyle(
        fontSize: 12,
        color: fontGrey,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  var _passwordField = const TextField(
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderFocused, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderGrey, width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      isDense: true,
      hintText: '비밀번호',
      hintStyle: TextStyle(
        fontSize: 12,
        color: fontGrey,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "SVN 계정 정보 입력",
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 38,
              width: 348,
              child: _usernameField,
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 38,
              width: 348,
              child: _passwordField,
            ),
            const SizedBox(
              height: 12,
            ),
            OutlinedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  const Size(348, 38),
                ),
                side: MaterialStateProperty.all(
                  const BorderSide(color: borderGrey, width: 0.5),
                ),
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return btnPressed;
                    }
                    if (states.contains(MaterialState.hovered)) {
                      return btnHovered;
                    }
                    return null;
                  },
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 6,
                  ),
                  CustomText(
                    text: 'SubVersion 계정 로그인',
                    size: 12,
                    color: fontDefault,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
