import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assistant/controllers/menu_controller.dart';
import 'package:assistant/controllers/navigation_controller.dart';
import 'package:assistant/layout.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/style.dart';

void main() {
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Assistant",
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
          }),
          primaryColor: Colors.blue),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool autoLoginValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "업무\n도우미",
              style: TextStyle(
                  fontSize: 46, fontWeight: FontWeight.w800, color: dark),
            ),
          ),
          const SizedBox(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[400]!.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.email,
                            size: 28,
                          ),
                        ),
                        hintText: "이메일",
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[400]!.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.lock,
                            size: 28,
                          ),
                        ),
                        hintText: "비밀번호",
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 8),
                      child: Checkbox(
                        value: autoLoginValue,
                        onChanged: (value) {
                          setState(() {
                            autoLoginValue = value!;
                          });
                        },
                      ),
                    ),
                    const Text("로그인 정보 저장"),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "로그인",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "회원가입",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
