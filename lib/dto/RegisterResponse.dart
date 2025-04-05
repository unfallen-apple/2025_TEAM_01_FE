class RegisterResponse {
  final bool isSuccess;
  final String? username;
  final String? password;
  final String? nickname;

  RegisterResponse({
    required this.isSuccess,
    this.username,
    this.password,
    this.nickname
  });
}
