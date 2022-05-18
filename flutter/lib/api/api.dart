import 'package:assistant/api/client/rest_client.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:assistant/utils/logger.dart';

class Api {
  static late final RestClient restClient;

  static init(Dio dio) {
    restClient = RestClient(dio);
    Logger.i("Api initialize");
  }
}
