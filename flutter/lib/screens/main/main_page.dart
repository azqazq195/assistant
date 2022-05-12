import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent/utils/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';

import 'package:fluent/screens/colors.dart';
import 'package:fluent/screens/forms.dart';
import 'package:fluent/screens/icons.dart';
import 'package:fluent/screens/inputs.dart';
import 'package:fluent/screens/mobile.dart';
import 'package:fluent/screens/others.dart';
import 'package:fluent/screens/settings/settings_page.dart';
import 'package:fluent/screens/typography.dart';
import 'package:fluent/provider/theme.dart';
import 'package:fluent/screens/code/code_page.dart';
import 'package:fluent/screens/commandbars.dart';
import 'package:fluent/screens/database/database_page.dart';
import 'package:fluent/screens/flyouts.dart';
import 'package:fluent/screens/update/update_page.dart';
import 'package:fluent/utils/updater.dart';
import 'package:fluent/utils/utils.dart';
import 'package:fluent/utils/variable.dart';

class MainPageTest extends StatefulWidget {
  const MainPageTest({Key? key}) : super(key: key);

  @override
  _MainPageTestState createState() => _MainPageTestState();
}

class _MainPageTestState extends State<MainPageTest> {
  int index = 0;

  final settingsController = ScrollController();

  @override
  void dispose() {
    settingsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Updater().checkVersion(context);
    super.initState();
  }

  void logout() {
    showConfirmAlert(context, "로그아웃", const Text("로그아웃하시겠습니까?"), () {
      SharedPreferences.prefs.setBool(Preferences.autoLogin.name, false);
      Navigator.pushNamed(context, '/signin');
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return NavigationView(
      pane: NavigationPane(
        selected: index,
        onChanged: (i) => setState(() => index = i),
        size: const NavigationPaneSize(
          openMinWidth: 200,
          openMaxWidth: 260,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100,
          ),
        ),
        displayMode: appTheme.displayMode,
        indicator: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return const EndNavigationIndicator();
            case NavigationIndicators.sticky:
            default:
              return const StickyNavigationIndicator();
          }
        }(),
        items: [
          PaneItemHeader(header: const Text(appTitle)),
          PaneItem(
            icon: const Icon(FluentIcons.code),
            title: const Text('Code'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.database),
            title: const Text('DataBase'),
          ),
          PaneItemSeparator(),
          PaneItemHeader(header: const Text("Development")),
          PaneItem(
            icon: const Icon(FluentIcons.checkbox_composite),
            title: const Text('Inputs'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.text_field),
            title: const Text('Forms'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.color),
            title: const Text('Colors'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.icon_sets_flag),
            title: const Text('Icons'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.plain_text),
            title: const Text('Typography'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.cell_phone),
            title: const Text('Mobile'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.toolbox),
            title: const Text('Command bars'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.pop_expand),
            title: const Text('Popups, Flyouts and Context Menus'),
          ),
          PaneItem(
            icon: Icon(
              appTheme.displayMode == PaneDisplayMode.top
                  ? FluentIcons.more
                  : FluentIcons.more_vertical,
            ),
            title: const Text('Others'),
            infoBadge: const InfoBadge(
              source: Text('9'),
            ),
          ),
        ],
        autoSuggestBox: AutoSuggestBox(
          controller: TextEditingController(),
          items: const [
            'Code',
            'DataBase',
            'Inputs',
            'Forms',
            'Colors',
            'Icons',
            'Typhography',
            'Mobile',
            'CommandBars',
            'FlyoutShowcase',
            'Other',
            'Update notes',
            'Settings',
            'Bug report',
            'Source code',
            'Log Out'
          ],
          onSelected: (str) {
            setState(() {
              if (str == 'Code') {
                index = 0;
                return;
              }
              if (str == 'DataBase') {
                index = 1;
                return;
              }
              if (str == 'Inputs') {
                index = 2;
                return;
              }
              if (str == 'Forms') {
                index = 3;
                return;
              }
              if (str == 'Colors') {
                index = 4;
                return;
              }
              if (str == 'Icons') {
                index = 5;
                return;
              }
              if (str == 'Typhography') {
                index = 6;
                return;
              }
              if (str == 'Mobile') {
                index = 7;
                return;
              }
              if (str == 'CommandBars') {
                index = 8;
                return;
              }
              if (str == 'FlyoutShowcase') {
                index = 9;
                return;
              }
              if (str == 'Other') {
                index = 10;
                return;
              }
              if (str == 'Update notes') {
                index = 11;
                return;
              }
              if (str == 'Settings') {
                index = 12;
                return;
              }
              if (str == 'Bug report') {
                bugReport();
                return;
              }
              if (str == 'Source code') {
                return;
              }
              if (str == 'Log Out') {
                logout();
                return;
              }
            });
          },
        ),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.check_list),
            title: const Text('Update notes'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.report_hacked),
            title: const Text('Bug report'),
            onTap: () {
              bugReport();
            },
          ),
          _LinkPaneItemAction(
            icon: const Icon(FluentIcons.open_source),
            title: const Text('Source code'),
            link: 'https://github.com/azqazq195/assistant',
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.sign_out),
            title: const Text('Log Out'),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
      content: NavigationBody(index: index, children: [
        const CodePage(),
        const DatabasePage(),
        const InputsPage(),
        const Forms(),
        const ColorsPage(),
        const IconsPage(),
        const TypographyPage(),
        const Mobile(),
        const CommandBars(),
        const FlyoutShowcase(),
        const Others(),
        const UpdatePage(),
        Settings(controller: settingsController),
      ]),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    assert(debugCheckHasFluentLocalizations(context));
    final ThemeData theme = FluentTheme.of(context);
    final buttonColors = WindowButtonColors(
      iconNormal: theme.inactiveColor,
      iconMouseDown: theme.inactiveColor,
      iconMouseOver: theme.inactiveColor,
      mouseOver: ButtonThemeData.buttonColor(
          theme.brightness, {ButtonStates.hovering}),
      mouseDown: ButtonThemeData.buttonColor(
          theme.brightness, {ButtonStates.pressing}),
    );
    final closeButtonColors = WindowButtonColors(
      mouseOver: Colors.red,
      mouseDown: Colors.red.dark,
      iconNormal: theme.inactiveColor,
      iconMouseOver: Colors.red.basedOnLuminance(),
      iconMouseDown: Colors.red.dark.basedOnLuminance(),
    );
    return Row(children: [
      Tooltip(
        message: FluentLocalizations.of(context).minimizeWindowTooltip,
        child: MinimizeWindowButton(colors: buttonColors),
      ),
      Tooltip(
        message: FluentLocalizations.of(context).restoreWindowTooltip,
        child: WindowButton(
          colors: buttonColors,
          iconBuilder: (context) {
            if (appWindow.isMaximized) {
              return RestoreIcon(color: context.iconColor);
            }
            return MaximizeIcon(color: context.iconColor);
          },
          onPressed: appWindow.maximizeOrRestore,
        ),
      ),
      Tooltip(
        message: FluentLocalizations.of(context).closeWindowTooltip,
        child: CloseWindowButton(colors: closeButtonColors),
      ),
    ]);
  }
}

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required Widget icon,
    required this.link,
    title,
    infoBadge,
    focusNode,
    autofocus = false,
  }) : super(
          icon: icon,
          title: title,
          infoBadge: infoBadge,
          focusNode: focusNode,
          autofocus: autofocus,
        );

  final String link;

  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
  }) {
    return Link(
      uri: Uri.parse(link),
      builder: (context, followLink) => super.build(
        context,
        selected,
        followLink,
        displayMode: displayMode,
        showTextOnTop: showTextOnTop,
        autofocus: autofocus,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  final settingsController = ScrollController();

  @override
  void initState() {
    Updater().checkVersion(context);
    super.initState();
  }

  @override
  void dispose() {
    settingsController.dispose();
    super.dispose();
  }

  void logout() {
    showConfirmAlert(context, "로그아웃", const Text("로그아웃하시겠습니까?"), () {
      SharedPreferences.prefs.setBool(Preferences.autoLogin.name, false);
      Navigator.pushNamed(context, '/signin');
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return NavigationView(
      appBar: NavigationAppBar(
        title: () {
          if (kIsWeb) return const Text(appTitle);
          return const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(appTitle),
            ),
          );
        }(),
        actions: kIsWeb
            ? null
            : DragToMoveArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [Spacer(), WindowButtons()],
                ),
              ),
      ),
      pane: NavigationPane(
        selected: index,
        onChanged: (i) => setState(() => index = i),
        size: const NavigationPaneSize(
          openMinWidth: 200,
          openMaxWidth: 260,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100,
          ),
        ),
        displayMode: appTheme.displayMode,
        indicator: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return const EndNavigationIndicator();
            case NavigationIndicators.sticky:
            default:
              return const StickyNavigationIndicator();
          }
        }(),
        items: [
          PaneItemHeader(header: const Text(appTitle)),
          PaneItem(
            icon: const Icon(FluentIcons.code),
            title: const Text('Code'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.database),
            title: const Text('DataBase'),
          ),
        ],
        autoSuggestBox: AutoSuggestBox(
          controller: TextEditingController(),
          items: const [
            'Code',
            'DataBase',
            'Update notes',
            'Settings',
            'Bug report',
            'Source code',
            'Log Out'
          ],
          onSelected: (str) {
            setState(() {
              if (str == 'Code') {
                index = 0;
                return;
              }
              if (str == 'DataBase') {
                index = 1;
                return;
              }
              if (str == 'Update notes') {
                index = 2;
                return;
              }
              if (str == 'Settings') {
                index = 3;
                return;
              }
              if (str == 'Bug report') {
                bugReport();
                return;
              }
              if (str == 'Source code') {
                return;
              }
              if (str == 'Log Out') {
                logout();
                return;
              }
            });
          },
        ),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.check_list),
            title: const Text('Update notes'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.report_hacked),
            title: const Text('Bug report'),
            onTap: () {
              bugReport();
            },
          ),
          _LinkPaneItemAction(
            icon: const Icon(FluentIcons.open_source),
            title: const Text('Source code'),
            link: 'https://github.com/azqazq195/assistant',
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.sign_out),
            title: const Text('Log Out'),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
      content: NavigationBody(index: index, children: [
        const CodePage(),
        const DatabasePage(),
        const UpdatePage(),
        Settings(controller: settingsController),
      ]),
    );
  }
}
