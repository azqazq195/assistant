import 'package:flutter/material.dart';
import 'package:sql_to_mapper/widgets/custom_text.dart';

class ClientsViewPage extends StatelessWidget {
  const ClientsViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CustomText(text: "ClientsView"));
  }
}
