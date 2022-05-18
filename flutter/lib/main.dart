import 'package:assistant/api/api.dart';
import 'package:assistant/provider/theme.dart';
import 'package:assistant/screen/main/main_page.dart';
import 'package:assistant/screen/sign/signin_page.dart';
import 'package:assistant/utils/logger.dart';
import 'package:assistant/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:assistant/utils/variable.dart';
import 'package:dio/dio.dart' hide Response;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  await Logger.init();
  await SharedPreferences.init();
  Api.init(Dio());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return MaterialApp(
          title: appTitle,
          theme: appTheme.themeData,
          debugShowCheckedModeBanner: false,
          initialRoute: '/signin',
          routes: {
            '/signin': (_) => const SignInPage(),
            '/main': (_) => const MainPage()
          },
          // routes: {'/': (_) => const MyHomePage()},
        );
      },
    );
  }
}
