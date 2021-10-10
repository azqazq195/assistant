import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sql_to_mapper/helpers/convertor.dart' as helper;
import 'package:clipboard/clipboard.dart';
import 'package:sql_to_mapper/helpers/toast_message.dart';

class InsertSqlPage extends StatefulWidget {
  const InsertSqlPage({Key? key}) : super(key: key);

  @override
  State<InsertSqlPage> createState() => _InsertSqlPageState();
}

class _InsertSqlPageState extends State<InsertSqlPage> {
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
  static final myController = TextEditingController();

  static String sql = "";
  static String domain = "";
  static String mapper = "";
  static String mybatis = "";

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
                  // 변환 완료
                  flutterToast("변환 완료.");
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
            Container(
              height: 48,
              width: double.maxFinite,
              padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
              child: OutlinedButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: text));
                  flutterToast("복사 완료.");
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

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
