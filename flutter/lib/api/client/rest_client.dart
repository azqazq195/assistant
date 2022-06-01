import 'package:assistant/api/dto/authentication_dto.dart';
import 'package:assistant/api/dto/code_dto.dart';
import 'package:assistant/api/dto/git_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'rest_client.g.dart';

// flutter pub run build_runner build

// baseUrl ??= 'http://localhost:8080/v1';

// accessTokenExpireDate: DateTime.fromMillisecondsSinceEpoch(
//     json['accessTokenExpireDate'] as int),

// createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),

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

  @GET("/code/table")
  Future<Response> table(
    @Header("X-AUTH-TOKEN") String accessToken,
    @Query("databaseName") String databaseName,
    @Query("tablename") String tablename,
  );

  @GET("/code/domain")
  Future<Response> domain(
    @Header("X-AUTH-TOKEN") String accessToken,
    @Query("mtableId") int mtableId,
  );

  @GET("/code/mapper")
  Future<Response> mapper(
    @Header("X-AUTH-TOKEN") String accessToken,
    @Query("mtableId") int mtableId,
  );

  @GET("/code/mybatis")
  Future<Response> mybatis(
    @Header("X-AUTH-TOKEN") String accessToken,
    @Query("mtableId") int mtableId,
  );

  @GET("/code/service")
  Future<Response> service(
    @Header("X-AUTH-TOKEN") String accessToken,
    @Query("mtableId") int mtableId,
  );

  @GET("/git/releases")
  Future<Response> releases(
    @Header("X-AUTH-TOKEN") String accessToken,
  );

  @GET("/git/releaseLatest")
  Future<Response> releaseLatest();
}

@JsonSerializable()
class Response {
  DateTime timestamp;
  int status;
  String? error;
  String? errorCode;
  String message;
  dynamic data;

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

  bool ok() {
    return status == 200;
  }

  SignInResponseDto getSignInResponseDto() {
    return SignInResponseDto.fromJson(data);
  }

  TableResponseDto getTableResponseDto() {
    return TableResponseDto.fromJson(data);
  }

  List<String> getTableNames() {
    if (data == null) {
      return [];
    } else {
      return data!.cast<String>();
    }
  }

  ReleaseDto getRelease() {
    return ReleaseDto.fromJson(data);
  }

  List<ReleaseDto> getReleaseList() {
    List<ReleaseDto> list = [];
    for (dynamic d in (data as List<dynamic>)) {
      list.add(ReleaseDto.fromJson(d));
    }
    return list;
  }
}
