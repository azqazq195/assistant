import 'dart:ffi';
import 'dart:io';

import 'package:assistant/constants/color.dart';
import 'package:assistant/helpers/shared_preferences.dart';
import 'package:assistant/pages/database/components/svn_login.dart';
import 'package:assistant/widgets/custom_text.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:assistant/helpers/logger.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({Key? key}) : super(key: key);

  @override
  _DatabasePageState createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  final _svnUsernameTextEditController = TextEditingController();
  final _svnPasswordTextEditController = TextEditingController();
  final _mysqlUsernameTextEditController = TextEditingController();
  final _mysqlPasswordTextEditController = TextEditingController();

  String svnPath =
      "https://intranet-fs.csttec.com:5443/svn/cstone/server/trunk/server_DevTrunk/src/main/java/com/csttec/server/persistence";
  String svnUsername = '';
  String svnPassword = '';
  String mysqlUsername = '';
  String mysqlPassword = '';

  @override
  void initState() {
    super.initState();
    _svnInfo();
    _mysqlInfo();
  }

  @override
  void dispose() {
    _svnUsernameTextEditController.dispose();
    _svnPasswordTextEditController.dispose();
    super.dispose();
  }

  void _svnInfo() {
    svnUsername = SharedPreferences.prefs.getString("svn_username") ?? '';
    svnPassword = SharedPreferences.prefs.getString("svn_password") ?? '';
    _svnUsernameTextEditController.text = svnUsername;
    _svnPasswordTextEditController.text = svnPassword;
  }

  void _mysqlInfo() {
    mysqlUsername = SharedPreferences.prefs.getString("mysql_username") ?? '';
    mysqlPassword = SharedPreferences.prefs.getString("mysql_password") ?? '';
    _mysqlUsernameTextEditController.text = mysqlUsername;
    _mysqlPasswordTextEditController.text = mysqlPassword;
  }

  Future<bool> _svnAuthentication() async {
    Logger.d("svnAuthentication");
    var result = false;
    var shell = Shell(throwOnError: false);
    List<ProcessResult> _processResult = await shell.run('''
    svn info --username $svnUsername --password $svnPassword $svnPath
    ''');
    for (var processResult in _processResult) {
      if (processResult.outText.isNotEmpty) {
        result = true;
      }
      if (processResult.errText.isNotEmpty) {}
    }
    return result;
  }

  Future<bool> _svnCheckout() async {
    Logger.d("svnCheckout");
    var result = false;
    var shell = Shell(throwOnError: false);
    shell = shell.pushd(Logger.localDirectory);
    List<ProcessResult> _processResult = await shell.run('''
     svn checkout --username $svnUsername --password $svnPassword $svnPath
     ''');
    shell = shell.popd();
    for (var processResult in _processResult) {
      if (processResult.outText.isNotEmpty) {
        result = true;
      }
      if (processResult.errText.isNotEmpty) {}
    }
    return result;
  }

  Future<bool> _sqlUpdate() async {
    Logger.d("sqlUpdate");
    var result = false;
    var shell = Shell(throwOnError: false);
    shell = shell.pushd(Logger.localDirectory);
    shell = shell.pushd('persistence');
    // mysql -u $mysqlUsername -p$mysqlPassword < db-populate.sql
    // mysql -u $mysqlUsername -p$mysqlPassword < center-db-populate.sql
    List<ProcessResult> _processResult = await shell.run('''
     mysql -u $mysqlUsername < center-db-populate.sql
     ''');
    shell = shell.popd();
    for (var processResult in _processResult) {
      if (processResult.outText.isNotEmpty) {
        result = true;
      }
      if (processResult.errText.isNotEmpty) {}
    }
    return result;
  }

  Widget svnLogin() {
    return Row(
      children: [
        const SizedBox(
          width: 120,
          child: CustomText(
            text: '계정 정보',
            size: 16,
            color: fontDefault,
            weight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12,
          width: 12,
          child: FutureBuilder(
            future: _svnAuthentication(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return const fluent.Icon(
                      fluent.FluentIcons.skype_check,
                      color: checked,
                    );
                  } else {
                    return const fluent.Icon(
                      fluent.FluentIcons.cancel,
                      color: canceled,
                    );
                  }
                } else {
                  return const Text('Empty data.');
                }
              } else {
                return const Text('Error.');
              }
            },
          ),
        ),
        const SizedBox(width: 36),
        OutlinedButton(
          onPressed: () {
            var _usernameField = TextField(
              controller: _svnUsernameTextEditController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderFocused, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderGrey, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                isDense: true,
                hintText: '계정 이름',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: fontGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
            var _passwordField = TextField(
              controller: _svnPasswordTextEditController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderFocused, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderGrey, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                isDense: true,
                hintText: '비밀번호',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: fontGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );

            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "SVN 계정 정보 입력",
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 38,
                        width: 348,
                        child: _usernameField,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 38,
                        width: 348,
                        child: _passwordField,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      OutlinedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(348, 38),
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(color: borderGrey, width: 0.5),
                          ),
                          overlayColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return btnPressed;
                              }
                              if (states.contains(MaterialState.hovered)) {
                                return btnHovered;
                              }
                              return null;
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          SharedPreferences.prefs.setString('svn_username',
                              _svnUsernameTextEditController.text);
                          SharedPreferences.prefs.setString('svn_password',
                              _svnPasswordTextEditController.text);
                          setState(() {
                            _svnInfo();
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 6,
                            ),
                            CustomText(
                              text: 'SubVersion 계정 로그인',
                              size: 12,
                              color: fontDefault,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const CustomText(
            text: '로그인',
            size: 12,
            color: fontPrimary,
            weight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget svnLoginInfo() {
    return Row(
      children: [
        SizedBox(width: 120, child: Text(svnUsername)),
        const SizedBox(width: 12),
        SizedBox(width: 100, child: Text(svnPassword)),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget svnCheckout() {
    return Row(
      children: [
        const SizedBox(
          width: 120,
          child: CustomText(
            text: 'Checkout',
            size: 16,
            color: fontDefault,
            weight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12,
          width: 12,
          child: FutureBuilder(
            future: _svnCheckout(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return const fluent.Icon(
                      fluent.FluentIcons.skype_check,
                      color: checked,
                    );
                  } else {
                    return const fluent.Icon(
                      fluent.FluentIcons.cancel,
                      color: canceled,
                    );
                  }
                } else {
                  return const Text('Empty data.');
                }
              } else {
                return const Text('Error.');
              }
            },
          ),
        ),
        const SizedBox(width: 36),
      ],
    );
  }

  Widget mysqlLogin() {
    return Row(
      children: [
        const SizedBox(
          width: 120,
          child: CustomText(
            text: '계정 정보',
            size: 16,
            color: fontDefault,
            weight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        const SizedBox(width: 36),
        OutlinedButton(
          onPressed: () {
            var _usernameField = TextField(
              controller: _mysqlUsernameTextEditController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderFocused, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderGrey, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                isDense: true,
                hintText: '계정 이름',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: fontGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
            var _passwordField = TextField(
              controller: _mysqlPasswordTextEditController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderFocused, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderGrey, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                isDense: true,
                hintText: '비밀번호',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: fontGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );

            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "MySql 계정 정보 입력",
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 38,
                        width: 348,
                        child: _usernameField,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 38,
                        width: 348,
                        child: _passwordField,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      OutlinedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(348, 38),
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(color: borderGrey, width: 0.5),
                          ),
                          overlayColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return btnPressed;
                              }
                              if (states.contains(MaterialState.hovered)) {
                                return btnHovered;
                              }
                              return null;
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          SharedPreferences.prefs.setString('mysql_username',
                              _mysqlUsernameTextEditController.text);
                          SharedPreferences.prefs.setString('mysql_password',
                              _mysqlPasswordTextEditController.text);
                          setState(() {
                            _mysqlInfo();
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 6,
                            ),
                            CustomText(
                              text: 'MySql 계정 로그인',
                              size: 12,
                              color: fontDefault,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const CustomText(
            text: '로그인',
            size: 12,
            color: fontPrimary,
            weight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget mysqlUpdate() {
    return Row(
      children: [
        const SizedBox(
          width: 120,
          child: CustomText(
            text: 'Update',
            size: 16,
            color: fontDefault,
            weight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12,
          width: 12,
          child: FutureBuilder(
            future: _sqlUpdate(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return const fluent.Icon(
                      fluent.FluentIcons.skype_check,
                      color: checked,
                    );
                  } else {
                    return const fluent.Icon(
                      fluent.FluentIcons.cancel,
                      color: canceled,
                    );
                  }
                } else {
                  return const Text('Empty data.');
                }
              } else {
                return const Text('Error.');
              }
            },
          ),
        ),
        const SizedBox(width: 36),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'SubVersion',
            size: 24,
            color: fontDefault,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: 24),
          svnLogin(),
          const SizedBox(height: 12),
          svnLoginInfo(),
          const SizedBox(height: 24),
          svnCheckout(),
          const SizedBox(height: 24),
          const CustomText(
            text: 'MySql',
            size: 24,
            color: fontDefault,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: 24),
          mysqlLogin(),
          const SizedBox(height: 24),
          mysqlUpdate(),
        ],
      ),
    );
  }
}
