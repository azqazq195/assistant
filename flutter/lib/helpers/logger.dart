import 'dart:io';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart' as log;
import 'package:path_provider/path_provider.dart';

class Logger {
  static late final String localDirectory;
  static late final File logTxt;
  static final logger = log.Logger(
    printer: log.PrettyPrinter(),
  );
  static final loggerNoStack = log.Logger(
    printer: log.PrettyPrinter(methodCount: 0),
  );

  static Future init() async {
    localDirectory = await _localPath;
    logTxt = await _logTxt;
    Logger.i("Logger initialize");
  }

  static Future<String> get _localPath async {
    final document = await getApplicationDocumentsDirectory();
    final directory = Directory('${document.path}/assistant');
    directory.create();
    return directory.path;
  }

  static Future<File> get _logTxt async {
    final directory = Directory('$localDirectory/log');
    directory.create();
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return File('${directory.path}/$date.txt');
  }

  static v(String message) {
    String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    message = '[$date] $message';
    logger.v(message);
    logTxt.writeAsString('$message\n', mode: FileMode.append);
  }

  static d(String message) {
    String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    message = '[$date] $message';
    logger.d(message);
    logTxt.writeAsString('$message\n', mode: FileMode.append);
  }

  static i(String message) {
    String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    message = '[$date] $message';
    logger.i(message);
    logTxt.writeAsString('$message\n', mode: FileMode.append);
  }

  static w(String message) {
    String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    message = '[$date] $message';
    logger.w(message);
    logTxt.writeAsString('$message\n', mode: FileMode.append);
  }

  static e(String message) {
    String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    message = '[$date] $message';
    logger.e(message);
    logTxt.writeAsString('$message\n', mode: FileMode.append);
  }
}
