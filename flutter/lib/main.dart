import 'package:assistant/constants/custom_color.dart';
import 'package:assistant/layout.dart';
import 'package:flutter/material.dart';
import 'package:assistant/controllers/menu_controller.dart';
import 'package:assistant/controllers/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assistant/helpers/updater.dart';

void main() {
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColor.getTheme();

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
    Updater().checkVersion(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SiteLayout();
  }
}
