import 'package:fluent/utils/convertor.dart';
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
  final convertor = Convertor();

  @override
  Widget build(BuildContext context) {
    final tableController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => Database(),
      builder: (context, _) {
        final database = context.watch<Database>();

        return ScaffoldPage(
          header: PageHeader(
            title: const Text('Code'),
            commandBar: Button(
              child: const Text('Load Database'),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (_) => const ContentDialog(
                    title: Text('Load Database..'),
                    content: Center(child: ProgressRing()),
                  ),
                );
                database.tableList =
                    await convertor.loadDatabase(Schema.center);
                Navigator.pop(context);
                snackbar(context, 'Load database success.');
              },
            ),
          ),
          content: Padding(
            padding: EdgeInsets.only(
              bottom: kPageDefaultVerticalPadding,
              left: PageHeader.horizontalPadding(context),
              right: PageHeader.horizontalPadding(context),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AutoSuggestBox(
                    items: database.tableList,
                    clearButtonEnabled: false,
                    controller: tableController,
                    placeholder: 'Pick a Table',
                    trailingIcon: IconButton(
                      icon: const Icon(FluentIcons.cancel),
                      onPressed: () {
                        print(tableController.text);
                        tableController.clear();
                      },
                    ),
                    onSelected: (text) {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
