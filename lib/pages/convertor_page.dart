import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sql_to_mapper/helpers/convertor.dart' as helper;
import 'package:sql_to_mapper/helpers/toast_message.dart';
import 'package:url_launcher/url_launcher.dart';

class ConvertorPage extends StatefulWidget {
  const ConvertorPage({Key? key}) : super(key: key);

  @override
  State<ConvertorPage> createState() => _ConvertorPageState();
}

class _ConvertorPageState extends State<ConvertorPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: BottomNavigator());
  }
}

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  static const bugMail = "azqazq195@gmail.com";
  static String sql = "sql";
  static String domain = "domain";
  static String mapper = "mapper";
  static String mybatis = "mybatis";

  Widget _sendBugReportMail() {
    return OutlinedButton(
      onPressed: () {
        String? encodeQueryParameters(Map<String, String> params) {
          return params.entries
              .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
              .join('&');
        }

        StringBuffer sb = StringBuffer();
        sb.write("<버그 내용>");
        sb.write("\n\n\n\n");
        sb.write("------------------");
        sb.write("\n\n\nsql\n\n");
        sb.write(sql);
        sb.write("\n\n\ndomain\n\n");
        sb.write(domain);
        sb.write("\n\n\nmapper\n\n");
        sb.write(mapper);
        sb.write("\n\n\nmybatis\n\n");
        sb.write(mybatis);

        final Uri emailLaunchUri = Uri(
          scheme: 'mailto',
          path: bugMail,
          query: encodeQueryParameters(<String, String>{
            'subject': 'Example Subject & Symbols are allowed!',
            'body': sb.toString()
          }),
        );

        launch(emailLaunchUri.toString());
      },
      child: const Text(
        "버그 제보",
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }

  static const _widgetName = [
    Tab(
      text: "sql",
    ),
    Tab(
      text: "domain",
    ),
    Tab(
      text: "mapper",
    ),
    Tab(
      text: "mybatis",
    ),
  ];

  late helper.DBTable table;
  late helper.Convertor convertor;

  Widget sqlPage() {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  sql,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            _sendBugReportMail(),
            const SizedBox(
              height: 40.0,
            ),
            Container(
              height: 48,
              width: double.maxFinite,
              padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
              child: OutlinedButton(
                onPressed: () async {
                  await Clipboard.getData(Clipboard.kTextPlain).then((value) {
                    if (value == null) return;
                    if (value.text == null) return;
                    setState(() {
                      sql = value.text!;

                      table = helper.DBTable(sql);
                      convertor = helper.Convertor(table);

                      mybatis = convertor.mybatis();
                      mapper = convertor.mapper();
                      domain = convertor.domain();
                    });
                  });
                  FlutterToast(context, "변환 완료.");
                },
                child: const Text("붙여넣기"),
              ),
            ),
            const SizedBox(
              height: 40.0,
            )
          ],
        ),
      ),
    );
  }

  Widget textPage(String text) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(text),
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            _sendBugReportMail(),
            const SizedBox(
              height: 40.0,
            ),
            Container(
              height: 48,
              width: double.maxFinite,
              padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
              child: OutlinedButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: text));
                  FlutterToast(context, "복사 완료.");
                },
                child: const Text("복사하기"),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: _widgetName.length,
      child: Scaffold(
        bottomNavigationBar: const TabBar(
          tabs: _widgetName,
          indicatorColor: Colors.transparent,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blue,
        ),
        body: TabBarView(
          children: [
            sqlPage(),
            textPage(domain),
            textPage(mapper),
            textPage(mybatis),
          ],
        ),
      ),
    );
  }

}
