import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:assistant/constants/token.dart';

part 'git_rest_client.g.dart';

@RestApi(baseUrl: "https://api.github.com/repos/azqazq195/assistant/releases")
abstract class GitRestClient {
  factory GitRestClient(Dio dio, {String baseUrl}) = _GitRestClient;

  @Headers({"Accept": "application/vnd.github.v3+json", "Authorization": token})
  @GET('/latest')
  Future<Release> getReleaseLatest();

  @Headers({"Accept": "application/vnd.github.v3+json", "Authorization": token})
  @GET('')
  Future<List<Release>> getReleaseList();
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
