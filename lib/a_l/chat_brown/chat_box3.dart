//대화 화면3
import 'package:flutter/material.dart';
import 'package:semoton_front/a_l/chat_brown/chat_box4.dart';
import 'package:flutter/scheduler.dart';

class ChatBox3 extends StatefulWidget {
  final String missionTitle;
  const ChatBox3(this.missionTitle, {super.key});

  @override
  _ChatBox3State createState() => _ChatBox3State();
}
class _ChatBox3State extends State<ChatBox3> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  int _currentIndex = 0;
  final String _text = '퀘스트에 대해서 설명하는 화면이다';
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

            //상단 퀘스트 바
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: CustomMissionWidget(),
            ),

            //캐릭터
            Positioned(
              left: 20,
              right: 20,
              top: 120,
              child: Image.asset('assets/character1/ask.png',width: 150,height: 370,),)
            ,

            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Stack(
                clipBehavior: Clip.none, // Stack 밖으로 튀어나올 수 있게 함
                children: [
                  // 대화 상자
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
                          MaterialPageRoute(builder: (context) => ChatBox4(widget.missionTitle)),
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