import 'package:assistant/helpers/shared_preferences.dart';
import 'package:assistant/layout.dart';
import 'package:assistant/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:assistant/controllers/menu_controller.dart';
import 'package:assistant/controllers/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assistant/helpers/updater.dart';
import 'package:assistant/helpers/logger.dart';

Future<void> main() async {
  Get.put(MenuController());
  Get.put(NavigationController());
  await Logger.init();
  await SharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Assistant",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
        }),
        primaryColor: Colors.blue,
      ),
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    Updater().checkVersion(context);
  }

  final _isAutoLogin = SharedPreferences.prefs.getBool("auto_login") ?? false;

  @override
  Widget build(BuildContext context) {
    if (_isAutoLogin) {
      Logger.i("auto login is true. skip login.");
      return const SiteLayout();
    } else {
      Logger.i("auto login is false. required login.");
      return const LoginScreen();
    }
  }
}
