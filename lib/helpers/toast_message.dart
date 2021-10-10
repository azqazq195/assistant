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
