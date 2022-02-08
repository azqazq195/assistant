import 'package:assistant/constants/custom_color.dart';
import 'package:assistant/pages/convertor/components/body.dart';
import 'package:assistant/pages/convertor/components/header.dart';
import 'package:flutter/material.dart';

class ConvertorPage extends StatefulWidget {
  const ConvertorPage({Key? key}) : super(key: key);

  @override
  _ConvertorPageState createState() => _ConvertorPageState();
}

class _ConvertorPageState extends State<ConvertorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.background,
      padding: const EdgeInsets.all(50),
      child: Column(
        children: const [
          Expanded(
            child: Header(),
          ),
          SizedBox(height: 30,),
          Expanded(
            flex: 8,
            child: Body(),
          ),
        ],
      ),
    );
  }
}
