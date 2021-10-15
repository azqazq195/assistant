import 'package:flutter/material.dart';
import 'package:sql_to_mapper/controllers/menu_controller.dart';
import 'package:sql_to_mapper/controllers/navigation_controller.dart';
import 'package:sql_to_mapper/layout.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Get.put(MenuController());
  Get.put(NavigationController());
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
          primaryColor: Colors.blue),
      home: const SiteLayout(),
    );
  }
}

// Link(
//   uri: Uri.parse(
//       'https://pub.dev/documentation/url_launcher/latest/link/link-library.html'),
//   target: LinkTarget.blank,
//   builder: (ctx, openLink) {
//     return TextButton.icon(
//       onPressed: openLink,
//       label: Text('Link Widget documentation'),
//       icon: Icon(Icons.read_more),
//     );
//   },
// ),
