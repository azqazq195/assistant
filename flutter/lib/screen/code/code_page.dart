import 'dart:io';

import 'package:assistant/api/api.dart';
import 'package:assistant/api/client/rest_client.dart';
import 'package:assistant/api/dto/code_dto.dart';
import 'package:assistant/components/my_alert_dialog.dart';
import 'package:assistant/components/my_elevated_button.dart';
import 'package:assistant/components/my_field_card.dart';
import 'package:assistant/components/my_text_button.dart';
import 'package:assistant/provider/config.dart';
import 'package:assistant/utils/shared_preferences.dart';
import 'package:assistant/utils/utils.dart';
import 'package:assistant/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  bool _reloading = false;
  String _databaseName = "";
  List<MColumn> _userColumns = [];
  List<MColumn> _svnColumns = [];
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: false);

  Widget header(Config config) {
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "코드",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              MyTextButton(
                height: 45,
                width: 180,
                text: "CENTER 테이블 불러오기",
                onPressed: () async {
                  _databaseName = "center";
                  config.tableNames = await _tablenames("center");
                  showSnackbar(context, "완료", "테이블 목록 불러오기 완료.");
                },
              ),
              spacerW,
              MyTextButton(
                height: 45,
                width: 180,
                text: "CSTTEC 테이블 불러오기",
                onPressed: () async {
                  _databaseName = "csttec";
                  config.tableNames = await _tablenames("csttec");
                  showSnackbar(context, "완료", "테이블 목록 불러오기 완료.");
                },
              ),
              spacerW,
              Tooltip(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: const EdgeInsets.all(10),
                textStyle: const TextStyle(fontSize: 15),
                decoration: BoxDecoration(
                  color: greyLightest,
                  borderRadius: BorderRadius.circular(20),
                ),
                message:
                    "csttec, center 데이터 베이스를 최신화 시킵니다.\nSvn과 로컬 작업 폴더의 sql를 모두 분석하기\n때문에 5~10초 정도 소요됩니다.",
                child: _reloading
                    ? const SizedBox(
                        height: 45,
                        width: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : MyElevatedButton(
                        height: 45,
                        width: 200,
                        text: "데이터베이스 최신화",
                        fontSize: 16,
                        onPressed: () async {
                          setState(() {
                            _reloading = true;
                          });

                          bool result = await _reload();

                          setState(() {
                            _reloading = false;
                          });

                          if (result) {
                            showSnackbar(context, "완료", "데이터베이스 최신화 완료.");
                          } else {
                            showSnackbar(context, "실패", "왜 실패했는지 알리가 없죠?");
                          }
                        },
                      ),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget searchBox(Config config) {
    return SizedBox(
      child: Autocomplete<String>(
        optionsViewBuilder: (context, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
            ),
            child: SizedBox(
              height: 52.0 * options.length,
              width: 300, // <-- Right here !
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                shrinkWrap: false,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(option),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(option),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        optionsBuilder: (TextEditingValue textEditingValue) {
          return config.tableNames.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          print(selection);
          _columns(_databaseName, selection);
        },
      ),
    );
  }

  Widget cardList() {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 960) {
        return Column(
          children: [
            Row(
              children: [
                MyFieldCard(
                  title: "Domain",
                  content: "Domain 코드를 클립보드에 복사합니다.",
                  onPressed: () {},
                ),
                middleSpacerW,
                MyFieldCard(
                  title: "Mapper.java",
                  content: "Mapper Interface 코드를 클립보드에 복사합니다.",
                  onPressed: () {},
                ),
              ],
            ),
            middleSpacerH,
            Row(
              children: [
                MyFieldCard(
                  title: "Mapper.xml",
                  content: "Mybatis 코드를 클립보드에 복사합니다.",
                  onPressed: () {},
                ),
                middleSpacerW,
                MyFieldCard(
                  title: "Service",
                  content: "Service 코드 양식을 다운로드 받습니다.",
                  onPressed: () {},
                ),
              ],
            )
          ],
        );
      } else {
        return Row(
          children: [
            MyFieldCard(
              title: "Domain",
              content: "Domain 코드를 클립보드에 복사합니다.",
              onPressed: () {},
            ),
            middleSpacerW,
            MyFieldCard(
              title: "Mapper.java",
              content: "Mapper Interface 코드를 클립보드에 복사합니다.",
              onPressed: () {},
            ),
            middleSpacerW,
            MyFieldCard(
              title: "Mapper.xml",
              content: "Mybatis 코드를 클립보드에 복사합니다.",
              onPressed: () {},
            ),
            middleSpacerW,
            MyFieldCard(
              title: "Service",
              content: "Service 코드 양식을 다운로드 받습니다.",
              onPressed: () {},
            ),
          ],
        );
      }
    });
  }

  Widget columnsList(List<MColumn> userColumns, List<MColumn> svnColumns) {
    final Color changedItemColor = Colors.red.withOpacity(0.3);
    final Color itemColor = const Color(0xFFE8DEF8).withOpacity(0.7);

    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ReorderableListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                for (int index = 0; index < userColumns.length; index += 1)
                  ListTile(
                    key: Key('$index'),
                    tileColor: userColumns[index].name != svnColumns[index].name
                        ? changedItemColor
                        : greyLightest,
                    title: Text(userColumns[index].name),
                  ),
              ],
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final MColumn column = userColumns.removeAt(oldIndex);
                  userColumns.insert(newIndex, column);
                });
              },
            ),
          ),
          spacerW,
          Expanded(
            child: ReorderableListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                for (int index = 0; index < svnColumns.length; index += 1)
                  ListTile(
                    key: Key('$index'),
                    tileColor: userColumns[index].name != svnColumns[index].name
                        ? changedItemColor
                        : greyLightest,
                    title: Text(svnColumns[index].name),
                  ),
              ],
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final MColumn column = svnColumns.removeAt(oldIndex);
                  svnColumns.insert(newIndex, column);
                  for (MColumn c in svnColumns) {
                    print(c.id);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _columns(String databaseName, String tableName) async {
    Response response = await request(context,
        Api.restClient.columns(myAccessToken(), databaseName, tableName));
    setState(() {
      _svnColumns = response.getColumnsResponseDto().svnColumns;
      _userColumns = response.getColumnsResponseDto().userColumns;
    });
  }

  Future<List<String>> _tablenames(String databaseName) async {
    Response response = await request(
        context, Api.restClient.tablenames(myAccessToken(), databaseName));
    return response.getTableNames();
  }

  Future<bool> _reload() async {
    String? path = SharedPreferences.prefs
        .getString(Preferences.localPersistencePath.name);

    if (path == null) {
      MyAlertDialog(
        context: context,
        title: "설정 오류",
        content: const Text("설정 화면에서 작업폴더를 등록해주세요."),
      );
    }

    File csttecFile = File("$path/db-populate.sql");
    File centerFile = File("$path/center-db-populate.sql");
    String csttecSql = await csttecFile.readAsString();
    String centerSql = await centerFile.readAsString();

    ReloadRequestDto reloadRequestDto =
        ReloadRequestDto(dbPopulate: csttecSql, centerDbPopulate: centerSql);
    Response response = await request(
        context, Api.restClient.reload(myAccessToken(), reloadRequestDto));
    if (response.ok()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: grey,
          width: 0.2,
        ),
      ),
      child: ChangeNotifierProvider(
        create: (_) => Config(),
        builder: (context, _) {
          final config = context.watch<Config>();
          return Scrollbar(
            thumbVisibility: true,
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header(config),
                    biggerSpacerH,
                    searchBox(config),
                    biggerSpacerH,
                    cardList(),
                    biggerSpacerH,
                    columnsList(_userColumns, _svnColumns),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

@immutable
class User {
  const User({
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  @override
  String toString() {
    return '$name, $email';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is User && other.name == name && other.email == email;
  }

  @override
  int get hashCode => Object.hash(email, name);
}
