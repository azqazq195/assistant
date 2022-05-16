import 'package:assistant/api/dto/authentication_dto.dart';
import 'package:assistant/api/dto/code_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'rest_client.g.dart';

// flutter pub run build_runner build

// baseUrl ??= 'http://localhost:8080/v1';

@RestApi(baseUrl: "https://api.moseoh.xyz/v1")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/authentication/signup")
  Future<Response> signup(
    @Body() SignUpRequestDto signUpRequestDto,
  );

  @POST("/authentication/signin")
  Future<Response> signin(
    @Body() SignInRequestDto signInRequestDto,
  );

  @POST("/code/reload")
  Future<Response> reload(
    @Header("X-AUTH-TOKEN") String accessToken,
    @Body() ReloadRequestDto reloadRequestDto,
  );

  @GET("/code/tablenames")
  Future<Response> tablenames(
    @Header("X-AUTH-TOKEN") String accessToken,
    @Query("databaseName") String databaseName,
  );

  @GET("/code/columns")
  Future<Response> columns(
    @Header("X-AUTH-TOKEN") String accessToken,
    @Query("databaseName") String databaseName,
    @Query("tablename") String tablename,
  );
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

  SignInResponseDto getSignInResponseDto() {
    return data!.map((e) => SignInResponseDto.fromJson(e)).toList()[0];
  }

  ColumnsResponseDto getColumnsResponseDto() {
    return data!.map((e) => ColumnsResponseDto.fromJson(e)).toList()[0];
  }

  List<String> getTableNames() {
    if (data == null) {
      return [];
    } else {
      return data!.cast<String>();
    }
  }

  bool ok() {
    return status == 200;
  }
}
