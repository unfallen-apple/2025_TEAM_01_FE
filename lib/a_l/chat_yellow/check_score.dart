//점수 보여주는 화면 7페이지
//점수 애니메이션 끝나면, 다음 화면으로 이동 가능한 버튼 생기는 기능 추가하면 좋을 듯
import 'package:flutter/material.dart';
import 'package:semoton_front/a_l/chat_yellow/chat_box8.dart'as yellow;

class CheckScore extends StatelessWidget {
  final String missionTitle;
  final int score;
  const CheckScore(this.missionTitle, this.score, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 128),  // 어둡게 만들기, 숫자가 클 수록 어두워짐
                  BlendMode.darken),
                child: Image.asset(
                  'assets/chat_home.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),


            //상단 미션 위젯
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: CustomMissionWidget(),
            ),

            //중앙 사진찍기 위젯
            Positioned(
              top: 250,
              left: 20,
              right: 20,
              child: Score(score),
            ),
            Positioned(
              top: 600,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => yellow.ChatBox8(missionTitle, score)),
                );},
                child: Text('다음 화면으로 넘어가기 위한 임시 버튼'),
              ),
            ),

            //미션 클리어 위젯
            Positioned(
                left: 20,
                right: 20,
                top: 120,
              child: MissionClear(),
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

//퀘스트 상단 밑에 있는 미션 클리어 위젯
class MissionClear extends StatelessWidget {
  const MissionClear({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 175,
          height: 35,
          decoration: BoxDecoration(
            color: Color(0xff9B4A4A),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8
              ),
            ],
          ),
          child: Center(
            child: Text('MISSION CLEAR!',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//점수 보여주는 위젯 전체
class Score extends StatefulWidget {
  final int score;
  const Score(this.score, {super.key});

  @override
  _ScoreState createState() => _ScoreState();
}

class _ScoreState extends State<Score> with SingleTickerProviderStateMixin {
  late AnimationController _controller; //속도 조절
  late Animation<int> _animation; // 숫자 증가

  @override
  void initState() {
    super.initState(); //애니메이션 초기화
    _controller = AnimationController(
      duration: Duration(seconds: 3), // 높을 수록 느려짐
      vsync: this, //애니메이션 필요할때만 작동 - 리소스 낭비 막기
    );

    _animation = Tween<int>(begin: 0, end: widget.score) // end에 사용자 학점 변수 대입
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint)); // 무리함수 형태로 속도 조절

    _controller.forward(); // 애니메이션 실행
  }

  @override
  void dispose() {  //위젯이 화면에서 제거되면 호출되어 애니메이션 삭제 - 메모리 누수 방지
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.white70, width: 4),
                    color: Colors.transparent,
                  ),
                  child: Container(
                    width: 350,
                    height: 300,
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
                          top: 25,
                          child: Text(
                            "------   YOUR SCORE   ------",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.pink.shade400,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        //중앙 점수
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.pink.shade200.withValues(alpha: 128), width: 2),
                            color: Colors.transparent,
                          ),
                          child: Container(
                            width: 180,
                            height: 130,
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
                          ),
                        ),

                        //점수 오르는 애니메이션
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Text(
                              _animation.value.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff9B4A4A),
                              ),
                            );
                          },
                        ),

                        //좌우 화살표
                        Positioned(
                          left: -25,
                          child: Icon(Icons.arrow_right_sharp, color: Color(0xffCC757E), size: 130), // 삼각형 모양 화살표, 방향 변경
                        ),
                        Positioned(
                          right: -25,
                            child: Icon(Icons.arrow_left_sharp, color: Color(0xffCC757E), size: 130),
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