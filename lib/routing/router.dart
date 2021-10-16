import 'package:flutter/material.dart';
import 'package:assistant/pages/convertor_page.dart';
import 'package:assistant/pages/dummy_page.dart';
import 'package:assistant/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case convertorPageRoute:
      return _getPageRoute(const ConvertorPage(), settings);
    case dummyPageRoute:
      return _getPageRoute(const DummyPage(), settings);
    default:
      return _getPageRoute(const ConvertorPage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings? settings) {
  return MaterialPageRoute(builder: (context) => child, settings: settings);
}
