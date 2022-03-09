import 'package:fluent/utils/shared_preferences.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:system_theme/system_theme.dart';

enum NavigationIndicators { sticky, end }

class AppTheme extends ChangeNotifier {
  int _colorIndex =
      SharedPreferences.prefs.getInt(Preferences.colorIndex.name) ?? 0;
  int get colorIndex => _colorIndex;
  set colorIndex(int colorIndex) {
    _colorIndex = colorIndex;
    SharedPreferences.prefs.setInt(Preferences.colorIndex.name, colorIndex);

    if (colorIndex == 0) {
      _color = systemAccentColor;
    } else {
      _color = Colors.accentColors[colorIndex - 1];
    }

    notifyListeners();
  }

  AccentColor _color =
      (SharedPreferences.prefs.getInt(Preferences.colorIndex.name) ?? 0) == 0
          ? systemAccentColor
          : Colors.accentColors[
              (SharedPreferences.prefs.getInt(Preferences.colorIndex.name) ??
                      0) -
                  1];
  AccentColor get color => _color;
  set color(AccentColor color) {
    _color = color;
    notifyListeners();
  }

  ThemeMode _mode = ThemeMode
      .values[SharedPreferences.prefs.getInt(Preferences.themeMode.name) ?? 0];
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    _mode = mode;
    SharedPreferences.prefs.setInt(Preferences.themeMode.name, mode.index);
    notifyListeners();
  }

  PaneDisplayMode _displayMode = PaneDisplayMode.values[
      SharedPreferences.prefs.getInt(Preferences.displayMode.name) ?? 0];
  PaneDisplayMode get displayMode => _displayMode;
  set displayMode(PaneDisplayMode displayMode) {
    _displayMode = displayMode;
    SharedPreferences.prefs
        .setInt(Preferences.displayMode.name, displayMode.index);
    notifyListeners();
  }

  NavigationIndicators _indicator = NavigationIndicators
      .values[SharedPreferences.prefs.getInt(Preferences.indicator.name) ?? 0];
  NavigationIndicators get indicator => _indicator;
  set indicator(NavigationIndicators indicator) {
    _indicator = indicator;
    SharedPreferences.prefs.setInt(Preferences.indicator.name, indicator.index);
    notifyListeners();
  }
}

AccentColor get systemAccentColor {
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.android ||
      kIsWeb) {
    return AccentColor('normal', {
      'darkest': SystemTheme.accentInstance.darkest,
      'darker': SystemTheme.accentInstance.darker,
      'dark': SystemTheme.accentInstance.dark,
      'normal': SystemTheme.accentInstance.accent,
      'light': SystemTheme.accentInstance.light,
      'lighter': SystemTheme.accentInstance.lighter,
      'lightest': SystemTheme.accentInstance.lightest,
    });
  }
  return Colors.blue;
}
