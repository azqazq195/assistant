import 'package:flutter/material.dart';

const grey = Color.fromARGB(255, 130, 130, 130);

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/': (_) => const LoginPage()},
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isAutoLogin = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                          hintText: "이메일 주소",
                          hintStyle: TextStyle(
                            color: grey,
                            fontSize: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF589F5F)),
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
                            borderSide: BorderSide(color: Color(0xFF589F5F)),
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
                              color: Color(0xFF589F5F),
                              width: 1,
                            ),
                            activeColor: const Color(0xFF589F5F),
                            value: _isAutoLogin,
                            onChanged: (value) {
                              setState(() {
                                _isAutoLogin = value!;
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
                        onPressed: () {},
                        child: const Text(
                          "로그인",
                          style: TextStyle(
                            color: Color(0xFF589F5F),
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
                        onPressed: () {},
                        child: const Text(
                          "회원가입",
                          style: TextStyle(
                            color: Color(0xFF589F5F),
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
                    color: Color(0xFF589F5F),
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
