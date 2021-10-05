import 'package:flutter/material.dart';
import 'package:sql_to_mapper/pages/insert_sql.dart';
import 'package:sql_to_mapper/pages/get_domain.dart';
import 'package:sql_to_mapper/pages/get_mapper_xml.dart';
import 'package:sql_to_mapper/pages/get_mapper.dart';
import 'package:sql_to_mapper/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case insertSqlPageRoute:
      return _getPageRoute(const InsertSqlPage(), settings);
    case getDomainPageRoute:
      return _getPageRoute(const GetDomainPage(), settings);
    case getMapperPageRoute:
      return _getPageRoute(const GetMapperPage(), settings);
    case getMapperXMLPageRoute:
      return _getPageRoute(const GetMapperXmlPage(), settings);
    default:
      return _getPageRoute(const InsertSqlPage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings? settings) {
  return MaterialPageRoute(builder: (context) => child, settings: settings);
}
