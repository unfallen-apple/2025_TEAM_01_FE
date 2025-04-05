//대화 화면2
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Ticker를 사용하기 위해 추가
import 'package:semoton_front/a_l/chat_yellow/chat_box3.dart';

class ChatBox2 extends StatefulWidget {
  final String missionTitle;
  const ChatBox2(this.missionTitle, {super.key});

  @override
  _ChatBox2State createState() => _ChatBox2State();
}

class _ChatBox2State extends State<ChatBox2> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  int _currentIndex = 0;
  final String _text = '후훗. 입구에 가서 찍어와. 참, 여기.';
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
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/chat_home.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              top: 120,
              child: Image.asset('assets/character2/introduce.png', width: 150, height: 370),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Stack(
                clipBehavior: Clip.none,
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
                          MaterialPageRoute(builder: (context) => ChatBox3(widget.missionTitle)),
                        );
                      },
                      icon: Icon(Icons.arrow_right, size: 40, color: Colors.pinkAccent),
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 35,
                    child: Text(
                      _text.substring(0, _currentIndex),
                      style: TextStyle(fontSize: 14, color: Colors.red.shade300),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
