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
class TableResponseDto {
  MTable? svnTable;
  MTable userTable;

  TableResponseDto({
    this.svnTable,
    required this.userTable,
  });

  factory TableResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TableResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TableResponseDtoToJson(this);
}

@JsonSerializable()
class MTable {
  int id;
  String name;
  List<MColumn> mcolumns;

  MTable({
    required this.id,
    required this.name,
    required this.mcolumns,
  });

  factory MTable.fromJson(Map<String, dynamic> json) => _$MTableFromJson(json);

  Map<String, dynamic> toJson() => _$MTableToJson(this);
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
