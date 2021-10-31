import 'package:flutter/cupertino.dart';
import 'package:assistant/constants/controllers.dart';
import 'package:assistant/routing/router.dart';
import 'package:assistant/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: convertorPageRoute,
      onGenerateRoute: generateRoute,
    );
