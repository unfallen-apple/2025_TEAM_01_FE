import 'package:flutter/material.dart';
import 'package:semoton_front/main.dart'; //되돌아가기 버튼 사용을 위해서
import 'package:semoton_front/a_l/chat_brown/chat_box.dart' as brown;
import 'package:semoton_front/a_l/chat_yellow/chat_box.dart'as yellow;

class ChooseCharacter extends StatelessWidget {
  final String missionTitle;
  const ChooseCharacter(this.missionTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height, //화면 높이 동적으로 인식
              child: Image.asset(
                'assets/chat_home.png',
                fit: BoxFit.fitWidth,
              ),
            ),

            //상단 선택제안 창
            Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: CustomMissionWidget(),
            ),


            // 캐릭터와 Select 버튼
            Positioned(
              top: 220,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 캐릭터 1
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/character1/meet.png',
                        width: 200,
                        height: 290,
                      ),
                      Positioned(
                        bottom: 100, // 이미지 중간 아래쯤 (명치 근처)
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => brown.ChatBox1(missionTitle)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Select',style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ],
                  ),

                  // 캐릭터 2
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/character2/meet.png',
                        width: 200,
                        height: 290,
                      ),
                      Positioned(
                        bottom: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => yellow.ChatBox1(missionTitle)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Select',style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 하단 흰색 컨테이너 2개
            Positioned(
              bottom: 110,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70,width: 7),
                        borderRadius: BorderRadius.circular(21),
                        color: Colors.transparent,
                      ),
                      child: Container(
                        width: 170,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.yellow.shade200,
                            width: 2,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "박하늘 22학번 23살\n\ \n",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "캐릭터 설명 : 왈가닥, 칠칠맞은 성격이 특징인 선배. 나와는 동아리 방에서 한 번 정도 마주쳤던 사이다. 어색하긴 한데.",

                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70,width: 7),
                        borderRadius: BorderRadius.circular(21),
                        color: Colors.transparent,
                      ),
                      child: Container(
                        width: 170,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.yellow.shade200,
                            width: 2,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "한채린 24학번 21살 \n\n",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "캐릭터 설명 : 의지 넘치고 긍정적인 선배. 동아리 OT때 앞에 앉은 이후로 몇 번 같이 공부도 했었다. 소문으로는 엄청난비밀이 있다고.",

                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )

    );
  }
}


//상단 선택 제안 창
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
                      text: "Choose your character",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900,fontSize: 20  ),
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

// class ChooseCharacter extends StatelessWidget {
//   final String missionTitle;
//   const ChooseCharacter(this.missionTitle, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height, //화면 높이 동적으로 인식
//               child: Image.asset(
//                 'assets/chat_home.png',
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//
//             //상단 선택제안 창
//             Positioned(
//               top: 80,
//               left: 20,
//               right: 20,
//               child: CustomMissionWidget(missionTitle),
//             ),
//
//
//             // 캐릭터와 Select 버튼
//             Positioned(
//               top: 220,
//               left: 0,
//               right: 0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // 캐릭터 1
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/character1/meet.png',
//                         width: 200,
//                         height: 290,
//                       ),
//                       Positioned(
//                         bottom: 100, // 이미지 중간 아래쯤 (명치 근처)
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => brown.ChatBox1(missionTitle)),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.pinkAccent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           child: const Text('Select'),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   // 캐릭터 2
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/character2/meet.png',
//                         width: 200,
//                         height: 290,
//                       ),
//                       Positioned(
//                         bottom: 100,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => yellow.ChatBox1(missionTitle)),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.pinkAccent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           child: const Text('Select'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             // 하단 흰색 컨테이너 2개
//             Positioned(
//               bottom: 110,
//               left: 0,
//               right: 0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(3.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white70,width: 7),
//                         borderRadius: BorderRadius.circular(21),
//                         color: Colors.transparent,
//                       ),
//                       child: Container(
//                         width: 170,
//                         height: 200,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.yellow.shade200,
//                             width: 2,
//                           ),
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 4,
//                               offset: Offset(2, 2),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(3.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white70,width: 7),
//                         borderRadius: BorderRadius.circular(21),
//                         color: Colors.transparent,
//                       ),
//                       child: Container(
//                         width: 170,
//                         height: 200,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.yellow.shade200,
//                             width: 2,
//                           ),
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 4,
//                               offset: Offset(2, 2),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         )
//
//     );
//   }
// }
//
//
// //상단 선택 제안 창
// class CustomMissionWidget extends StatelessWidget {
//   final String missionTitle;
//   const CustomMissionWidget(this.missionTitle, {super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       alignment: Alignment.center,
//       children: [
//         // 배경 컨테이너
//         Container(
//           height: 60,
//           padding: const EdgeInsets.symmetric(horizontal: 60),
//           decoration: BoxDecoration(
//             color: Colors.pink.shade200,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 5,
//                 offset: Offset(2, 2),
//               ),
//             ],
//           ),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Text.rich(
//                 textAlign: TextAlign.center,
//                 TextSpan(
//                   children: [
//                     TextSpan(
//                       text: "Choose your character",
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//         // 좌우 둥근 장식
//         Positioned( //좌측 장식
//           left: -15,
//           child: Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.pink.shade200,
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//         Positioned( // 우측 장식
//           right: -15,
//           child: Container(
//             width: 42,
//             height: 42,
//             decoration: BoxDecoration(
//               color: Colors.pink.shade200,
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//
//         // 위아래 흰색 선
//         Positioned(
//           left: 20,
//           right: 20,
//           top: 0.01,
//           child: Divider(
//             color: Colors.white54,
//             thickness: 2,
//           ),
//         ),
//         Positioned(
//           left: 20,
//           right: 20,
//           bottom: 0.01,
//           child: Divider(
//             color: Colors.white54,
//             thickness: 2,
//           ),
//         ),
//       ],
//     );
//   }
// }
