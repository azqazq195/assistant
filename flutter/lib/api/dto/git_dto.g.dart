// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleaseDto _$ReleaseDtoFromJson(Map<String, dynamic> json) => ReleaseDto(
      name: json['name'] as String,
      tagName: json['tagName'] as String,
      body: json['body'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      url: json['url'] as String,
      downloadUrl: json['downloadUrl'] as String?,
    );

Map<String, dynamic> _$ReleaseDtoToJson(ReleaseDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tagName': instance.tagName,
      'body': instance.body,
      'createdAt': instance.createdAt.toIso8601String(),
      'url': instance.url,
      'downloadUrl': instance.downloadUrl,
    };
