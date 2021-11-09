import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'user_rest_client.g.dart';

@RestApi(baseUrl: "http://localhost:8080")
abstract class UserRestClient {
  factory UserRestClient(Dio dio, {String baseUrl}) = _UserRestClient;

  @GET('/login')
  Future<Response> login();

  @GET('/user/{id}')
  Future<Response> getUser(@Path('id') id);

  @POST('/user')
  Future<Response> createUser(@Body() User user);
}

@JsonSerializable()
class Response {
  String result;
  String? message;
  dynamic meta;
  List<dynamic> data;

  Response({
    required this.result,
    this.message,
    this.meta,
    required this.data,
  });

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}

@JsonSerializable()
class Login {
  int id;

  Login({
    required this.id,
  });

  factory Login.fromJson(Map<String, dynamic> json) =>
      _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable()
class User {
  int id;
  String name;
  String email;
  DateTime createdDate;
  DateTime? updatedDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdDate,
    this.updatedDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
