import 'package:fluent/utils/utils.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import 'package:fluent/provider/config.dart';
import 'package:fluent/provider/theme.dart';
import 'package:url_launcher/url_launcher.dart';

const List<String> accentColorNames = [
  'System',
  'Yellow',
  'Orange',
  'Red',
  'Magenta',
  'Purple',
  'Blue',
  'Teal',
  'Green',
];

const _svnDownloadurl = "https://tortoisesvn.net/downloads.html";

class Settings extends StatefulWidget {
  const Settings({Key? key, this.controller}) : super(key: key);

  final ScrollController? controller;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _showSvnPassword = false;
  bool _showMySqlPassword = false;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    final tooltipThemeData = TooltipThemeData(decoration: () {
      const radius = BorderRadius.zero;
      final shadow = [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(1, 1),
          blurRadius: 10.0,
        ),
      ];
      final border = Border.all(color: Colors.grey[100], width: 0.5);
      if (FluentTheme.of(context).brightness == Brightness.light) {
        return BoxDecoration(
          color: Colors.white,
          borderRadius: radius,
          border: border,
          boxShadow: shadow,
        );
      } else {
        return BoxDecoration(
          color: Colors.grey,
          borderRadius: radius,
          border: border,
          boxShadow: shadow,
        );
      }
    }());

    final svnUsernameController = TextEditingController();
    final svnPasswordController = TextEditingController();
    final svnPathController = TextEditingController();
    final svnUrlController = TextEditingController();

    final mysqlUsernameController = TextEditingController();
    final mysqlPasswordController = TextEditingController();
    final mysqlPathController = TextEditingController();
    final persistencePathController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => Config(),
      builder: (context, _) {
        final config = context.watch<Config>();

        svnUsernameController.text = config.svnUsername;
        svnPasswordController.text = config.svnPassword;
        svnPathController.text = config.svnPath;
        svnUrlController.text = config.svnUrl;

        mysqlUsernameController.text = config.mySqlUsername;
        mysqlPasswordController.text = config.mysqlPassword;
        mysqlPathController.text = config.mysqlPath;
        persistencePathController.text = config.persistencePath;

        return ScaffoldPage.scrollable(
          header: const PageHeader(title: Text('Settings')),
          scrollController: widget.controller,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('SubVersion',
                    style: FluentTheme.of(context).typography.subtitle),
                Button(
                  child: const Text('Download'),
                  onPressed: () async {
                    if (!await launch(_svnDownloadurl)) {
                      throw 'Could not launch $_svnDownloadurl';
                    }
                  },
                ),
              ],
            ),
            spacerH,
            Row(
              children: [
                Expanded(
                  child: TextBox(
                    header: 'User Name',
                    placeholder: "Type your user name like 'seongha.moon'",
                    controller: svnUsernameController,
                    textInputAction: TextInputAction.next,
                    prefix: const Padding(
                      padding: EdgeInsetsDirectional.only(start: 8.0),
                      child: Icon(FluentIcons.people),
                    ),
                    outsideSuffix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SizedBox(
                        width: 80,
                        child: Button(
                          child: const Text('Save'),
                          onPressed: () {
                            config.svnUsername = svnUsernameController.text;
                            snackbar(context, "User Name 저장 완료!");
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: TextBox(
                    header: 'Password',
                    placeholder: 'Type your Password',
                    controller: svnPasswordController,
                    obscureText: !_showSvnPassword,
                    maxLines: 1,
                    suffixMode: OverlayVisibilityMode.always,
                    suffix: IconButton(
                      icon: Icon(
                        !_showSvnPassword
                            ? FluentIcons.lock
                            : FluentIcons.unlock,
                      ),
                      onPressed: () =>
                          setState(() => _showSvnPassword = !_showSvnPassword),
                    ),
                    outsideSuffix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SizedBox(
                        width: 80,
                        child: Button(
                          child: const Text('Save'),
                          onPressed: () {
                            config.svnPassword = svnPasswordController.text;
                            snackbar(context, "Password 저장 완료!");
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            spacerH,
            TextBox(
              header: 'Subversion path',
              placeholder: "C:\\Program Files (x86)\\Subversion\\bin",
              controller: svnPathController,
              readOnly: true,
              textInputAction: TextInputAction.next,
              prefix: const Padding(
                padding: EdgeInsetsDirectional.only(start: 8.0),
                child: Icon(FluentIcons.fabric_folder),
              ),
              outsideSuffix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: 80,
                  child: Button(
                    child: const Text('Change'),
                    onPressed: () async {
                      String? directoryPath =
                          await FilePicker.platform.getDirectoryPath();
                      if (directoryPath == null) {
                        snackbar(context, "선택 취소.");
                      } else {
                        svnPathController.text = directoryPath;
                        config.svnPath = svnPathController.text;
                        snackbar(context, "Path 저장 완료!");
                      }
                    },
                  ),
                ),
              ),
            ),
            spacerH,
            TextBox(
              header: 'Subversion Url',
              placeholder:
                  "https://intranet-fs.csttec.com:5443/svn/cstone/server/trunk/server_DevTrunk",
              controller: svnUrlController,
              textInputAction: TextInputAction.next,
              prefix: const Padding(
                padding: EdgeInsetsDirectional.only(start: 8.0),
                child: Icon(FluentIcons.link),
              ),
              outsideSuffix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: 80,
                  child: Button(
                    child: const Text('Save'),
                    onPressed: () {
                      config.svnUrl = svnUrlController.text;
                      snackbar(context, "Url 저장 완료!");
                    },
                  ),
                ),
              ),
            ),
            biggerSpacerH,
            Text('Mysql', style: FluentTheme.of(context).typography.subtitle),
            spacerH,
            Row(
              children: [
                Expanded(
                  child: TextBox(
                    header: 'User Name',
                    placeholder: "Type your user name like 'root'",
                    controller: mysqlUsernameController,
                    textInputAction: TextInputAction.next,
                    prefix: const Padding(
                      padding: EdgeInsetsDirectional.only(start: 8.0),
                      child: Icon(FluentIcons.people),
                    ),
                    outsideSuffix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SizedBox(
                        width: 80,
                        child: Button(
                          child: const Text('Save'),
                          onPressed: () {
                            config.mysqlUsername = mysqlUsernameController.text;
                            snackbar(context, "User Name 저장 완료!");
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: TextBox(
                    header: 'Password',
                    placeholder: 'Type your Password',
                    controller: mysqlPasswordController,
                    obscureText: !_showMySqlPassword,
                    maxLines: 1,
                    suffixMode: OverlayVisibilityMode.always,
                    suffix: IconButton(
                      icon: Icon(
                        !_showMySqlPassword
                            ? FluentIcons.lock
                            : FluentIcons.unlock,
                      ),
                      onPressed: () => setState(
                          () => _showMySqlPassword = !_showMySqlPassword),
                    ),
                    outsideSuffix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SizedBox(
                        width: 80,
                        child: Button(
                          child: const Text('Save'),
                          onPressed: () {
                            config.mysqlPassword = mysqlPasswordController.text;
                            snackbar(context, "Password 저장 완료!");
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            spacerH,
            TextBox(
              header: 'MySql path',
              placeholder: "C:\\Program Files\\MariaDB 10.5\\bin",
              controller: mysqlPathController,
              readOnly: true,
              textInputAction: TextInputAction.next,
              prefix: const Padding(
                padding: EdgeInsetsDirectional.only(start: 8.0),
                child: Icon(FluentIcons.fabric_folder),
              ),
              outsideSuffix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: 80,
                  child: Button(
                    child: const Text('Change'),
                    onPressed: () async {
                      String? directoryPath =
                          await FilePicker.platform.getDirectoryPath();
                      if (directoryPath == null) {
                        snackbar(context, "선택 취소.");
                      } else {
                        mysqlPathController.text = directoryPath;
                        config.mysqlPath = mysqlPathController.text;
                        snackbar(context, "Path 저장 완료!");
                      }
                    },
                  ),
                ),
              ),
            ),
            spacerH,
            TextBox(
              header: 'Persistence path',
              placeholder:
                  "C:\\Users\\azqaz\\Documents\\Assistant\\server_DevTrunk\\src\\main\\resources\\com\\csttec\\server\\persistence",
              controller: persistencePathController,
              readOnly: true,
              textInputAction: TextInputAction.next,
              prefix: const Padding(
                padding: EdgeInsetsDirectional.only(start: 8.0),
                child: Icon(FluentIcons.fabric_folder),
              ),
              outsideSuffix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: 80,
                  child: Button(
                    child: const Text('Change'),
                    onPressed: () async {
                      String? directoryPath =
                          await FilePicker.platform.getDirectoryPath();
                      if (directoryPath == null) {
                        snackbar(context, "선택 취소.");
                      } else {
                        persistencePathController.text = directoryPath;
                        config.persistencePath = persistencePathController.text;
                        snackbar(context, "Path 저장 완료!");
                      }
                    },
                  ),
                ),
              ),
            ),
            biggerSpacerH,
            Text('Theme mode',
                style: FluentTheme.of(context).typography.subtitle),
            spacerH,
            ...List.generate(ThemeMode.values.length, (index) {
              final mode = ThemeMode.values[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RadioButton(
                  checked: appTheme.mode == mode,
                  onChanged: (value) {
                    if (value) {
                      appTheme.mode = mode;
                    }
                  },
                  content: Text('$mode'.replaceAll('ThemeMode.', '')),
                ),
              );
            }),
            biggerSpacerH,
            Text(
              'Navigation Pane Display Mode',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            spacerH,
            ...List.generate(PaneDisplayMode.values.length, (index) {
              final mode = PaneDisplayMode.values[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RadioButton(
                  checked: appTheme.displayMode == mode,
                  onChanged: (value) {
                    if (value) appTheme.displayMode = mode;
                  },
                  content: Text(
                    mode.toString().replaceAll('PaneDisplayMode.', ''),
                  ),
                ),
              );
            }),
            biggerSpacerH,
            Text('Navigation Indicator',
                style: FluentTheme.of(context).typography.subtitle),
            spacerH,
            ...List.generate(NavigationIndicators.values.length, (index) {
              final mode = NavigationIndicators.values[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RadioButton(
                  checked: appTheme.indicator == mode,
                  onChanged: (value) {
                    if (value) appTheme.indicator = mode;
                  },
                  content: Text(
                    mode.toString().replaceAll('NavigationIndicators.', ''),
                  ),
                ),
              );
            }),
            biggerSpacerH,
            Text('Accent Color',
                style: FluentTheme.of(context).typography.subtitle),
            spacerH,
            Wrap(children: [
              Tooltip(
                style: tooltipThemeData,
                child: _buildColorBlock(appTheme, systemAccentColor, 0),
                message: accentColorNames[0],
              ),
              ...List.generate(Colors.accentColors.length, (index) {
                final color = Colors.accentColors[index];
                return Tooltip(
                  style: tooltipThemeData,
                  message: accentColorNames[index + 1],
                  child: _buildColorBlock(appTheme, color, index + 1),
                );
              }),
            ]),
          ],
        );
      },
    );
  }

  Widget _buildColorBlock(
      AppTheme appTheme, AccentColor color, int colorIndex) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Button(
        onPressed: () {
          appTheme.colorIndex = colorIndex;
        },
        style: ButtonStyle(padding: ButtonState.all(EdgeInsets.zero)),
        child: Container(
          height: 40,
          width: 40,
          color: color,
          alignment: Alignment.center,
          child: appTheme.color == color
              ? Icon(
                  FluentIcons.check_mark,
                  color: color.basedOnLuminance(),
                  size: 22.0,
                )
              : null,
        ),
      ),
    );
  }
}
