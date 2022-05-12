// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequestDto _$SignInRequestDtoFromJson(Map<String, dynamic> json) =>
    SignInRequestDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInRequestDtoToJson(SignInRequestDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

SignUpRequestDto _$SignUpRequestDtoFromJson(Map<String, dynamic> json) =>
    SignUpRequestDto(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      passwordCheck: json['passwordCheck'] as String,
    );

Map<String, dynamic> _$SignUpRequestDtoToJson(SignUpRequestDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'passwordCheck': instance.passwordCheck,
    };
