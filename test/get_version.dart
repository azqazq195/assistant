import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:yaml/yaml.dart';

Future<void> main() async {
  const version = "v0.3";
  const _url =
      "https://github.com/azqazq195/sql_to_mapper/releases/download/$version/Release.zip";

  Future<String> getVersion() async {
    final configFile = File('pubspec.yaml');
    final yamlString = await configFile.readAsString();
    final dynamic yamlMap = loadYaml(yamlString);
    return yamlMap['version'];
  }

  Future<void> main() async {
    print("Main");
    print(await getVersion());
  }

  await main();
}
