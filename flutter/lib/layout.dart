import 'package:assistant/api/client/user_rest_client.dart';
import 'package:assistant/helpers/updater.dart';
import 'package:assistant/helpers/window_size.dart';
import 'package:flutter/material.dart';
import 'package:assistant/helpers/responsiveness.dart';
import 'package:assistant/widgets/large_screen.dart';
import 'package:assistant/widgets/side_menu.dart';
import 'package:assistant/widgets/small_screen.dart';
import 'package:dio/dio.dart' hide Response;

class SiteLayout extends StatefulWidget {
  const SiteLayout({Key? key}) : super(key: key);

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final userClient = UserRestClient(Dio());

  @override
  initState() {
    setWindowSize(1600, 1000);
    super.initState();
  }

  Future<void> login() async {
    _showLoginAlert(context, await userClient.getUser(3));
  }

  void _showLoginAlert(BuildContext context, Response response) {
    User user = User(
      id: response.data[0]['id'] as int,
      name: response.data[0]['name'] as String,
      email: response.data[0]['email'] as String,
      createdDate: DateTime.parse(response.data[0]['createdDate'] as String),
      updatedDate: response.data[0]['updatedDate'] == null
          ? null
          : DateTime.parse(response.data[0]['updatedDate'] as String),
    );

    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(user.name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(user.email),
                const Text(""),
                Text(response.result),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
