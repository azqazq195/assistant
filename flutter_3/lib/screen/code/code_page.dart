import 'package:assistant/components/my_field_card.dart';
import 'package:assistant/provider/config.dart';
import 'package:assistant/utils/utils.dart';
import 'package:assistant/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  Widget content() {
    return ChangeNotifierProvider(
      create: (_) => Config(),
      builder: (context, _) {
        final config = context.watch<Config>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            biggerSpacerH,
            searchBox(),
            biggerSpacerH,
            cardList(),
          ],
        );
      },
    );
  }

  Widget header() {
    return const Text(
      "코드",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget searchBox() {
    const List<User> userOptions = <User>[
      User(name: 'Alice', email: 'alice@example.com'),
      User(name: 'Bob', email: 'bob@example.com'),
      User(name: 'Charlie', email: 'charlie123@gmail.com'),
    ];

    String _displayStringForOption(User option) => option.name;

    return Row(
      children: [
        Expanded(
          child: Autocomplete<User>(
            displayStringForOption: _displayStringForOption,
            optionsBuilder: (TextEditingValue textEditingValue) {
              return userOptions.where((User option) {
                return option
                    .toString()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (User selection) {
              showSnackbar(context, "선택", selection.name);
            },
          ),
        ),
        SizedBox(
          width: 100,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove_circle_outline_sharp),
          ),
        ),
      ],
    );
  }

  Widget cardList() {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 960) {
        return Column(
          children: [
            Row(
              children: [
                MyFieldCard(
                  title: "Domain",
                  content: "Domain 코드를 클립보드에 복사합니다.",
                  onPressed: () {},
                ),
                middleSpacerW,
                MyFieldCard(
                  title: "Mapper.java",
                  content: "Mapper Interface 코드를 클립보드에 복사합니다.",
                  onPressed: () {},
                ),
              ],
            ),
            middleSpacerH,
            Row(
              children: [
                MyFieldCard(
                  title: "Mapper.xml",
                  content: "Mybatis 코드를 클립보드에 복사합니다.",
                  onPressed: () {},
                ),
                middleSpacerW,
                MyFieldCard(
                  title: "Service",
                  content: "Service 코드 양식을 다운로드 받습니다.",
                  onPressed: () {},
                ),
              ],
            )
          ],
        );
      } else {
        return Row(
          children: [
            MyFieldCard(
              title: "Domain",
              content: "Domain 코드를 클립보드에 복사합니다.",
              onPressed: () {},
            ),
            middleSpacerW,
            MyFieldCard(
              title: "Mapper.java",
              content: "Mapper Interface 코드를 클립보드에 복사합니다.",
              onPressed: () {},
            ),
            middleSpacerW,
            MyFieldCard(
              title: "Mapper.xml",
              content: "Mybatis 코드를 클립보드에 복사합니다.",
              onPressed: () {},
            ),
            middleSpacerW,
            MyFieldCard(
              title: "Service",
              content: "Service 코드 양식을 다운로드 받습니다.",
              onPressed: () {},
            ),
          ],
        );
      }
    });
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

@immutable
class User {
  const User({
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  @override
  String toString() {
    return '$name, $email';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is User && other.name == name && other.email == email;
  }

  @override
  int get hashCode => Object.hash(email, name);
}
