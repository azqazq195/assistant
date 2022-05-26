import 'package:json_annotation/json_annotation.dart';

part 'git_dto.g.dart';

@JsonSerializable()
class ReleaseDto {
  String name;
  String tagName;
  String body;
  DateTime createdAt;
  String url;
  String? downloadUrl;

  ReleaseDto({
    required this.name,
    required this.tagName,
    required this.body,
    required this.createdAt,
    required this.url,
    this.downloadUrl,
  });

  factory ReleaseDto.fromJson(Map<String, dynamic> json) =>
      _$ReleaseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseDtoToJson(this);
}
