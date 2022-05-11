class SignInRequestDto {
  String email;
  String password;

  SignInRequestDto({
    required this.email,
    required this.password,
  });
}

class SignInResponseDto {
  String grantType;
  String accessToken;
  String refreshToken;
  DateTime accessTokenExpireDate;

  SignInResponseDto({
    required this.grantType,
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpireDate,
  });
}

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
}
