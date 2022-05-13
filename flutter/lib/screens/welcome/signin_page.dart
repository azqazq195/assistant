import 'package:fluent/api/api.dart';
import 'package:fluent/api/client/rest_client.dart';
import 'package:fluent/api/dto/authentication_dto.dart';
import 'package:fluent/utils/shared_preferences.dart';
import 'package:fluent/utils/utils.dart';
import 'package:fluent/utils/variable.dart';
import 'package:flutter/material.dart';

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
    if (_isAutoLogin) {
      _signin(SharedPreferences.prefs.getString(Preferences.email.name)!,
          SharedPreferences.prefs.getString(Preferences.password.name)!);
    }
  }

  signUp() {
    TextEditingController _username = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _passwordCheck = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Text(
            "회원가입",
            style: TextStyle(
              color: colorLightest,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                textInputAction: TextInputAction.next,
                controller: _username,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14),
                  hintText: "이름",
                  hintStyle: TextStyle(
                    color: grey,
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grey, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorLightest),
                  ),
                ),
              ),
              spacerH,
              TextField(
                textInputAction: TextInputAction.next,
                controller: _email,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14),
                  hintText: "이메일",
                  hintStyle: TextStyle(
                    color: grey,
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grey, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorLightest),
                  ),
                ),
              ),
              spacerH,
              TextField(
                textInputAction: TextInputAction.next,
                obscureText: true,
                controller: _password,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14),
                  hintText: "비밀번호",
                  hintStyle: TextStyle(
                    color: grey,
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grey, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorLightest),
                  ),
                ),
              ),
              spacerH,
              TextField(
                textInputAction: TextInputAction.next,
                obscureText: true,
                controller: _passwordCheck,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14),
                  hintText: "비밀번호 확인",
                  hintStyle: TextStyle(
                    color: grey,
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grey, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorLightest),
                  ),
                ),
              ),
              spacerH,
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 400,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              colorLightest,
                            ),
                          ),
                          onPressed: () async {
                            await _signup(
                              SignUpRequestDto(
                                  username: _username.text,
                                  email: _email.text,
                                  password: _password.text,
                                  passwordCheck: _passwordCheck.text),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "가입요청",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return colorLightest.withOpacity(0.04);
                                }
                                if (states.contains(MaterialState.focused) ||
                                    states.contains(MaterialState.pressed)) {
                                  return colorLightest.withOpacity(0.12);
                                }
                                return null; // Defer to the widget's default.
                              },
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "닫기",
                            style: TextStyle(
                              color: colorLightest,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  bool _isAutoLogin =
      SharedPreferences.prefs.getBool(Preferences.autoLogin.name) ?? false;
  final TextEditingController _emailController = TextEditingController(
      text: SharedPreferences.prefs.getString(Preferences.email.name) ?? "");
  final TextEditingController _passwordController = TextEditingController(
      text: SharedPreferences.prefs.getString(Preferences.password.name) ?? "");

  Future<void> _signin(String email, String password) async {
    Response response = await request(
        context,
        Api.restClient.signin(SignInRequestDto(
          email: email,
          password: password,
        )));
    if (response.ok()) {
      SharedPreferences.prefs.setString(Preferences.email.name, email);
      SharedPreferences.prefs.setString(Preferences.password.name, password);
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
                      "아~ 일하기 싫다✨",
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
                    SizedBox(
                      height: 34,
                      width: 300,
                      child: TextField(
                        controller: _emailController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 14),
                          hintText: "이메일",
                          hintStyle: TextStyle(
                            color: grey,
                            fontSize: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorLightest),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    SizedBox(
                      height: 34,
                      width: 300,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 14),
                          hintText: "비밀번호",
                          hintStyle: TextStyle(
                            color: grey,
                            fontSize: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorLightest),
                          ),
                        ),
                      ),
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
                    SizedBox(
                      height: 34,
                      width: 300,
                      child: OutlinedButton(
                        style: const ButtonStyle(),
                        onPressed: () async {
                          await _signin(
                              _emailController.text, _passwordController.text);
                        },
                        child: const Text(
                          "로그인",
                          style: TextStyle(
                            color: colorLightest,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    SizedBox(
                      height: 34,
                      width: 300,
                      child: OutlinedButton(
                        style: const ButtonStyle(),
                        onPressed: () {
                          signUp();
                        },
                        child: const Text(
                          "회원가입",
                          style: TextStyle(
                            color: colorLightest,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
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
