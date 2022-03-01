import 'dart:io';
import 'package:assistant/helpers/logger.dart';
import 'package:assistant/helpers/shared_preferences.dart';
import 'package:assistant/helpers/toast_message.dart';
import 'package:assistant/constants/color.dart';
import 'package:assistant/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:process_run/shell.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _svnProjectPathEditController = TextEditingController();
  final _svnProjectPersistencePathEditController = TextEditingController();
  final _svnPathTextEditController = TextEditingController();
  final _svnUsernameTextEditController = TextEditingController();
  final _svnPasswordTextEditController = TextEditingController();
  final _mysqlPathTextEditController = TextEditingController();
  final _mysqlUsernameTextEditController = TextEditingController();
  final _mysqlPasswordTextEditController = TextEditingController();

  String _svnProjectPath = '';
  String _svnProjectPersistencePath = '';
  String _svnPath = '';
  String _svnUsername = '';
  String _svnPassword = '';

  String _mysqlPath = '';
  String _mysqlUsername = '';
  String _mysqlPassword = '';

  @override
  void initState() {
    super.initState();
    _svnInfo();
    _mysqlInfo();
  }

  @override
  void dispose() {
    _svnProjectPathEditController.dispose();
    _svnProjectPersistencePathEditController.dispose();
    _svnPathTextEditController.dispose();
    _svnUsernameTextEditController.dispose();
    _svnPasswordTextEditController.dispose();

    _mysqlPathTextEditController.dispose();
    _mysqlUsernameTextEditController.dispose();
    _mysqlPasswordTextEditController.dispose();
    super.dispose();
  }

  void _svnInfo() {
    _svnProjectPath =
        SharedPreferences.prefs.getString(Preferences.svnProjectPath.name) ??
            '';
    _svnProjectPersistencePath = SharedPreferences.prefs
            .getString(Preferences.svnProjectPersistencePath.name) ??
        '';
    _svnUsername =
        SharedPreferences.prefs.getString(Preferences.svnUsername.name) ?? '';
    _svnPassword =
        SharedPreferences.prefs.getString(Preferences.svnPassword.name) ?? '';
    _svnPath =
        SharedPreferences.prefs.getString(Preferences.svnPath.name) ?? '';

    _svnProjectPathEditController.text = _svnProjectPath;
    _svnProjectPersistencePathEditController.text = _svnProjectPersistencePath;
    _svnUsernameTextEditController.text = _svnUsername;
    _svnPasswordTextEditController.text = _svnPassword;
    _svnPathTextEditController.text = _svnPath;
  }

  void _mysqlInfo() {
    _mysqlPath =
        SharedPreferences.prefs.getString(Preferences.mysqlPath.name) ?? '';
    _mysqlUsername =
        SharedPreferences.prefs.getString(Preferences.mysqlUsername.name) ?? '';
    _mysqlPassword =
        SharedPreferences.prefs.getString(Preferences.mysqlPassword.name) ?? '';
    _mysqlUsernameTextEditController.text = _mysqlUsername;
    _mysqlPasswordTextEditController.text = _mysqlPassword;
    _mysqlPathTextEditController.text = _mysqlPath;
  }

  Future<bool> _svnAuthentication() async {
    Logger.i("svnAuthentication");
    var result = false;
    var shell = Shell(throwOnError: false);
    List<ProcessResult> _processResult = await shell.run('''
    "$_svnPath/svn.exe" info --username $_svnUsername --password $_svnPassword "$_svnProjectPath"
    ''');
    for (var processResult in _processResult) {
      if (processResult.outText.isNotEmpty) {
        Logger.d("svn authentication succeed.");
        result = true;
      }
      if (processResult.errText.isNotEmpty) {
        Logger.w("svn authentication failed.");
      }
    }
    return result;
  }

  Future<bool> svnCheckout() async {
    Logger.i("svnCheckout");
    var result = false;
    var shell = Shell(throwOnError: false);
    shell = shell.pushd(Logger.localDirectory);
    List<ProcessResult> _processResult = await shell.run('''
     "$_svnPath/svn.exe" checkout --username $_svnUsername --password $_svnPassword "$_svnProjectPath"
     ''');
    shell = shell.popd();
    for (var processResult in _processResult) {
      if (processResult.outText.isNotEmpty) {
        Logger.d("svn checkout succeed.");
        result = true;
      }
      if (processResult.errText.isNotEmpty) {
        Logger.w("svn checkout failed.");
      }
    }
    return result;
  }

  Future<bool> sqlUpdate() async {
    Logger.i("sqlUpdate");
    var result = false;
    var temp = _svnProjectPath
        .substring(0, _svnProjectPath.lastIndexOf("/"))
        .split('/');
    var directory = temp[temp.length - 1];
    directory += "/$_svnProjectPersistencePath";

    Logger.v("persistence directory: $directory");

    var shell = Shell(throwOnError: false);
    shell = shell.pushd(Logger.localDirectory);
    shell = shell.pushd(directory);

    List<ProcessResult> _processResult = _mysqlPassword.isEmpty
        ? await shell.run('''
      "$_mysqlPath/mysql.exe" -u $_mysqlUsername < db-populate.sql
      "$_mysqlPath/mysql.exe" -u $_mysqlUsername < center-db-populate.sql
      ''')
        : await shell.run('''
      "$_mysqlPath/mysql.exe" -u $_mysqlUsername -p$_mysqlPassword < db-populate.sql
      "$_mysqlPath/mysql.exe" -u $_mysqlUsername -p$_mysqlPassword < center-db-populate.sql
      ''');
    shell = shell.popd();
    for (var processResult in _processResult) {
      if (processResult.outText.isNotEmpty) {
        Logger.d(processResult.outText);
        result = true;
      }
      if (processResult.errText.isNotEmpty) {
        Logger.w(processResult.errText);
      }
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
        const SizedBox(width: 48),
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
                    "SVN 계정 정보",
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
                          SharedPreferences.prefs.setString(
                              Preferences.svnUsername.name,
                              _svnUsernameTextEditController.text);
                          SharedPreferences.prefs.setString(
                              Preferences.svnPassword.name,
                              _svnPasswordTextEditController.text);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 6,
                            ),
                            CustomText(
                              text: 'SubVersion 계정 입력',
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
            text: '입력',
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
        SizedBox(width: 120, child: Text(_svnUsername)),
        const SizedBox(width: 12),
        SizedBox(width: 100, child: Text(_svnPassword)),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget svnPaths() {
    return Row(
      children: [
        const SizedBox(
          width: 120,
          child: CustomText(
            text: 'Svn Paths',
            size: 16,
            color: fontDefault,
            weight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        const SizedBox(width: 36),
        OutlinedButton(
          onPressed: () {
            var svnPathSection = Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 250,
                  child: CustomText(
                    text: 'Svn Path',
                    size: 16,
                    color: fontDefault,
                    weight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 38,
                  width: 380,
                  child: TextField(
                    readOnly: true,
                    style: const TextStyle(
                        fontSize: 14, overflow: TextOverflow.fade),
                    controller: _svnPathTextEditController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: borderFocused, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderGrey, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      isDense: true,
                      hintText: '경로',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: fontGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  height: 38,
                  width: 84,
                  child: OutlinedButton(
                    style: ButtonStyle(
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
                    onPressed: () async {
                      String? selectedDirectory =
                          await FilePicker.platform.getDirectoryPath();

                      if (selectedDirectory == null) {
                        // User canceled the picker
                      } else {
                        _svnPathTextEditController.text = selectedDirectory;
                        SharedPreferences.prefs.setString(
                            Preferences.svnPath.name, selectedDirectory);
                      }
                    },
                    child: const CustomText(
                      text: '폴더 선택',
                      size: 12,
                      color: fontDefault,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
            var svnProjectPathSection = Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 250,
                  child: CustomText(
                    text: 'Svn Project Path',
                    size: 16,
                    color: fontDefault,
                    weight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 38,
                  width: 470,
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 14, overflow: TextOverflow.fade),
                    controller: _svnProjectPathEditController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: borderFocused, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderGrey, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      isDense: true,
                      hintText: '경로',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: fontGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
            var svnProjectPersistencePathSection = Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 250,
                  child: CustomText(
                    text: 'Svn Project Persistence Path',
                    size: 16,
                    color: fontDefault,
                    weight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 38,
                  width: 470,
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 14, overflow: TextOverflow.fade),
                    controller: _svnProjectPersistencePathEditController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: borderFocused, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderGrey, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      isDense: true,
                      hintText: '경로',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: fontGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );

            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "Svn Paths",
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      svnPathSection,
                      const SizedBox(height: 12),
                      svnProjectPathSection,
                      const SizedBox(height: 12),
                      svnProjectPersistencePathSection,
                      const SizedBox(height: 12),
                      Container(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 84,
                          height: 38,
                          child: OutlinedButton(
                            style: ButtonStyle(
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
                              SharedPreferences.prefs.setString(
                                  Preferences.svnPath.name,
                                  _svnPathTextEditController.text);
                              SharedPreferences.prefs.setString(
                                  Preferences.svnProjectPath.name,
                                  _svnProjectPathEditController.text);
                              SharedPreferences.prefs.setString(
                                  Preferences.svnProjectPersistencePath.name,
                                  _svnProjectPersistencePathEditController
                                      .text);
                            },
                            child: const CustomText(
                              text: '확인',
                              size: 12,
                              color: fontDefault,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const CustomText(
            text: '입력',
            size: 12,
            color: fontPrimary,
            weight: FontWeight.bold,
          ),
        ),
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
        const SizedBox(width: 48),
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
                    "MySql 계정 정보",
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
                          SharedPreferences.prefs.setString(
                              Preferences.mysqlUsername.name,
                              _mysqlUsernameTextEditController.text);
                          SharedPreferences.prefs.setString(
                              Preferences.mysqlPassword.name,
                              _mysqlPasswordTextEditController.text);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 6,
                            ),
                            CustomText(
                              text: 'MySql 계정 입력',
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
            text: '입력',
            size: 12,
            color: fontPrimary,
            weight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget mysqlInfo() {
    return Row(
      children: [
        SizedBox(width: 120, child: Text(_mysqlUsername)),
        const SizedBox(width: 12),
        SizedBox(width: 100, child: Text(_mysqlPassword)),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget mysqlPaths() {
    return Row(
      children: [
        const SizedBox(
          width: 120,
          child: CustomText(
            text: 'Mysql Paths',
            size: 16,
            color: fontDefault,
            weight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        const SizedBox(width: 36),
        OutlinedButton(
          onPressed: () {
            var mysqlPathSection = Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 250,
                  child: CustomText(
                    text: 'Mysql Path',
                    size: 16,
                    color: fontDefault,
                    weight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 38,
                  width: 380,
                  child: TextField(
                    readOnly: true,
                    style: const TextStyle(
                        fontSize: 14, overflow: TextOverflow.fade),
                    controller: _mysqlPathTextEditController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: borderFocused, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderGrey, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      isDense: true,
                      hintText: '경로',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: fontGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  height: 38,
                  width: 84,
                  child: OutlinedButton(
                    style: ButtonStyle(
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
                    onPressed: () async {
                      String? selectedDirectory =
                          await FilePicker.platform.getDirectoryPath();

                      if (selectedDirectory == null) {
                        // User canceled the picker
                      } else {
                        _mysqlPathTextEditController.text = selectedDirectory;
                        SharedPreferences.prefs.setString(
                            Preferences.mysqlPath.name, selectedDirectory);
                      }
                    },
                    child: const CustomText(
                      text: '폴더 선택',
                      size: 12,
                      color: fontDefault,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );

            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "Mysql Paths",
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      mysqlPathSection,
                      const SizedBox(height: 12),
                      Container(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 84,
                          height: 38,
                          child: OutlinedButton(
                            style: ButtonStyle(
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
                              SharedPreferences.prefs.setString(
                                  Preferences.mysqlPath.name,
                                  _mysqlPathTextEditController.text);
                            },
                            child: const CustomText(
                              text: '확인',
                              size: 12,
                              color: fontDefault,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const CustomText(
            text: '입력',
            size: 12,
            color: fontPrimary,
            weight: FontWeight.bold,
          ),
        ),
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
          const SizedBox(height: 12),
          svnLogin(),
          const SizedBox(height: 6),
          svnLoginInfo(),
          const SizedBox(height: 12),
          svnPaths(),
          const SizedBox(height: 48),
          const CustomText(
            text: 'MySql',
            size: 24,
            color: fontDefault,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: 12),
          mysqlLogin(),
          const SizedBox(height: 6),
          mysqlInfo(),
          const SizedBox(height: 12),
          mysqlPaths(),
          const SizedBox(height: 48),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  svnCheckout();
                },
                child: const Text("svn checkout"),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  sqlUpdate();
                },
                child: const Text("sql update"),
              ),
            ],
          ),
          const SizedBox(height: 48),
          TextButton(
              onPressed: () {
                Logger.i(
                    '${SharedPreferences.prefs.getString('theme')} => dark');
                SharedPreferences.prefs.setString('theme', 'dark');
                FlutterToast(context, "재실행 시 적용됩니다.");
              },
              child: const Text("다크 모드")),
          TextButton(
              onPressed: () {
                Logger.i(
                    '${SharedPreferences.prefs.getString('theme')} => light');
                SharedPreferences.prefs.setString('theme', 'light');
                FlutterToast(context, "재실행 시 적용됩니다.");
              },
              child: const Text("라이트 모드")),
          TextButton(
            onPressed: () {
              SharedPreferences.prefs.setBool('auto_login', false);
            },
            child: const Text("로그아웃"),
          ),
        ],
      ),
    );
  }
}
