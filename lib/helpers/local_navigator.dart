import 'package:flutter/cupertino.dart';
import 'package:sql_to_mapper/constants/controllers.dart';
import 'package:sql_to_mapper/routing/router.dart';
import 'package:sql_to_mapper/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: convertorPageRoute,
      onGenerateRoute: generateRoute,
    );
