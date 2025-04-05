//대화화면 1
//Ticker 시스템을 클래스로 만들어서 chat박스에서 import 만으로 사용할 수 있도록 변경해야 함
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Ticker를 사용하기 위해 추가
import 'package:semoton_front/a_l/chat_yellow/chat_box2.dart';

class ChatBox1 extends StatefulWidget {
  final String missionTitle;
  const ChatBox1(this.missionTitle, {super.key});

  @override
  _ChatBox1State createState() => _ChatBox1State();
}

class _ChatBox1State extends State<ChatBox1> with SingleTickerProviderStateMixin {
  late Ticker _ticker; // Ticker 선언
  int _currentIndex = 0; // 현재 출력할 문자 인덱스
  final String _text = '“혜정 박물관”. 오늘 미션 장소야.';
  final int _frameInterval = 2; // 몇 프레임마다 한 글자씩 출력할지 조정
  int _frameCounter = 0; // 프레임 카운터 추가

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick); // Ticker 초기화
    _ticker.start(); // Ticker 시작
  }

  // Ticker가 매 프레임마다 호출될 때 실행되는 함수
  void _onTick(Duration elapsed) {
    _frameCounter++; // 프레임 카운터 증가
    if (_frameCounter >= _frameInterval) { // _frameInterval에 도달했을 때 한 글자씩 증가
      _frameCounter = 0; // 프레임 카운터 초기화
      if (_currentIndex < _text.length) {
        setState(() {
          _currentIndex++; // 한 글자씩 증가
        });
      } else {
        _ticker.stop(); // 애니메이션이 끝나면 정지
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose(); // Ticker 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height, // 화면 높이 동적으로 설정
            child: Image.asset(
              'assets/chat_home.png',
              fit: BoxFit.fitWidth,
            ),
          ),

          //캐릭터
          Positioned(
            left: 20,
            right: 20,
            top: 120,
            child: Image.asset('assets/character2/meet.png',width: 150,height: 370,),)
          ,
          // 채팅 박스
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Stack(
              clipBehavior: Clip.none, // Stack 밖으로 튀어나올 수 있게 함
              children: [
                Padding(
                  padding: EdgeInsets.all(4.5),
                  child: Container(
                    padding: const EdgeInsets.all(1.5),
                    height: 220,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(21),
                      color: Colors.transparent,
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
                    ),
                  ),
                ),
                // 핑크색 타원 (이름 표시)
                Positioned(
                  top: -11,
                  left: 30,
                  child: Container(
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Container(
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.pink.shade200,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '이름',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                // 좌우 화살표 버튼 (이전/다음 화면 이동)
                Positioned(
                  left: 20,
                  bottom: 15,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_left, size: 40, color: Colors.grey),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 15,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatBox2(widget.missionTitle)),
                      );
                    },
                    icon: Icon(Icons.arrow_right, size: 40, color: Colors.pinkAccent),
                  ),
                ),
                // 애니메이션 텍스트 출력
                Positioned(
                  top: 35,
                  left: 35,
                  child: Text(
                    _text.substring(0, _currentIndex), // 현재 인덱스까지의 텍스트 출력
                    style: TextStyle(fontSize: 14, color: Colors.red.shade300),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

