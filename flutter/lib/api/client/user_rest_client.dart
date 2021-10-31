import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'user_rest_client.g.dart';

@RestApi(baseUrl: "localhost:8080/")
abstract class UserRestClient {
  factory UserRestClient(Dio dio, {String baseUrl}) = _UserRestClient;

  @GET('/login')
  Future<LoginResponse> login();

  @GET('/user/{id}')
  Future<User> getUser(@Path('id') id);

  @POST('/user')
  Future<bool> createUser(@Body() Map user);
}

@JsonSerializable()
class LoginResponse {
  int? id;
  String? message;
  String result;

  LoginResponse({
    this.id,
    this.message,
    required this.result,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
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
