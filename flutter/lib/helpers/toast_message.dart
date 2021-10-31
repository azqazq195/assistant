import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void flutterToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM_RIGHT,
      backgroundColor: Colors.redAccent,
      fontSize: 20.0,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      webBgColor: "#00b09b",
      webPosition: "right");
}


class FlutterToast {
  static late FToast fToast;

  FlutterToast(context, String text) {
    fToast = FToast();
    fToast.init(context);
    _showToast(text);
  }

  static _showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          Text(text),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM_RIGHT,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
