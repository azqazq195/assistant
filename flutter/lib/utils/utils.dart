import 'package:assistant/utils/shared_preferences.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:assistant/components/my_alert_dialog.dart';
import 'package:assistant/api/client/rest_client.dart';
import 'package:assistant/api/response/error_response.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as en;
import 'package:assistant/utils/variable.dart';

const spacerH = SizedBox(height: 10.0);
const middleSpacerH = SizedBox(height: 20.0);
const biggerSpacerH = SizedBox(height: 40.0);

const spacerW = SizedBox(width: 10.0);
const middleSpacerW = SizedBox(width: 20.0);
const biggerSpacerW = SizedBox(width: 40.0);

Future<Response> request(BuildContext context, Future<dynamic> func) async {
  try {
    return await func;
  } catch (e) {
    switch (e.runtimeType) {
      case DioError:
        ErrorResponse? error = ErrorResponse.fromJson(
            (e as DioError).response?.data as Map<String, dynamic>);

        MyAlertDialog(
          context: context,
          title: "ERROR",
          content: Text(error.message),
        ).show();
        break;
      default:
        MyAlertDialog(
          context: context,
          title: "ERROR",
          content: const Text("알 수 없는 에러."),
        ).show();
        break;
    }
    return Response(message: '', status: 0, timestamp: DateTime.now());
  }
}

toCapitalize(str) {
  return str[0].toUpperCase() + str.substring(1);
}

toCamel(str) {
  var result = "";
  var temp = str.split("_");
  for (int k = 0; k < temp.length; k++) {
    if (k == 0) {
      result += temp[k];
    } else {
      result += temp[k][0].toUpperCase() + temp[k].substring(1);
    }
  }
  return result;
}

String encrypt(String str) {
  if (str.isEmpty) {
    return "";
  }

  en.Key key = en.Key.fromBase64(encryptKey);
  en.IV iv = en.IV.fromLength(16);
  en.Encrypter encrpter = en.Encrypter(en.AES(key));
  return encrpter.encrypt(str, iv: iv).base64;
}

showSnackbar(BuildContext context, String? title, String content) {
  List<Widget> widgets = [];

  if (title != null) {
    widgets.add(
      Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: colorLightest2,
        ),
      ),
    );
    widgets.add(spacerH);
  }
  widgets.add(Text(content));

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: 400,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    ),
  );
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

myAccessToken() {
  return SharedPreferences.prefs.getString(Preferences.accessToken.name);
}
