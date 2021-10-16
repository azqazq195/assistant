import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://api.github.com/repos/azqazq195/assistant/releases")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @Headers({"Accept": "application/vnd.github.v3+json"})
  @GET('/latest')
  Future<Release> getReleaseLatest();

}

@JsonSerializable()
class Release {
  String tagName;
  String body;
  String createdAt;
  List<dynamic> assets;

  Release({
    required this.tagName,
    required this.body,
    required this.createdAt,
    required this.assets,
  });

  factory Release.fromJson(Map<String, dynamic> json) =>
      _$ReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseToJson(this);
}
