//점수와 함께 대화하는 화면 8페이지
import 'package:semoton_front/a_l/chat_yellow/chat_last_page.dart';
import 'package:flutter/material.dart';
import 'package:semoton_front/a_l/chat_yellow/check_score.dart';
import 'package:flutter/scheduler.dart';


class ChatBox8 extends StatefulWidget {
  final String missionTitle;
  final int score;
  const ChatBox8(this.missionTitle, this.score, {super.key});
  @override
  _ChatBox8State createState() => _ChatBox8State();
}
class _ChatBox8State extends State<ChatBox8> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  int _currentIndex = 0;
  final String _text = '어때? 생각보다 즐거웠지? 카메라도 들고 나왔겠다, 기념으로 사진이라도 한 장 찍을까?';
  final int _frameInterval = 2;
  int _frameCounter = 0;
  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    _ticker.start();
  }

  void _onTick(Duration elapsed) {
    _frameCounter++;
    if (_frameCounter >= _frameInterval) {
      _frameCounter = 0;
      if (_currentIndex < _text.length) {
        setState(() {
          _currentIndex++;
        });
      } else {
        _ticker.stop();
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height, //화면 높이 동적으로 인식
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
              child: Image.asset('assets/character1/meet.png',width: 150,height: 370,),)
            ,
            //상단 퀘스트 바
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: CustomMissionWidget(),
            ),

            //퀘스트 바 밑 클리어 웨젯 (본 함수는 check_score.dart에 있음)
            Positioned(
              left: 20,
              right: 20,
              top: 120,
              child: MissionClear(),
            ),

            //점수 보여주는 위젯
            Positioned(
              top: 230,
              left: 20,
              right: 20,
              child: MiniScore(widget.score),
            ),



            //대화상자
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
                        border: Border.all(color: Colors.white,width: 3),
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

                  // 핑크색 타원
                  Positioned(
                    top: -11,
                    left: 30,
                    child: Container(
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white,width: 4),
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
                          child: Center(child: Text('이름',style: TextStyle(fontSize: 15,color: Colors.white),),)
                      ),
                    ),
                  ),

                  // 좌우 화살표 버튼
                  Positioned( //좌측 화살표
                      left: 20,
                      bottom: 15,
                      child: IconButton(onPressed: (){
                        Navigator.pop(context);
                      },
                        icon: Icon(Icons.arrow_left, size: 40, color: Colors.grey),
                      )
                  ),
                  Positioned( //우측 화살표
                      right: 20,
                      bottom: 15,
                      child: IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatLastPage(widget.missionTitle)),
                        );
                      },
                        icon: Icon(Icons.arrow_right, size: 40, color: Colors.pinkAccent),
                      )
                  ),

                  Positioned(
                    top: 35,
                    left: 35,
                    child: Text(
                      _text.substring(0, _currentIndex),
                      style: TextStyle(fontSize: 14, color: Colors.red.shade300),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}


//상단 퀘스트 바
class CustomMissionWidget extends StatelessWidget {
  const CustomMissionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // 배경 컨테이너
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
            color: Colors.pink.shade200,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "MISSION\n",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                    TextSpan(
                      text: "도서관 앞 동상과 함께 사진 찍기",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // 좌우 둥근 장식
        Positioned( //좌측 장식
          left: -15,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.pink.shade200,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned( // 우측 장식
          right: -15,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.pink.shade200,
              shape: BoxShape.circle,
            ),
          ),
        ),

        // 위아래 흰색 선
        Positioned(
          left: 20,
          right: 20,
          top: 0.01,
          child: Divider(
            color: Colors.white54,
            thickness: 2,
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 0.01,
          child: Divider(
            color: Colors.white54,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}

//점수 보여주는 위젯 작은 버전
class MiniScore extends StatelessWidget {
  final int score;
  const MiniScore(this.score, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: Colors.white70, width: 3),
                color: Colors.transparent,
              ),
              child: Container(
                width: 235,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 10.5,
                      child: Text(
                        "------   YOUR SCORE   ------",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Colors.pink.shade400,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.5),

                    //중앙 점수
                    Container(
                      padding: const EdgeInsets.all(2.2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: Colors.pink.shade200.withValues(alpha: 128),
                            width: 1.5),
                        color: Colors.transparent,
                      ),
                      child: Container(
                        width: 110,
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.pink.shade100,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2,
                            offset: Offset(0, -5),
                          ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '$score',    // 여기에 사용자 점수 대입
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                                color: Color(0xff9B4A4A),
                        ),
                      ),
                    ),
                      ),
                    ),

                    //좌우 화살표
                    Positioned(
                      left: 1,
                      child: Icon(
                          Icons.arrow_right_sharp, color: Color(0xffCC757E),
                          size: 55), // 삼각형 모양 화살표, 방향 변경
                    ),
                    Positioned(
                      right: 1,
                      child: Icon(
                          Icons.arrow_left_sharp, color: Color(0xffCC757E),
                          size: 55),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}