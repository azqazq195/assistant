// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_rest_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Release _$ReleaseFromJson(Map<String, dynamic> json) => Release(
      tagName: json['tag_name'] as String,
      body: json['body'] as String,
      createdAt: json['created_at'] as String,
      assets: json['assets'] as List<dynamic>,
    );

Map<String, dynamic> _$ReleaseToJson(Release instance) => <String, dynamic>{
      'tagName': instance.tagName,
      'body': instance.body,
      'createdAt': instance.createdAt,
      'assets': instance.assets,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _GitRestClient implements GitRestClient {
  _GitRestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.github.com/repos/azqazq195/assistant/releases';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Release> getReleaseLatest() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Accept': 'application/vnd.github.v3+json'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Release>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/latest',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Release.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Release>> getReleaseList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Accept': 'application/vnd.github.v3+json'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Release>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Release.fromJson(i as Map<String, dynamic>))
        .toList();
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
