import 'package:assistant/components/my_elevated_button.dart';
import 'package:assistant/provider/config.dart';
import 'package:assistant/screen/sign/signin_page.dart';
import 'package:assistant/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _localPersistencePathController =
      TextEditingController();

  Widget content() {
    return ChangeNotifierProvider(
      create: (_) => Config(),
      builder: (context, _) {
        final config = context.watch<Config>();
        _localPersistencePathController.text = config.localPersistencePath;
        _authorController.text = config.author;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "설정",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            biggerSpacerH,
            const Text("Author"),
            spacerH,
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _authorController,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.people_alt),
                        hintText: "seongha.moon",
                      ),
                    ),
                  ),
                ),
                spacerW,
                MyElevatedButton(
                  height: 40,
                  width: 80,
                  text: "저장",
                  hasBorder: true,
                  onPressed: () async {
                    showSnackbar(context, "성공", "저장 완료.");
                    config.author = _authorController.text;
                  },
                ),
              ],
            ),
            biggerSpacerH,
            const Text("작업폴더 경로"),
            spacerH,
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      enableInteractiveSelection:
                          false, // will disable paste operation
                      focusNode: AlwaysDisabledFocusNode(),
                      showCursor: false,
                      controller: _localPersistencePathController,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.folder),
                        hintText:
                            "C:\\work_space\\server_DevTrunk\\src\\main\\resources\\com\\csttec\\server\\persistence",
                      ),
                    ),
                  ),
                ),
                spacerW,
                MyElevatedButton(
                  height: 40,
                  width: 80,
                  text: "변경",
                  hasBorder: true,
                  onPressed: () async {
                    String? directoryPath =
                        await FilePicker.platform.getDirectoryPath();
                    if (directoryPath == null) {
                      showSnackbar(context, "실패", "선택 취소.");
                    } else {
                      _localPersistencePathController.text = directoryPath;
                      config.localPersistencePath =
                          _localPersistencePathController.text;
                      showSnackbar(context, "완료", "Path 저장 완료.");
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
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
      padding: const EdgeInsets.all(20),
      child: content(),
    );
  }
}
