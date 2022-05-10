import 'package:fluent/screens/welcome/welcome_page.dart';
import 'package:fluent/utils/logger.dart';
import 'package:fluent/utils/shared_preferences.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_strategy/url_strategy.dart';

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
    return const WelcomePage();
  }
}
