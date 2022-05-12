import 'package:fluent/api/dto/authentication_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'rest_client.g.dart';

// flutter pub run build_runner build

@RestApi(baseUrl: "https://api.moseoh.xyz/v1")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/authentication/signup")
  Future<Response> singup(@Body() SignUpRequestDto signUpRequestDto);

  @POST("/authentication/signin")
  Future<Response> signin(@Body() SignInRequestDto signInRequestDto);
}

@JsonSerializable()
class Response {
  DateTime timestamp;
  int status;
  String? error;
  String? errorCode;
  String message;
  List<dynamic>? data;

  Response({
    required this.timestamp,
    required this.status,
    this.error,
    this.errorCode,
    required this.message,
    this.data,
  });

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);

  List<SignInResponseDto> getSignInResponseDto() {
    return data!.map((e) => e as SignInResponseDto).toList();
  }

  bool ok() {
    return status == 200;
  }
}
