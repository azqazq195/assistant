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

TableResponseDto _$TableResponseDtoFromJson(Map<String, dynamic> json) =>
    TableResponseDto(
      svnTable: json['svnTable'] == null
          ? null
          : MTable.fromJson(json['svnTable'] as Map<String, dynamic>),
      userTable: MTable.fromJson(json['userTable'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TableResponseDtoToJson(TableResponseDto instance) =>
    <String, dynamic>{
      'svnTable': instance.svnTable,
      'userTable': instance.userTable,
    };

MTable _$MTableFromJson(Map<String, dynamic> json) => MTable(
      id: json['id'] as int,
      name: json['name'] as String,
      mcolumns: (json['mcolumns'] as List<dynamic>)
          .map((e) => MColumn.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MTableToJson(MTable instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mcolumns': instance.mcolumns,
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
