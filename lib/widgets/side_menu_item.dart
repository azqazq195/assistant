import 'package:flutter/material.dart';
import 'package:sql_to_mapper/helpers/responsiveness.dart';
import 'package:sql_to_mapper/widgets/horizontal_menu_item.dart';
import 'package:sql_to_mapper/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final GestureTapCallback onTap;

  const SideMenuItem({Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomScreen(context)) {
      return VerticalMenuItem(itemName: itemName, onTap: onTap);
    }

    return HorizontalMenuItem(itemName: itemName, onTap: onTap);
  }
}
