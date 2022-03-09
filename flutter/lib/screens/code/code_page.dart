import 'package:fluent/utils/convertor.dart' as convertor;
import 'package:fluent/utils/utils.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import 'package:fluent/provider/database.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
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
                    database.tableList = await convertor.Convertor()
                        .loadDatabase(convertor.Schema.center);
                    Navigator.pop(context);
                    snackbar(context, 'Load database success.');
                  },
                ),
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
                    database.tableList = await convertor.Convertor()
                        .loadDatabase(convertor.Schema.csttec);
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
                    items: database.tableDomainList,
                    clearButtonEnabled: false,
                    controller: tableController,
                    placeholder: 'Pick a Table',
                    trailingIcon: IconButton(
                      icon: const Icon(FluentIcons.cancel),
                      onPressed: () {
                        tableController.clear();
                      },
                    ),
                    onSelected: (text) {
                      database.setColumnList(text);
                    },
                  ),
                ),
              ],
            ),
            biggerSpacerH,
            Card(
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
            ),
          ],
        );
      },
    );
  }
}
