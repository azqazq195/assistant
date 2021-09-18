import 'package:flutter/material.dart';
import 'package:sql_to_mapper/pages/authentication/authentication.dart';
import 'package:sql_to_mapper/pages/clients/clients.dart';
import 'package:sql_to_mapper/pages/drivers/drivers.dart';
import 'package:sql_to_mapper/pages/overview/overview.dart';
import 'package:sql_to_mapper/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overViewPageRoute:
      return _getPageRoute(const OverViewPage());
    case driversPageRoute:
      return _getPageRoute(const DriversViewPage());
    case clientsPageRoute:
      return _getPageRoute(const ClientsViewPage());
    case authenticationPageRoute:
      return _getPageRoute(const AuthenticationViewPage());
    default:
      return _getPageRoute(const OverViewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
