class LoginResponseEntity {
  const LoginResponseEntity({
    required this.userId,

    required this.token,
  });
  final String userId;
  final String token;
}
