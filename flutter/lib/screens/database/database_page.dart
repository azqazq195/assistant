import 'dart:io';

import 'package:fluent/utils/logger.dart';
import 'package:fluent/utils/shared_preferences.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:fluent/utils/utils.dart';
import 'package:process_run/shell.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({Key? key}) : super(key: key);

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  Widget _buildButtons() {
    return Row(
      children: [
        Card(
          child: InfoLabel(
            label: 'SubVersion',
            labelStyle: const TextStyle(fontSize: 16),
            child: Container(
              width: 200,
              alignment: Alignment.centerRight,
              child: Button(
                child: const Text('Check Out'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ContentDialog(
                      title: const Text('Check out from latest revision?'),
                      content: const Text(
                        'This checkout is independent of your workspace.',
                      ),
                      actions: [
                        FilledButton(
                          child: const Text('Check out'),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (_) => ContentDialog(
                                title: const Text('Check out...'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                        'If this is your first time, it will take some time.'),
                                    spacerH,
                                    Center(child: ProgressRing()),
                                  ],
                                ),
                              ),
                            );
                            if (await svnCheckout()) {
                              snackbar(context, 'Check out success.');
                            } else {
                              snackbar(context, 'check out failed.');
                            }
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                        Button(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        biggerSpacerW,
        Card(
          child: InfoLabel(
            label: 'MySql',
            labelStyle: const TextStyle(fontSize: 16),
            child: Container(
              width: 200,
              alignment: Alignment.centerRight,
              child: Button(
                child: const Text('Update'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ContentDialog(
                      title: const Text('Update local database?'),
                      content: const Text(
                        'Run db-populate.sql and center-db-populate.sql from check outed subversion.',
                      ),
                      actions: [
                        FilledButton(
                          child: const Text('Update'),
                          onPressed: () {
                            sqlUpdate();
                            Navigator.pop(context);
                          },
                        ),
                        Button(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> svnCheckout() async {
    Logger.i('svn check out...');

    final svnUsername =
        SharedPreferences.prefs.getString(Preferences.svnUsername.name) ?? '';
    final svnPassword =
        SharedPreferences.prefs.getString(Preferences.svnPassword.name) ?? '';
    final svnPath =
        SharedPreferences.prefs.getString(Preferences.svnPath.name) ?? '';
    final svnUrl =
        SharedPreferences.prefs.getString(Preferences.svnUrl.name) ?? '';

    if (svnUsername.isEmpty) {
      snackbar(
          context, 'Svn user name is null.\nPlease setting at settings page.');
      Logger.d('svn user name is null.. skip svn check out.');
      return false;
    }
    if (svnPassword.isEmpty) {
      snackbar(
          context, 'Svn password is null.\nPlease setting at settings page.');
      Logger.d('svn password is null.. skip svn check out.');
      return false;
    }
    if (svnPath.isEmpty) {
      snackbar(context, 'Svn path is null.\nPlease setting at settings page.');
      Logger.d('svn path is null.. skip svn check out.');
      return false;
    }
    if (svnUrl.isEmpty) {
      snackbar(context, 'Svn url is null.\nPlease setting at settings page.');
      Logger.d('svn url is null.. skip svn check out.');
      return false;
    }

    var shell = Shell(throwOnError: false);
    shell = shell.pushd(Logger.localDirectory);
    List<ProcessResult> processResultList = await shell.run('''
     "$svnPath/svn.exe" checkout --username $svnUsername --password $svnPassword "$svnUrl"
     ''');

    if (processResultList.length > 1) {
      Logger.w(
          'processResultList length is ${processResultList.length} something wrong.');
      return false;
    }

    if (processResultList[0].exitCode == 0) {
      Logger.d(processResultList[0].outText);
      return true;
    } else {
      Logger.w(processResultList[0].errText);
      return false;
    }
  }

  Future<bool> sqlUpdate() async {
    Logger.i('sql update...');

    final mysqlUsername =
        SharedPreferences.prefs.getString(Preferences.mysqlUsername.name) ?? '';
    final mysqlPassword =
        SharedPreferences.prefs.getString(Preferences.mysqlPassword.name) ?? '';
    final mysqlPath =
        SharedPreferences.prefs.getString(Preferences.mysqlPath.name) ?? '';
    final persistencePath =
        SharedPreferences.prefs.getString(Preferences.persistencePath.name) ??
            '';

    if (mysqlUsername.isEmpty) {
      snackbar(context,
          'Mysql user name is null.\nPlease setting at settings page.');
      Logger.d('mysql user name is null.. skip sql update.');
      return false;
    }
    if (mysqlPath.isEmpty) {
      snackbar(
          context, 'Mysql path is null.\nPlease setting at settings page.');
      Logger.d('mysql path is null.. skip sql update.');
      return false;
    }
    if (persistencePath.isEmpty) {
      snackbar(context,
          'Persistence path is null.\nPlease setting at settings page.');
      Logger.d('persistence path is null.. skip sql update.');
      return false;
    }

    var sqlScript = mysqlPassword.isEmpty
        ? '''
    "$mysqlPath\\mysql.exe" -u $mysqlUsername center < center-db-populate.sql;
    '''
        : '''
    "$mysqlPath\\mysql.exe" -u $mysqlUsername -p$mysqlPassword < db-populate.sql
    "$mysqlPath\\mysql.exe" -u $mysqlUsername -p$mysqlPassword < center-db-populate.sql
    ''';

    var shell = Shell(throwOnError: false);
    shell = shell.pushd(persistencePath);

    List<ProcessResult> processResultList = await shell.run('''
    chcp 65001 
    $sqlScript
    ''');

    if (processResultList.length > 1) {
      Logger.w(
          'processResultList length is ${processResultList.length} something wrong.');
      for (var processResult in processResultList) {
        Logger.w(processResult.errText);
      }
      return false;
    }

    if (processResultList[0].exitCode == 0) {
      Logger.d(processResultList[0].outText);
      return true;
    } else {
      Logger.w(processResultList[0].errText);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('DataBase')),
      content: Padding(
        padding: EdgeInsets.only(
          bottom: kPageDefaultVerticalPadding,
          left: PageHeader.horizontalPadding(context),
          right: PageHeader.horizontalPadding(context),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildButtons(),
          ],
        ),
      ),
    );
  }
}
