import 'dart:io';

import 'package:fluent/utils/convertor.dart' as db;
import 'package:fluent/utils/logger.dart';
import 'package:fluent/utils/shared_preferences.dart';
import 'package:fluent/utils/utils.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:fluent/provider/database.dart';
import 'package:url_launcher/url_launcher.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  db.Convertor? convertor;
  List<bool> selectedService = [];
  final packageNameController = TextEditingController();
  final authorController = TextEditingController();

  @override
  void initState() {
    authorController.text =
        SharedPreferences.prefs.getString(Preferences.author.name) ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tableController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => Database(),
      builder: (context, _) {
        final database = context.watch<Database>();

        return ScaffoldPage.scrollable(
          header: PageHeader(
            title: const Text('Code'),
            commandBar: Row(
              children: [
                Button(
                  child: const Text('Load center'),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (_) => const ContentDialog(
                        title: Text('Load Database..'),
                        content: Center(child: ProgressRing()),
                      ),
                    );
                    await database.loadDatabase(db.Schema.center);
                    Navigator.pop(context);
                    snackbar(context, 'Load database success.');
                  },
                ),
                spacerW,
                Button(
                  child: const Text('Load csttec'),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (_) => const ContentDialog(
                        title: Text('Load Database..'),
                        content: Center(child: ProgressRing()),
                      ),
                    );
                    await database.loadDatabase(db.Schema.csttec);
                    Navigator.pop(context);
                    snackbar(context, 'Load database success.');
                  },
                ),
              ],
            ),
          ),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AutoSuggestBox(
                    items: database.allTableDomainList,
                    clearButtonEnabled: false,
                    controller: tableController,
                    placeholder: 'Pick a Table',
                    trailingIcon: IconButton(
                      icon: const Icon(FluentIcons.cancel),
                      onPressed: () {
                        snackbar(context,
                            'Just a trap.\nRemove the text by yourself.');
                      },
                    ),
                    onSelected: (tableDomain) {
                      database.setLocalColumnList(tableDomain);
                      database.setSvnColumnList(tableDomain);
                      setState(() {
                        if (database.getLocalTable(tableDomain) == null) {
                          convertor = null;
                        } else {
                          convertor = db.Convertor(
                              database.getLocalTable(tableDomain)!);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            biggerSpacerH,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Chip(
                      image: const CircleAvatar(
                        radius: 12.0,
                        child: FlutterLogo(size: 14.0),
                      ),
                      text: const Text('Domain'),
                      onPressed: () {
                        if (convertor == null) {
                          snackbar(context, 'Local Table is null.');
                        } else {
                          Clipboard.setData(
                              ClipboardData(text: convertor!.domain()));
                          snackbar(context, 'Copied.');
                        }
                      },
                    ),
                    biggerSpacerW,
                    Chip(
                      image: const CircleAvatar(
                        radius: 12.0,
                        child: FlutterLogo(size: 14.0),
                      ),
                      text: const Text('Mapper'),
                      onPressed: () {
                        if (convertor == null) {
                          snackbar(context, 'Local Table is null.');
                        } else {
                          Clipboard.setData(
                              ClipboardData(text: convertor!.mapper()));
                          snackbar(context, 'Copied.');
                        }
                      },
                    ),
                    biggerSpacerW,
                    Chip(
                      image: const CircleAvatar(
                        radius: 12.0,
                        child: FlutterLogo(size: 14.0),
                      ),
                      text: const Text('MyBatis'),
                      onPressed: () {
                        if (convertor == null) {
                          snackbar(context, 'Local Table is null.');
                        } else {
                          Clipboard.setData(
                              ClipboardData(text: convertor!.mybatis()));
                          snackbar(context, 'Copied.');
                        }
                      },
                    ),
                    biggerSpacerW,
                    Chip(
                      image: const CircleAvatar(
                        radius: 12.0,
                        child: FlutterLogo(size: 14.0),
                      ),
                      text: const Text('Service'),
                      onPressed: () {
                        if (convertor == null) {
                          snackbar(context, 'Local Table is null.');
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => ContentDialog(
                              title: const Text('Set Package Name And Author'),
                              content: Column(
                                children: [
                                  TextBox(
                                      placeholder: 'Package Name',
                                      controller: packageNameController,
                                      textInputAction: TextInputAction.next),
                                  TextBox(
                                      placeholder: 'Author',
                                      controller: authorController,
                                      textInputAction: TextInputAction.next),
                                ],
                              ),
                              actions: [
                                FilledButton(
                                  child: const Text('Next'),
                                  onPressed: () {
                                    SharedPreferences.prefs.setString(
                                        Preferences.author.name,
                                        authorController.text);
                                    setState(() {
                                      authorController.text =
                                          SharedPreferences.prefs.getString(
                                                  Preferences.author.name) ??
                                              '';
                                    });

                                    List<Map<String, String>> serviceList =
                                        convertor!.service(
                                            packageNameController.text,
                                            authorController.text);
                                    selectedService.clear();
                                    for (int i = 0;
                                        i < serviceList.length;
                                        i++) {
                                      selectedService.add(true);
                                    }

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: ((context, setState) {
                                            return ContentDialog(
                                              title: const Text(
                                                  'Select Service to Create'),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  for (var i = 0;
                                                      i < serviceList.length;
                                                      i++)
                                                    Checkbox(
                                                      checked:
                                                          selectedService[i],
                                                      onChanged: (v) =>
                                                          setState(() =>
                                                              selectedService[
                                                                      i] =
                                                                  v ?? false),
                                                      content: Text(
                                                        serviceList[i]
                                                            ['fileName']!,
                                                        style: TextStyle(
                                                          color: FluentTheme.of(
                                                                  context)
                                                              .inactiveColor,
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                              actions: [
                                                FilledButton(
                                                  child: const Text('Download'),
                                                  onPressed: () async {
                                                    Logger.i(
                                                        "Download Serivces");
                                                    final localDirectory =
                                                        Logger.localDirectory;
                                                    final directory = Directory(
                                                        '$localDirectory/service');
                                                    if (!await directory
                                                        .exists()) {
                                                      directory.create();
                                                    }
                                                    for (var i = 0;
                                                        i < serviceList.length;
                                                        i++) {
                                                      if (selectedService[i]) {
                                                        Logger.i(
                                                            "create file ${serviceList[i]['fileName']!}.java");
                                                        File('${directory.path}/${serviceList[i]['fileName']!}.java')
                                                            .writeAsString(
                                                                serviceList[i][
                                                                    'service']!);
                                                      }
                                                    }
                                                    await launch(
                                                        Uri.file(directory.path)
                                                            .toString());
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Button(
                                                  child: const Text('Back'),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ],
                                            );
                                          }),
                                        );
                                      },
                                    );
                                  },
                                ),
                                Button(
                                  child: const Text('Cancel'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                biggerSpacerH,
                Text('Database',
                    style: FluentTheme.of(context).typography.subtitle),
                spacerH,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SubVersion',
                              style:
                                  FluentTheme.of(context).typography.bodyLarge),
                          spacerH,
                          databaseCard(database.svnColumnList),
                        ],
                      ),
                    ),
                    spacerW,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Local',
                              style:
                                  FluentTheme.of(context).typography.bodyLarge),
                          spacerH,
                          databaseCard(database.localColumnList),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget databaseCard(List<db.Column> columnList) {
    if (columnList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: ReorderableListView(
        shrinkWrap: true,
        onReorder: (a, b) => debugPrint('reorder $a to $b'),
        children: [
          for (var column in columnList)
            ListTile(
              key: ValueKey(column.dbName),
              title: Text(column.javaName ?? "ERROR"),
              leading: Row(
                children: [
                  SizedBox(
                    width: 20,
                    child: column.isPK
                        ? Center(
                            child: Text(
                              "PK",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                  ),
                  SizedBox(
                    width: 20,
                    child: column.isFK
                        ? Center(
                            child: Text(
                              "FK",
                              style: TextStyle(
                                color: Colors.magenta['lightest'],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
