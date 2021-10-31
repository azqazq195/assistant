import 'dart:async';
import 'dart:io';

import 'package:assistant/api/client/git_rest_client.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  final client = GitRestClient(Dio());

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    // String filePath = '$appDocumentsPath/Release.zip'; // 3
    String filePath = '$appDocumentsPath/Release.txt'; // 3
    return filePath;
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  Future download2(Dio dio) async {
    // const url = "https://github.com/azqazq195/assistant/releases/download/v0.3/Release.zip";
    const url = "https://github.com/azqazq195/assistant/releases/download/v0.4/default.txt";
    final savePath = await getFilePath();

    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  await download2(Dio());

/*
  Future<void> saveFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = await getFilePath();
    print("directory: ${directory.path}");

    await client.getReleaseFile("v0.3", "Release.zip").then((it) {
      File file = File(filePath);
      var raf = file.openSync(mode: FileMode.write);
      Completer completer = Completer<String>();
      raf.writeStringSync();
      raf.closeSync();
      completer.complete(file.path);
    }).catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          print("Got error : ${res!.statusCode} -> ${res.statusMessage}");
          print(res.realUri.toString());
          break;
        default:
      }
    });
  }

  await saveFile();


 */
}
