import 'package:assistant/components/my_elevated_button.dart';
import 'package:assistant/components/my_text_button.dart';
import 'package:assistant/utils/utils.dart';
import 'package:assistant/utils/variable.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({
    Key? key,
    required this.context,
    required this.title,
    required this.content,
    this.actionText,
    this.actionFunction,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final Widget content;
  final double actionFontSize = 16;
  final String? actionText;
  final VoidCallback? actionFunction;

  @override
  Widget build(BuildContext context) {
    List<Widget> actions() {
      List<Widget> actions = [];

      if (actionText != null) {
        actions.add(
          MyElevatedButton(
            height: 46,
            width: 200,
            text: actionText!,
            fontSize: actionFontSize,
            onPressed: () {
              actionFunction!();
            },
          ),
        );
        actions.add(middleSpacerW);
        actions.add(
          MyTextButton(
            height: 46,
            width: 200,
            text: "닫기",
            fontSize: actionFontSize,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
        return [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: actions),
          ),
        ];
      } else {
        actions.add(const SizedBox(width: 200));
        actions.add(middleSpacerW);
        actions.add(
          MyTextButton(
            height: 46,
            width: 200,
            text: "닫기",
            fontSize: actionFontSize,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
        return [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            ),
          ),
        ];
      }
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: colorLightest,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: content,
      actions: actions(),
    );
  }

  show() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return this;
      },
    );
  }
}
