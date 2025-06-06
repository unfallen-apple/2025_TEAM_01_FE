// 메인 지도로 돌아갈 건지 물어보는 화면 9페이지
import 'package:flutter/material.dart';
import 'package:semoton_front/a_l/mission_map.dart';
import 'package:semoton_front/a_l/building_information.dart';

class ChatLastPage extends StatelessWidget {
  final String missionTitle;
  const ChatLastPage(this.missionTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height, // 화면 높이 동적으로 인식
            child: Image.asset(
              'assets/chat_home.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                clearBuildingByName(missionTitle);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MissionMapScreen(),
                  ),
                );
              },
              child: const Text('지도로 돌아가기'),
            ),
          )
        ],
      ),
    );
  }
}
