import 'package:semoton_front/dto/LoginResponse.dart';

class UserSession {
  static final UserSession instance = UserSession._internal();

  UserSession._internal();

  int? userId;
  String? nickname;

  void clear() {
    userId = null;
    nickname = null;
  }
}

void onLoginSuccess(LoginResponse response) {
  UserSession.instance.userId = response.userId;
  UserSession.instance.nickname = response.nickname;
}



