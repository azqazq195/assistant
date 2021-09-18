import 'package:flutter/material.dart';
import 'package:sql_to_mapper/widgets/custom_text.dart';

class AuthenticationViewPage extends StatelessWidget {
  const AuthenticationViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CustomText(text: "AuthenticationView"));
  }
}
