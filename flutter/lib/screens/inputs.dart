// ignore_for_file: avoid_print

import 'package:fluent_ui/fluent_ui.dart';

const Widget spacer = SizedBox(height: 5.0);

class InputsPage extends StatefulWidget {
  const InputsPage({Key? key}) : super(key: key);

  @override
  _InputsPageState createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  bool disabled = false;

  bool value = false;

  double sliderValue = 5;

  double get max => 9;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('Inputs showcase'),
        commandBar: ToggleSwitch(
          checked: disabled,
          onChanged: (v) => setState(() => disabled = v),
          content: const Text('Disabled'),
        ),
      ),
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                child: InfoLabel(
                  label: 'Interactive Inputs',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        checked: value,
                        onChanged: disabled
                            ? null
                            : (v) => setState(() => value = v ?? false),
                        content: Text(
                          'Checkbox ${value ? 'on ' : 'off'}',
                          style: TextStyle(
                            color: FluentTheme.of(context).inactiveColor,
                          ),
                        ),
                      ),
                      ToggleSwitch(
                        checked: value,
                        onChanged:
                        disabled ? null : (v) => setState(() => value = v),
                        content: Text(
                          'Switcher ${value ? 'on ' : 'off'}',
                          style: TextStyle(
                            color: FluentTheme.of(context).inactiveColor,
                          ),
                        ),
                      ),
                      RadioButton(
                        checked: value,
                        onChanged:
                        disabled ? null : (v) => setState(() => value = v),
                        content: Text(
                          'Radio Button ${value ? 'on ' : 'off'}',
                          style: TextStyle(
                            color: FluentTheme.of(context).inactiveColor,
                          ),
                        ),
                      ),
                      spacer,
                      ToggleButton(
                        child: const Text('Toggle Button'),
                        checked: value,
                        onChanged: disabled
                            ? null
                            : (value) => setState(() => this.value = value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildButtons(),
            _buildSliders(),
          ],
        ),
      ],
    );
  }

  Widget _buildButtons() {
    const double splitButtonHeight = 25.0;
    return Card(
      child: InfoLabel(
        label: 'Buttons',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Button(
            child: const Text('Show Dialog'),
            onPressed: disabled
                ? null
                : () {
              showDialog(
                context: context,
                builder: (_) => ContentDialog(
                  title: const Text('Delete file permanently?'),
                  content: const Text(
                    'If you delete this file, you won\'t be able to recover it. Do you want to delete it?',
                  ),
                  actions: [
                    Button(
                      child: const Text('Delete'),
                      onPressed: () {
                        // Delete file here
                      },
                    ),
                    FilledButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
          ),
          spacer,
          IconButton(
            icon: const Icon(FluentIcons.add),
            onPressed: disabled ? null : () => print('pressed icon button'),
          ),
          spacer,
          SizedBox(
            height: splitButtonHeight,
            child: SplitButtonBar(buttons: [
              Button(
                child: SizedBox(
                  height: splitButtonHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: disabled
                          ? FluentTheme.of(context).accentColor.darker
                          : FluentTheme.of(context).accentColor,
                      borderRadius: const BorderRadiusDirectional.horizontal(
                        start: Radius.circular(4.0),
                      ),
                    ),
                    height: 24,
                    width: 24,
                  ),
                ),
                onPressed: disabled ? null : () {},
              ),
              IconButton(
                icon: const SizedBox(
                  height: splitButtonHeight,
                  child: Icon(FluentIcons.chevron_down, size: 10.0),
                ),
                onPressed: disabled ? null : () {},
              ),
            ]),
          ),
          spacer,
          DropDownButton(
            disabled: disabled,
            leading: const Icon(FluentIcons.mail),
            items: [
              DropDownButtonItem(
                title: const Text('Send'),
                leading: const Icon(FluentIcons.send),
                onTap: () => debugPrint('Send'),
              ),
              DropDownButtonItem(
                title: const Text('Reply'),
                leading: const Icon(FluentIcons.mail_reply),
                onTap: () => debugPrint('Reply'),
              ),
              DropDownButtonItem(
                title: const Text('Reply all'),
                leading: const Icon(FluentIcons.mail_reply_all),
                onTap: () => debugPrint('Reply all'),
              ),
            ],
          ),
          spacer,
        ]),
      ),
    );
  }

  Widget _buildSliders() {
    return Card(
      child: InfoLabel(
        label: 'Sliders',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Flexible(
              fit: FlexFit.loose,
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 200,
                  child: Slider(
                    max: max,
                    label: '${sliderValue.toInt()}',
                    value: sliderValue,
                    onChanged: disabled
                        ? null
                        : (v) => setState(() => sliderValue = v),
                    divisions: 10,
                  ),
                ),
                RatingBar(
                  amount: max.toInt(),
                  rating: sliderValue,
                  onChanged:
                  disabled ? null : (v) => setState(() => sliderValue = v),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Slider(
                vertical: true,
                max: max,
                label: '${sliderValue.toInt()}',
                value: sliderValue,
                onChanged:
                disabled ? null : (v) => setState(() => sliderValue = v),
                // style: SliderThemeData(useThumbBall: false),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}