import 'package:fluent/utils/convertor.dart' as db;
import 'package:fluent/utils/utils.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:fluent/provider/database.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  db.Convertor? convertor;

  @override
  Widget build(BuildContext context) {
    final tableController = TextEditingController();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoacalDatabase()),
        ChangeNotifierProvider(create: (_) => SvnDatabase()),
      ],
      builder: (context, _) {
        final localDatabase = context.watch<LoacalDatabase>();
        final svnDatabase = context.watch<SvnDatabase>();

        Future<void> _loadDatabase(db.Schema schema) async {
          localDatabase.tableList =
              await db.Database().loadDatabase(db.Location.local, schema);
          svnDatabase.tableList =
              await db.Database().loadDatabase(db.Location.svn, schema);
        }

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
                    _loadDatabase(db.Schema.center);
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
                    _loadDatabase(db.Schema.csttec);
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
                    items: svnDatabase.tableDomainList,
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
                      svnDatabase.setColumnList(tableDomain);
                      localDatabase.setColumnList(tableDomain);
                      setState(() {
                        if (localDatabase.getTable(tableDomain) != null) {
                          convertor = db.Convertor(
                              localDatabase.getTable(tableDomain)!);
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
                          snackbar(context, 'Table is null.');
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
                          snackbar(context, 'Table is null.');
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
                          snackbar(context, 'Table is null.');
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
                      text: const Text('MyBatis'),
                      onPressed: () {
                        if (convertor == null) {
                          snackbar(context, 'Table is null.');
                        } else {}
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
                          databaseCard(svnDatabase),
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
                          databaseCard(localDatabase),
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

  Widget databaseCard(Database database) {
    if (database.columnList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: ReorderableListView(
        shrinkWrap: true,
        onReorder: (a, b) => debugPrint('reorder $a to $b'),
        children: [
          for (var column in database.columnList)
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
