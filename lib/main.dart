import 'package:flutter/material.dart';
import 'package:semoton_front/b_l/sign_up_page.dart';
import 'package:semoton_front/b_l/first_page.dart';
import 'package:semoton_front/b_l/ranking.dart';
import 'network/api_service.dart';
import 'dto/LoginResponse.dart';
import 'package:semoton_front/user_information.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),  // 추후 복원
    );
  }
}

// 로그인 화면
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final apiService = ApiService();
  final _idController = TextEditingController(); // 아이디 입력을 위한 컨트롤러
  final _passwordController = TextEditingController(); // 비밀번호 입력을 위한 컨트롤러

  // 로그인 처리 함수
  Future<void> _login() async {
    final id = _idController.text;
    final password = _passwordController.text;

    if (!_isValidId(id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("아이디는 영어만 입력 가능합니다")),
      );
      return;
    }

    try {
      LoginResponse response = await apiService.login(id, password);

      if (response.isSuccess) {
        onLoginSuccess(response);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Ranking()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("아이디 또는 비밀번호가 일치하지 않습니다.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인 중 오류가 발생했습니다.")),
      );
    }
  }

  bool _isValidId(String id) {
    final idRegex = RegExp(r'^[a-zA-Z]+$');
    return idRegex.hasMatch(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: Colors.pink.shade200,),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Colors.pink.shade200, Colors.yellow.shade50],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // 전체 패딩 설정
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 화면 중앙 정렬
              children: [
                Container(
                  padding: EdgeInsets.all(4.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,width: 1.5),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.brown,

                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _idController,
                          decoration: InputDecoration(
                              labelText: "ID",
                              labelStyle: TextStyle(color: Colors.pink)),
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: "PW",labelStyle: TextStyle(color: Colors.pink)),
                          obscureText: true,
                        ),
                        SizedBox(height: 16),


                        ElevatedButton(
                          onPressed: _login, // 로그인 버튼 눌렀을 때 _login 함수 실행
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              // 테두리 꾸미기 side: BorderSide(color: Colors.black, width: 2),

                            ),
                            minimumSize: Size(240, 50),
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          ),
                          child: Text(
                            "Start",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                //회원가입 버튼
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    "회원가입 하기",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

////////되돌아가기 버튼///////
class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed; // 버튼 클릭 시 동작 (기본값: 이전 화면으로 이동)

  const CustomBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: GestureDetector(
        onTap: onPressed ?? () => Navigator.pop(context), // 기본 동작: 이전 화면으로 이동
        child: Container(
          padding: const EdgeInsets.all(0.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white70, width: 1),
            color: Colors.transparent, // 배경 투명
          ),
          child: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 37,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
///////////////////////////////////////