import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sql_to_mapper/constants/controllers.dart';
import 'package:sql_to_mapper/routing/routes.dart';

class InsertSqlPage extends StatefulWidget {
  const InsertSqlPage({Key? key}) : super(key: key);

  @override
  State<InsertSqlPage> createState() => _InsertSqlPageState();
}

class _InsertSqlPageState extends State<InsertSqlPage> {
  final _sqlTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _sqlTextField = TextField(
      controller: _sqlTextEditController,
      minLines: 100,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        labelText: "Insert Your Sql Code",
        hintText: "Insert Sql Code to Convert.",
        labelStyle: TextStyle(color: Colors.blueAccent),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );

    var _convertButton = OutlinedButton(
      onPressed: () => {
        menuController.changeActiveItemTo(sideMenuItems[1]),
        navigationController.navigateToWithData(sideMenuItems[1], _sqlTextEditController.text),
      },
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Convert",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          side: BorderSide(width: 1.0, color: Colors.blueAccent),
        )),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: _sqlTextField,
              flex: 7,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _convertButton,
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sqlTextEditController.dispose();
    super.dispose();
  }
}
