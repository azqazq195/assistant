import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  Future<dynamic> navigateTo(String routeName) {
    return navigationKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateToWithData(String routeName, String data) {
    return navigationKey.currentState!.pushNamed(routeName, arguments: data);
  }

  goBack() => navigationKey.currentState!.pop();
}
