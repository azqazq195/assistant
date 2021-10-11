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
  static final myController = TextEditingController();

  static String sql = "";
  static String domain = "";
  static String mapper = "";
  static String mybatis = "";
  static List textList = [sql, domain, mapper, mybatis];

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
          ],
        ),
      ),
    );
  }

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
        sb.write("<문의 내용>");
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

  Widget _pasteButton() {
    return Container(
      height: 48,
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: _sendBugReportMail()),
          const SizedBox(
            width: 40,
          ),
          Expanded(
            flex: 7,
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
                // 변환 완료
                flutterToast("변환 완료.");
              },
              child: const Text("붙여넣기"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _copyButton(String text) {
    return Container(
      height: 48,
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: _sendBugReportMail()),
          const SizedBox(
            width: 40,
          ),
          Expanded(
            flex: 7,
            child: OutlinedButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: text));
                flutterToast("복사 완료.");
              },
              child: const Text("복사하기"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton(String text) {
    if (index == 0) {
      return _pasteButton();
    } else {
      return _copyButton(textList[index]);
    }
  }

  var index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: _widgetName.length,
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 40.0,
            ),
            _bottomButton("asd"),
            const SizedBox(
              height: 40.0,
            ),
            TabBar(
              onTap: (value) => {
                setState(() {
                  index = value;
                })
              },
              tabs: _widgetName,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.blue),
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
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

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
