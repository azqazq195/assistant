import 'package:assistant/pages/database/database_page.dart';
import 'package:assistant/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:assistant/routing/routes.dart';
import 'package:assistant/pages/convertor/convertor_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case convertorPageRoute:
      return _getPageRoute(const ConvertorPage(), settings);
    case databasePageRoute:
      return _getPageRoute(const DatabasePage(), settings);
    case settingPageRoute:
      return _getPageRoute(const SettingsPage(), settings);
    default:
      return _getPageRoute(const SettingsPage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings? settings) {
  return MaterialPageRoute(builder: (context) => child, settings: settings);
}
