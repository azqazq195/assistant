import 'package:assistant/api/api.dart';
import 'package:assistant/api/client/rest_client.dart';
import 'package:assistant/api/dto/authentication_dto.dart';
import 'package:assistant/api/dto/git_dto.dart';
import 'package:assistant/components/my_alert_dialog.dart';
import 'package:assistant/components/my_text_button.dart';
import 'package:assistant/components/my_text_field.dart';
import 'package:assistant/utils/logger.dart';
import 'package:assistant/utils/shared_preferences.dart';
import 'package:assistant/utils/utils.dart';
import 'package:assistant/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
import 'package:yaml/yaml.dart';

const grey = Color.fromARGB(255, 130, 130, 130);

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  initState() {
    super.initState();

    Future(() async {
      await checkUpdate();
    });

    if (_isAutoLogin) {
      _signin(
        SignInRequestDto(
          email:
              SharedPreferences.prefs.getString(Preferences.email.name) ?? '',
          password:
              SharedPreferences.prefs.getString(Preferences.password.name) ??
                  '',
        ),
      );
    }
  }

  bool _isAutoLogin =
      SharedPreferences.prefs.getBool(Preferences.autoLogin.name) ?? false;
  final TextEditingController _emailController = TextEditingController(
      text: SharedPreferences.prefs.getString(Preferences.email.name) ?? "");
  final TextEditingController _passwordController = TextEditingController(
      text: SharedPreferences.prefs.getString(Preferences.password.name) ?? "");

  Future<void> checkUpdate() async {
    Future<ReleaseDto> getReleaseLatest() async {
      Response response =
          await request(context, Api.restClient.releaseLatest());
      return response.getRelease();
    }

    ReleaseDto releaseDto = await getReleaseLatest();

    String latestVersion = releaseDto.tagName.replaceAll("v", "");
    String currentVersion =
        await rootBundle.loadString('pubspec.yaml').then((value) {
      var yaml = loadYaml(value);
      return yaml['msix_config']['msix_version'];
    });
    Logger.i("currentVersion: $currentVersion, latestVersion: $latestVersion");
    if (latestVersion != currentVersion && releaseDto.downloadUrl != null) {
      MyAlertDialog(
        context: context,
        title: "업데이트 안내",
        content: MarkdownBody(
          data: releaseDto.body,
        ),
        actionText: "다운로드",
        actionFunction: () async {
          Uri uri = Uri.parse(releaseDto.downloadUrl!);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            throw "Could not launch '${uri.toString()}'";
          }
        },
      ).show();
    }
  }

  Future<void> _signin(SignInRequestDto signInRequestDto) async {
    Response response =
        await request(context, Api.restClient.signin(signInRequestDto));
    if (response.ok()) {
      SharedPreferences.prefs
          .setString(Preferences.email.name, signInRequestDto.email);
      SharedPreferences.prefs
          .setString(Preferences.password.name, signInRequestDto.password);

      SignInResponseDto signInResponseDto = response.getSignInResponseDto();
      SharedPreferences.prefs.setString(
          Preferences.accessToken.name, signInResponseDto.accessToken);
      SharedPreferences.prefs.setString(
          Preferences.refreshToken.name, signInResponseDto.refreshToken);

      Navigator.pushNamed(context, '/main');
    } else {
      SharedPreferences.prefs.setString(Preferences.email.name, "");
      SharedPreferences.prefs.setString(Preferences.password.name, "");
      SharedPreferences.prefs.setBool(Preferences.autoLogin.name, false);
      setState(() {
        _isAutoLogin =
            SharedPreferences.prefs.getBool(Preferences.autoLogin.name) ??
                false;
      });
    }
  }

  showSignUpDialog() {
    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController passwordCheck = TextEditingController();

    MyAlertDialog(
      context: context,
      title: "회원가입",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextField(
            height: 50,
            width: 400,
            hintText: "이름",
            controller: username,
          ),
          spacerH,
          MyTextField(
            height: 50,
            width: 400,
            hintText: "이메일",
            controller: email,
          ),
          spacerH,
          MyTextField(
            height: 50,
            width: 400,
            hintText: "비밀번호",
            obscureText: true,
            controller: password,
          ),
          spacerH,
          MyTextField(
            height: 50,
            width: 400,
            hintText: "비밀번호 확인",
            obscureText: true,
            controller: passwordCheck,
          ),
        ],
      ),
      actionText: "가입요청",
      actionFunction: () async {
        if (await _signup(
          SignUpRequestDto(
              username: username.text,
              email: email.text,
              password: encrypt(password.text),
              passwordCheck: encrypt(passwordCheck.text)),
        )) {
          Navigator.pop(context);
          showSnackbar(context, "완료", "회원가입 요청 완료.");
        }
      },
    ).show();
  }

  Future<bool> _signup(SignUpRequestDto signUpRequestDto) async {
    Response response =
        await request(context, Api.restClient.signup(signUpRequestDto));
    if (response.ok()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Assistant✨",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      "로그인 정보를 입력해 주세요.",
                      style: TextStyle(
                        color: grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    MyTextField(
                      height: 34,
                      width: 300,
                      hintText: "이메일",
                      fontSize: 12,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 6.0),
                    MyTextField(
                      height: 34,
                      width: 300,
                      hintText: "비밀번호",
                      fontSize: 12,
                      obscureText: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 6.0),
                    SizedBox(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Checkbox(
                            side: const BorderSide(
                              color: colorLightest,
                              width: 1,
                            ),
                            activeColor: colorLightest,
                            value: _isAutoLogin,
                            onChanged: (value) {
                              setState(() {
                                _isAutoLogin = value!;
                                SharedPreferences.prefs.setBool(
                                    Preferences.autoLogin.name, _isAutoLogin);
                              });
                            },
                          ),
                          const Text(
                            "자동 로그인",
                            style: TextStyle(
                              color: grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    MyTextButton(
                      height: 34,
                      width: 300,
                      text: "로그인",
                      fontSize: 12,
                      hasBorder: true,
                      onPressed: () async {
                        await _signin(
                          SignInRequestDto(
                            email: _emailController.text,
                            password: encrypt(_passwordController.text),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 6.0),
                    MyTextButton(
                      height: 34,
                      width: 300,
                      text: "회원가입",
                      fontSize: 12,
                      hasBorder: true,
                      onPressed: () {
                        showSignUpDialog();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFFF5FFFC),
              child: const Center(
                child: Text(
                  "CONERSTONE",
                  style: TextStyle(
                    color: colorLightest,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Color(0x4400FF38),
                        offset: Offset(14, 14),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
