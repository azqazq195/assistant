import 'package:assistant/helpers/logger.dart';
import 'package:assistant/helpers/shared_preferences.dart';
import 'package:assistant/layout.dart';
import 'package:assistant/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:assistant/constants/color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: const [
          Expanded(child: LeftPage()),
          Expanded(child: RightPage()),
        ],
      ),
    );
  }
}

class LeftPage extends StatefulWidget {
  const LeftPage({Key? key}) : super(key: key);

  @override
  State<LeftPage> createState() => _LeftPageState();
}

class _LeftPageState extends State<LeftPage> {
  late bool _isAutoLogin = false;

  @override
  void initState() {
    super.initState();
    _isAutoLogin =
        SharedPreferences.prefs.getBool(Preferences.autoLogin.name) ?? false;
    Logger.d('current autoLogin value: $_isAutoLogin');
    // if (_isAutoLogin) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const SiteLayout()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 200),
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 34,
            child: CustomText(
              text: 'ASSISTANT',
              size: 32,
              color: fontBlack,
              weight: FontWeight.w900,
              fontFamily: 'AppleSDGothicNeo',
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          // const CustomText(
          //   text: '로그인 정보를 입력해 주세요.',
          //   size: 12,
          //   color: fontGrey,
          //   weight: FontWeight.bold,
          // ),
          const SizedBox(
            height: 12,
          ),
          const SizedBox(
            height: 38,
            width: 348,
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderFocused, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderGrey, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                isDense: true,
                hintText: '이메일 주소',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: fontGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const SizedBox(
            height: 38,
            width: 348,
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderFocused, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderGrey, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                isDense: true,
                hintText: '비밀번호',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: fontGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: 348,
            child: Row(
              children: [
                Checkbox(
                  side: const BorderSide(color: borderGrey, width: 1),
                  activeColor: checked,
                  value: _isAutoLogin,
                  onChanged: (value) {
                    setState(() {
                      _isAutoLogin = value!;
                      Logger.d('change autoLogin: $_isAutoLogin');
                    });
                  },
                ),
                const CustomText(
                  text: '자동 로그인',
                  size: 12,
                  color: fontGrey,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 348,
            height: 48,
            child: Divider(
              thickness: 0.5,
              color: borderGrey,
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                const Size(348, 38),
              ),
              side: MaterialStateProperty.all(
                const BorderSide(color: borderGrey, width: 0.5),
              ),
              overlayColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return btnPressed;
                  }
                  if (states.contains(MaterialState.hovered)) {
                    return btnHovered;
                  }
                  return null;
                },
              ),
            ),
            onPressed: () {
              SharedPreferences.prefs
                  .setBool(Preferences.autoLogin.name, _isAutoLogin);
              Logger.i('save autoLogin: $_isAutoLogin');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SiteLayout()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage("assets/logo/google_logo_small.png"),
                  width: 18,
                  height: 18,
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(
                  width: 6,
                ),
                CustomText(
                  text: 'Google 계정 로그인',
                  size: 12,
                  color: fontDefault,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RightPage extends StatelessWidget {
  const RightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: const Center(
        child: Text(
          "CORNERSTONE",
          style: TextStyle(
            fontSize: 72,
            color: logo,
            fontWeight: FontWeight.w900,
            fontFamily: 'AppleSDGothicNeo',
            shadows: <Shadow>[
              Shadow(
                color: logoShadow,
                offset: Offset(20.0, 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
