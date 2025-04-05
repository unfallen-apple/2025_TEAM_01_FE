class LoginResponse {
  final bool isSuccess;
  final int? userId;
  final String? nickname;

  LoginResponse ({
    required this.isSuccess,
    this.userId,
    this.nickname,
  });
}
