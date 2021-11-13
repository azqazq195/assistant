import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future setWindowSize(double width, double height) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setSize(Size(width, height));
  });
}
