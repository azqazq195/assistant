import 'package:assistant/api/api.dart';
import 'package:assistant/provider/theme.dart';
import 'package:assistant/screen/main/main_page.dart';
import 'package:assistant/screen/sign/signin_page.dart';
import 'package:assistant/utils/logger.dart';
import 'package:assistant/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assistant/utils/variable.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart' hide Response;
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await DesktopWindow.setMinWindowSize(const Size(1920, 1080));
  // await DesktopWindow.setWindowSize(const Size(1920, 1080));
  // await DesktopWindow.setWindowSize(const Size(1920, 1080));

  // await DesktopWindow.setMinWindowSize(const Size(960, 540));
  // await DesktopWindow.setWindowSize(const Size(960, 540));
  // await DesktopWindow.setWindowSize(const Size(960, 540));

  await Logger.init();
  await SharedPreferences.init();
  await Api.init(Dio());

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://977135b63ef54ad7aa774228f02da0f3@o1267697.ingest.sentry.io/6454330';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
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
