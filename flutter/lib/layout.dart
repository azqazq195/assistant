import 'package:assistant/helpers/window_size.dart';
import 'package:flutter/material.dart';
import 'package:assistant/helpers/responsiveness.dart';
import 'package:assistant/widgets/large_screen.dart';
import 'package:assistant/widgets/side_menu.dart';
import 'package:assistant/widgets/small_screen.dart';

class SiteLayout extends StatefulWidget {
  const SiteLayout({Key? key}) : super(key: key);

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  initState() {
    setWindowSize(1600, 1000);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // appBar: topNavigationBar(context, scaffoldKey, "v$currentVersion"),
      drawer: const Drawer(child: SideMenu()),
      body: const ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
