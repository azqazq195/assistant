import 'package:assistant/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:assistant/pages/convertor_page.dart';
import 'package:assistant/routing/routes.dart';
import 'package:assistant/pages/convertor/convertor_page.dart' as temp;

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case convertorPageRoute:
      return _getPageRoute(const temp.ConvertorPage(), settings);
    case settingPageRoute:
      return _getPageRoute(const SettingsPage(), settings);
    default:
      return _getPageRoute(const ConvertorPage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings? settings) {
  return MaterialPageRoute(builder: (context) => child, settings: settings);
}
