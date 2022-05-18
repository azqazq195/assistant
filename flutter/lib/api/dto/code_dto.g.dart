// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReloadRequestDto _$ReloadRequestDtoFromJson(Map<String, dynamic> json) =>
    ReloadRequestDto(
      dbPopulate: json['dbPopulate'] as String,
      centerDbPopulate: json['centerDbPopulate'] as String,
    );

Map<String, dynamic> _$ReloadRequestDtoToJson(ReloadRequestDto instance) =>
    <String, dynamic>{
      'dbPopulate': instance.dbPopulate,
      'centerDbPopulate': instance.centerDbPopulate,
    };

ColumnsResponseDto _$ColumnsResponseDtoFromJson(Map<String, dynamic> json) =>
    ColumnsResponseDto(
      svnColumns: (json['svnColumns'] as List<dynamic>)
          .map((e) => MColumn.fromJson(e as Map<String, dynamic>))
          .toList(),
      userColumns: (json['userColumns'] as List<dynamic>)
          .map((e) => MColumn.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ColumnsResponseDtoToJson(ColumnsResponseDto instance) =>
    <String, dynamic>{
      'svnColumns': instance.svnColumns,
      'userColumns': instance.userColumns,
    };

MColumn _$MColumnFromJson(Map<String, dynamic> json) => MColumn(
      id: json['id'] as int,
      name: json['name'] as String,
      ai: json['ai'] as bool,
      pk: json['pk'] as bool,
      fk: json['fk'] as bool,
      type: json['type'] as String,
      nullable: json['nullable'] as bool,
    );

Map<String, dynamic> _$MColumnToJson(MColumn instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ai': instance.ai,
      'pk': instance.pk,
      'fk': instance.fk,
      'type': instance.type,
      'nullable': instance.nullable,
    };
