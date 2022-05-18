import 'package:json_annotation/json_annotation.dart';

part 'authentication_dto.g.dart';

@JsonSerializable()
class SignInRequestDto {
  String email;
  String password;

  SignInRequestDto({
    required this.email,
    required this.password,
  });

  factory SignInRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestDtoToJson(this);
}

@JsonSerializable()
class SignInResponseDto {
  String grantType;
  String accessToken;
  String refreshToken;
  DateTime accessTokenExpireDate;
  // DateTime.fromMillisecondsSinceEpoch(json['accessTokenExpireDate'] as int * 1000),

  SignInResponseDto({
    required this.grantType,
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpireDate,
  });

  factory SignInResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseDtoToJson(this);
}

@JsonSerializable()
class SignUpRequestDto {
  String username;
  String email;
  String password;
  String passwordCheck;

  SignUpRequestDto({
    required this.username,
    required this.email,
    required this.password,
    required this.passwordCheck,
  });

  factory SignUpRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestDtoToJson(this);
}
