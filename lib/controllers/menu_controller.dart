import 'package:sql_to_mapper/constants/style.dart';
import 'package:sql_to_mapper/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  var activeItem = insertSqlPageRoute.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case insertSqlPageRoute:
        return _customIcon(Icons.add_task, itemName);
      case getDomainPageRoute:
        return _customIcon(Icons.task, itemName);
      case getMapperPageRoute:
        return _customIcon(Icons.task, itemName);
      case getMapperXMLPageRoute:
        return _customIcon(Icons.task, itemName);

      default:
        return _customIcon(Icons.task, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: 22,
        color: dark,
      );
    }

    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
