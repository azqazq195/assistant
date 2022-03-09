import 'package:fluent_ui/fluent_ui.dart';

const spacerH = SizedBox(height: 10.0);
const biggerSpacerH = SizedBox(height: 40.0);

const spacerW = SizedBox(width: 10.0);
const biggerSpacerW = SizedBox(width: 40.0);

snackbar(context, text) {
  return showSnackbar(
    context,
    Snackbar(
      extended: true,
      content: Text(text),
    ),
    alignment: Alignment.bottomRight,
  );
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
