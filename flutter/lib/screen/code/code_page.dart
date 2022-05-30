import 'dart:io';

import 'package:assistant/api/api.dart';
import 'package:assistant/api/client/rest_client.dart';
import 'package:assistant/api/dto/code_dto.dart';
import 'package:assistant/components/my_alert_dialog.dart';
import 'package:assistant/components/my_elevated_button.dart';
import 'package:assistant/components/my_field_card.dart';
import 'package:assistant/components/my_text_button.dart';
import 'package:assistant/provider/config.dart';
import 'package:assistant/utils/logger.dart';
import 'package:assistant/utils/shared_preferences.dart';
import 'package:assistant/utils/utils.dart';
import 'package:assistant/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/my_text_field.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  final List _serviceMethods = [
    'Create',
    'Get',
    'Edit',
    'List',
    'Delete',
    'Add',
    'Remove'
  ];
  // ignore: prefer_final_fields
  List<bool> _downlaodServiceMethods = [
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  bool _reloading = false;
  String _databaseName = "";
  MTable? _svnTable;
  MTable? _userTable;
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

                          bool result = await _reload(context);

                          setState(() {
                            _reloading = false;
                          });

                          if (result) {
                            showSnackbar(context, "완료", "데이터베이스 최신화 완료.");
                          } else {
                            showSnackbar(context, "실패", "불러오기 실패.");
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: grey, width: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 7,
                    offset: const Offset(7, 7), // changes position of shadow
                  ),
                ],
              ),
              height: 52.0 * options.length,
              width: 800,
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
          _columns(_databaseName, selection);
        },
      ),
    );
  }

  Widget cardList() {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          MyFieldCard(
            title: "Domain",
            content: "Domain 코드를 클립보드에 복사합니다.",
            onPressed: () async {
              if (_userTable == null) {
                showSnackbar(context, "경고", "테이블이 선택되지 않았습니다.");
                return;
              }
              String domain = await _domain(_userTable!.id);
              Clipboard.setData(ClipboardData(text: domain));
              showSnackbar(context, "완료", "클립보드에 복사되었습니다.");
            },
          ),
          middleSpacerW,
          MyFieldCard(
            title: "Mapper.java",
            content: "Mapper Interface 코드를 클립보드에 복사합니다.",
            onPressed: () async {
              if (_userTable == null) {
                showSnackbar(context, "경고", "테이블이 선택되지 않았습니다.");
                return;
              }
              String mapper = await _mapper(_userTable!.id);
              Clipboard.setData(ClipboardData(text: mapper));
              showSnackbar(context, "완료", "클립보드에 복사되었습니다.");
            },
          ),
          middleSpacerW,
          MyFieldCard(
            title: "Mapper.xml",
            content: "Mybatis 코드를 클립보드에 복사합니다.",
            onPressed: () async {
              if (_userTable == null) {
                showSnackbar(context, "경고", "테이블이 선택되지 않았습니다.");
                return;
              }
              String mybatis = await _mybatis(_userTable!.id);
              Clipboard.setData(ClipboardData(text: mybatis));
              showSnackbar(context, "완료", "클립보드에 복사되었습니다.");
            },
          ),
          middleSpacerW,
          MyFieldCard(
            title: "Service",
            content: "Service 코드 양식을 다운로드 받습니다.",
            onPressed: () {
              if (_userTable == null) {
                showSnackbar(context, "경고", "테이블이 선택되지 않았습니다.");
                return;
              }
              TextEditingController packageNameController =
                  TextEditingController();
              TextEditingController authorController = TextEditingController();
              authorController.text =
                  SharedPreferences.prefs.getString(Preferences.author.name) ??
                      '';

              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: const Text(
                          "*Service.java 다운로드",
                          style: TextStyle(
                            color: colorLightest,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: SizedBox(
                          height: 400,
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("서비스 선택"),
                                  const SizedBox(height: 5),
                                  for (int index = 0;
                                      index < _serviceMethods.length;
                                      index += 1)
                                    CheckboxListTile(
                                      title: Text(
                                          '${_serviceMethods[index]}${_userTable!.name}Service'),
                                      value: _downlaodServiceMethods[index],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _downlaodServiceMethods[index] =
                                              value!;
                                        });
                                      },
                                    ),
                                  middleSpacerH,
                                  const Text("Package Name"),
                                  const SizedBox(height: 5),
                                  MyTextField(
                                      height: 30,
                                      width: 200,
                                      hintText: "Pacakge Name",
                                      controller: packageNameController),
                                  middleSpacerH,
                                  const Text("Author"),
                                  const SizedBox(height: 5),
                                  MyTextField(
                                      height: 30,
                                      width: 200,
                                      hintText: "Author",
                                      controller: authorController),
                                ]),
                          ),
                        ),
                        actions: [
                          MyElevatedButton(
                            height: 46,
                            width: 200,
                            text: "다운로드",
                            fontSize: 16,
                            onPressed: () {
                              SharedPreferences.prefs.setString(
                                  Preferences.author.name,
                                  authorController.text);
                              _service(
                                _userTable!,
                                packageNameController.text,
                                authorController.text,
                              );
                            },
                          ),
                          middleSpacerW,
                          MyTextButton(
                            height: 46,
                            width: 200,
                            text: "닫기",
                            fontSize: 16,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      );
    });
  }

  Widget columnsList() {
    final Color changedItemColor = Colors.red.withOpacity(0.3);
    final Color addedItemColor = Colors.green.withOpacity(0.3);
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _userTable == null
                  ? [Container()]
                  : [
                      const Text(
                        "로컬",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      spacerH,
                      ReorderableListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          for (int index = 0;
                              index < _userTable!.mcolumns.length;
                              index += 1)
                            ListTile(
                              key: Key('$index'),
                              tileColor: greyLightest,
                              title: Text(_userTable!.mcolumns[index].name),
                            ),
                        ],
                        onReorder: (int oldIndex, int newIndex) {
                          setState(() {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final MColumn column =
                                _userTable!.mcolumns.removeAt(oldIndex);
                            _userTable!.mcolumns.insert(newIndex, column);
                          });
                        },
                      ),
                    ],
            ),
          ),
          spacerW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _svnTable == null
                  ? [Container()]
                  : [
                      const Text(
                        "SVN",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      spacerH,
                      ReorderableListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          for (int index = 0;
                              index < _svnTable!.mcolumns.length;
                              index += 1)
                            ListTile(
                              key: Key('$index'),
                              tileColor: greyLightest,
                              title: Text(_svnTable!.mcolumns[index].name),
                            ),
                        ],
                        onReorder: (int oldIndex, int newIndex) {
                          showSnackbar(context, "알림", "SVN 칼럼은 조정할 수 없습니다.");
                        },
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _columns(String databaseName, String tableName) async {
    Response response = await request(context,
        Api.restClient.table(myAccessToken(), databaseName, tableName));
    setState(() {
      _svnTable = response.getTableResponseDto().svnTable;
      _userTable = response.getTableResponseDto().userTable;
    });
  }

  Future<List<String>> _tablenames(String databaseName) async {
    Response response = await request(
        context, Api.restClient.tablenames(myAccessToken(), databaseName));
    return response.getTableNames();
  }

  Future<bool> _reload(context) async {
    String? path = SharedPreferences.prefs
        .getString(Preferences.localPersistencePath.name);

    if (path == null) {
      MyAlertDialog(
        context: context,
        title: "설정 오류",
        content: const Text("설정 화면에서 작업폴더를 등록해주세요."),
      ).show();
      return false;
    }

    File csttecFile = File("$path/db-populate.sql");
    if (!await csttecFile.exists()) {
      MyAlertDialog(
        context: context,
        title: "설정 오류",
        content: const Text(
            "지정된 경로에 파일(db-populate.sql)이 존재하지 않습니다.\n경로 및 파일을 확인해 주세요."),
      ).show();
      return false;
    }
    File centerFile = File("$path/center-db-populate.sql");
    if (!await centerFile.exists()) {
      MyAlertDialog(
        context: context,
        title: "설정 오류",
        content: const Text(
            "지정된 경로에 파일(center-db-populate.sql)이 존재하지 않습니다.\n경로 및 파일을 확인해 주세요."),
      ).show();
      return false;
    }
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

  Future<String> _domain(int tableId) async {
    Response response =
        await request(context, Api.restClient.domain(myAccessToken(), tableId));
    return response.data;
  }

  Future<String> _mapper(int tableId) async {
    Response response =
        await request(context, Api.restClient.mapper(myAccessToken(), tableId));
    return response.data;
  }

  Future<String> _mybatis(int tableId) async {
    Response response = await request(
        context, Api.restClient.mybatis(myAccessToken(), tableId));
    return response.data;
  }

  Future<void> _service(
      MTable mtable, String packageName, String author) async {
    List<Map<String, String>> services = [];
    for (int index = 0; index < _serviceMethods.length; index += 1) {
      if (!_downlaodServiceMethods[index]) {
        continue;
      }

      String service = """package com.csttec.server.service.$packageName;

import org.springframework.stereotype.Service;

import com.csttec.server.core.AService;
import com.csttec.server.core.Bean;
import com.csttec.server.domain.Session;

/**
 * 설명.
 * 
 * <pre>

 * IN: NONE
 *  
 * OUT: NONE
 * 
 * </pre>
 * 
 * @author $author
 *
 */
@Service("$packageName.${_serviceMethods[index]}${mtable.name}")
public class ${_serviceMethods[index]}${mtable.name}Service extends AService{

	@Override
	protected void doExecute(Bean input, Bean output) {
		Session session = (Session) input.get("session");
	}

}
      """;
      services.add({
        "fileName": "${_serviceMethods[index]}${mtable.name}Service",
        "service": service
      });
    }
    Logger.i("Download Serivces");
    final localDirectory = Logger.localDirectory;
    final directory = Directory('$localDirectory/service');
    if (await directory.exists()) {
      directory.deleteSync(recursive: true);
    }
    await directory.create();
    for (Map<String, String> service in services) {
      File('${directory.path}/${service['fileName']!}.java')
          .writeAsString(service['service']!);
    }
    await launchUrl(Uri.file(directory.path));
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
                    columnsList(),
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
