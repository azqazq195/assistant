import 'package:json_annotation/json_annotation.dart';

part 'code_dto.g.dart';

@JsonSerializable()
class ReloadRequestDto {
  String dbPopulate;
  String centerDbPopulate;

  ReloadRequestDto({
    required this.dbPopulate,
    required this.centerDbPopulate,
  });

  factory ReloadRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ReloadRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReloadRequestDtoToJson(this);
}

@JsonSerializable()
class ColumnsResponseDto {
  List<MColumn> svnColumns;
  List<MColumn> userColumns;

  ColumnsResponseDto({
    required this.svnColumns,
    required this.userColumns,
  });

  factory ColumnsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ColumnsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ColumnsResponseDtoToJson(this);
}

@JsonSerializable()
class MColumn {
  int id;
  String name;
  bool ai;
  bool pk;
  bool fk;
  String type;
  bool nullable;

  MColumn({
    required this.id,
    required this.name,
    required this.ai,
    required this.pk,
    required this.fk,
    required this.type,
    required this.nullable,
  });

  factory MColumn.fromJson(Map<String, dynamic> json) =>
      _$MColumnFromJson(json);

  Map<String, dynamic> toJson() => _$MColumnToJson(this);
}
