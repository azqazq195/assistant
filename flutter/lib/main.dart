import 'package:fluent/api/api.dart';
import 'package:fluent/provider/theme.dart';
import 'package:fluent/screens/main/main_page.dart';
import 'package:fluent/screens/welcome/signin_page.dart';
import 'package:fluent/utils/logger.dart';
import 'package:fluent/utils/shared_preferences.dart';
import 'package:fluent/utils/variable.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:dio/dio.dart' hide Response;

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb ||
      [TargetPlatform.windows, TargetPlatform.android]
          .contains(defaultTargetPlatform)) {
    SystemTheme.accentColor;
  }

  setPathUrlStrategy();

  await Logger.init();
  await SharedPreferences.init();
  Api.init(Dio());

  // if (isDesktop) {
  //   await WindowManager.instance.ensureInitialized();

  //   windowManager.waitUntilReadyToShow().then((_) async {
  //     await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
  //     var size = await DesktopWindow.getWindowSize();
  //     if (size.width >= 1920) {
  //       await windowManager.setSize(const Size(1510, 1090));
  //       await windowManager.setMinimumSize(const Size(1510, 1090));
  //     } else {
  //       await windowManager.setSize(const Size(755, 545));
  //       await windowManager.setMinimumSize(const Size(755, 545));
  //     }
  //     await windowManager.center();
  //     await windowManager.show();
  //     await windowManager.setSkipTaskbar(false);
  //   });
  // }

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
        return FluentApp(
          title: appTitle,
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/signin',
          routes: {
            '/signin': (_) => const SignInPage(),
            '/main': (_) => const MainPageTest()
          },
          // routes: {'/': (_) => const MyHomePage()},
          color: appTheme.color,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
          theme: ThemeData(
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
        );
      },
    );
  }
}
