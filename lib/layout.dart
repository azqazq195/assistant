import 'package:flutter/material.dart';
import 'package:sql_to_mapper/helpers/responsiveness.dart';
import 'package:sql_to_mapper/widgets/large_screen.dart';
import 'package:sql_to_mapper/widgets/side_menu.dart';
import 'package:sql_to_mapper/widgets/small_screen.dart';
import 'package:sql_to_mapper/widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(child: SideMenu()),
      body: const ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
