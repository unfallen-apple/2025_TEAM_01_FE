import 'package:flutter/material.dart';
import 'package:semoton_front/main.dart';
import '../network/api_service.dart';
import '../dto/RegisterResponse.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _idController = TextEditingController(); // 아이디 입력 필드
  final _passwordController = TextEditingController(); // 비밀번호 입력 필드
  final _nickNameController = TextEditingController(); // 이메일 입력 필드

  void _signup() async {
    final id = _idController.text;
    final password = _passwordController.text;
    final nickname = _nickNameController.text;

    if (id.isEmpty || password.isEmpty || nickname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("모든 항목을 입력해주세요")),
      );
      return;
    } else if (!_isValidId(id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("아이디는 영어만 입력 가능합니다")),
      );
      return;
    } else if (!_isValidId(nickname)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("닉네임을 영어로 지어주세요!")),
      );
      return;
    }

    // API 요청 실행
    final apiService = ApiService();
    RegisterResponse response = await apiService.register(
      username: id,
      password: password,
      nickname: nickname,
    );

    if (response.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("회원가입이 완료되었습니다")),
      );

      // 로그인 화면으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("회원가입에 실패했습니다. 다시 시도해주세요.")),
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
        leading: const CustomBackButton(),
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
                          "Join",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.brown,

                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _idController, // 아이디 입력 필드
                          decoration: InputDecoration(
                              labelText: "ID",
                              labelStyle: TextStyle(color: Colors.pink)),
                        ),
                        TextField(
                          controller: _passwordController, // 비밀번호 입력 필드
                          decoration: InputDecoration(labelText: "PW",labelStyle: TextStyle(color: Colors.pink)),
                          obscureText: true, // 비밀번호는 텍스트가 보이지 않게 함
                        ),
                        TextField(
                          controller: _nickNameController, // 닉네임 입력 필드
                          decoration: InputDecoration(
                              labelText: "Nickname",
                              labelStyle: TextStyle(color: Colors.pink)),
                        ),
                        SizedBox(height: 16), // 간격


                        ElevatedButton(
                          onPressed: _signup,
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
                            "Sign up",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
