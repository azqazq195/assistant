// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as int,
      error: json['error'] as String?,
      errorCode: json['errorCode'] as String?,
      message: json['message'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'status': instance.status,
      'error': instance.error,
      'errorCode': instance.errorCode,
      'message': instance.message,
      'data': instance.data,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    // baseUrl ??= 'https://api.moseoh.xyz/v1';
    baseUrl ??= 'http://localhost:8080/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Response> signup(signUpRequestDto) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    data.addAll(signUpRequestDto.toJson());
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            Options(method: 'POST', headers: headers, extra: extra)
                .compose(_dio.options, '/authentication/signup',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Response.fromJson(result.data!);
    return value;
  }

  @override
  Future<Response> signin(signInRequestDto) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    data.addAll(signInRequestDto.toJson());
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            Options(method: 'POST', headers: headers, extra: extra)
                .compose(_dio.options, '/authentication/signin',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Response.fromJson(result.data!);
    return value;
  }

  @override
  Future<Response> reload(accessToken, reloadRequestDto) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{r'X-AUTH-TOKEN': accessToken};
    headers.removeWhere((k, v) => v == null);
    final data = <String, dynamic>{};
    data.addAll(reloadRequestDto.toJson());
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            Options(method: 'POST', headers: headers, extra: extra)
                .compose(_dio.options, '/code/reload',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Response.fromJson(result.data!);
    return value;
  }

  @override
  Future<Response> tablenames(accessToken, databaseName) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'databaseName': databaseName};
    final headers = <String, dynamic>{r'X-AUTH-TOKEN': accessToken};
    headers.removeWhere((k, v) => v == null);
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, '/code/tablenames',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Response.fromJson(result.data!);
    return value;
  }

  @override
  Future<Response> table(accessToken, databaseName, tablename) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'databaseName': databaseName,
      r'tablename': tablename
    };
    final headers = <String, dynamic>{r'X-AUTH-TOKEN': accessToken};
    headers.removeWhere((k, v) => v == null);
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, '/code/table',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Response.fromJson(result.data!);
    return value;
  }

  @override
  Future<Response> domain(accessToken, mtableId) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{r'X-AUTH-TOKEN': accessToken};
    headers.removeWhere((k, v) => v == null);
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, '/code/domain/${mtableId}',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Response.fromJson(result.data!);
    return value;
  }

  @override
  Future<Response> mapper(accessToken, mtableId) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{r'X-AUTH-TOKEN': accessToken};
    headers.removeWhere((k, v) => v == null);
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, '/code/mapper/${mtableId}',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Response.fromJson(result.data!);
    return value;
  }

  @override
  Future<Response> mybatis(accessToken, mtableId) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{r'X-AUTH-TOKEN': accessToken};
    headers.removeWhere((k, v) => v == null);
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, '/code/mybatis/${mtableId}',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Response.fromJson(result.data!);
    return value;
  }

  @override
  Future<Response> service(accessToken, mtableId) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{r'X-AUTH-TOKEN': accessToken};
    headers.removeWhere((k, v) => v == null);
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, '/code/service/${mtableId}',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Response.fromJson(result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
