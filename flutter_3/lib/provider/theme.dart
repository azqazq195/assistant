import 'package:assistant/utils/variable.dart';
import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  ThemeData _themeData = ThemeData(
    primaryColor: Colors.green,
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.only(left: 14),
      hintStyle: TextStyle(
        color: greyLight,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: greyLight, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorLightest),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colorLighter),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return colorLightest.withOpacity(0.04);
            }
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return colorLightest.withOpacity(0.12);
            }
            return null; // Defer to the widget's default.
          },
        ),
      ),
    ),
  );

  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
