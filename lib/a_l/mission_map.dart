import 'package:flutter/material.dart';
import 'package:semoton_front/a_l/building_information.dart';
import 'package:semoton_front/a_l/choose_character.dart';
import 'package:geolocator/geolocator.dart';
import '../network/api_service.dart';
import '../user_information.dart';
import '../LocationService.dart';


class MissionMapScreen extends StatefulWidget {
  const MissionMapScreen({super.key});

  @override
  _MissionMapScreenState createState() => _MissionMapScreenState();
}

class _MissionMapScreenState extends State<MissionMapScreen> {
  String? selectedMission;
  String? missionDescription;

  @override
  void initState() {
    super.initState();
    fetchProgressInfo();
  }

  Future<void> fetchProgressInfo() async {
    try {
      Position position = await LocationService.getCurrentLocation();
      double latitude = position.latitude;
      double longitude = position.longitude;

      int? userId = UserSession.instance.userId; // 사용자 ID

      final apiService = ApiService();
      print("??????????");
      print(latitude);

      final progressInfo = await apiService.getProgressInfo(userId, latitude, longitude);

      updateBuildingListFromApi(progressInfo);
    } catch (e) {
      print('위치 또는 API 호출 실패: $e');
    }
  }

  void selectMission(String missionTitle, String description) {
    setState(() {
      selectedMission = missionTitle;
      missionDescription = description;
    });
  }

  void completeMission(String missionTitle) {
    switch (missionTitle) {
      case "library":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChooseCharacter(missionTitle)),
        );
        break;
    // 나머지는 생략...
    }

    setState(() {
      selectedMission = null;
      missionDescription = null;
    });
  }

  Widget buildBuilding({
    required double xPercent,
    required double yPercent,
    required Widget icon,
    bool isSelected = false,
  }) {
    return Align(
      alignment: Alignment(xPercent * 2 - 1, yPercent * 2 - 1),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isSelected)
            Positioned.fill(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withAlpha(204),
                      Colors.white.withAlpha(102),
                      Colors.white.withAlpha(0)
                    ],
                    stops: [0.3, 0.7, 1.1],
                  ),
                ),
              ),
            ),
          icon,
        ],
      ),
    );
  }

  bool isSelectedBuildingNearby() {
    if (selectedMission == null) return false;
    try {
      final selected = buildings.firstWhere((b) => b.name == selectedMission);
      return selected.isNearby;
    } catch (e) {
      return false;
    }
  }
  //지도 화면 구성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              fetchProgressInfo(); // 새로고침
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 배경 지도
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: 400,
                height: 800,
                child: Image.asset('assets/map.png'),
              ),
            ),
          ),

          //배경 지도에 위치표시 가리기
          Positioned(
            left: 100,
            top: 40,
            child: Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),

//정문
    buildBuilding(
      xPercent: 0.340,
      yPercent: 0.085,
      isSelected: selectedMission == "mainGate",
      icon: GestureDetector(
      onTap: () {
        print("Mission Selected: mainGate");
        print("Selected Mission: $selectedMission");
        print("Is Cleared: ${buildings[0].isCleared}");
        print("Is Nearby: ${buildings[0].isNearby}");
        print("Image Path: ${buildings[0].isCleared ? buildings[0].pinkImage :
        buildings[0].isNearby ? buildings[0].redImage : buildings[0].greyImage}");

        selectMission("mainGate", "정문을 배경으로 사진 찍기");
      },
      child: Image.asset(
        buildings[0].isCleared ? buildings[0].pinkImage :
        buildings[0].isNearby ? buildings[0].redImage :
        buildings[0].greyImage,
        width: 115, height: 115,
      ),
      ),
    ),


          //공대
          buildBuilding(
            xPercent: 0.517,
            yPercent: 0.190,
            isSelected: selectedMission == "공대",
            icon: GestureDetector(
              onTap: () => selectMission("공대", "공과대학 배경으로 사진 찍기"),
              child: Image.asset(
                buildings[1].isCleared ? buildings[1].pinkImage :
                buildings[1].isNearby ? buildings[1].redImage :
                buildings[1].greyImage,
                width: 40, height: 40,
              ),
            ),
          ),

          //외국어 대학
          buildBuilding(
            xPercent: 0.238,
            yPercent: 0.230,
            isSelected: selectedMission == "외대",
            icon: GestureDetector(
              onTap: () => selectMission("외대", "여기에 미션"),
              child: Image.asset(
                buildings[2].isCleared ? buildings[2].pinkImage :
                buildings[2].isNearby ? buildings[2].redImage :
                buildings[2].greyImage,
                width: 50, height: 50,
              ),
            ),
          ),

          //글로컬
          buildBuilding(
            xPercent: 0.515,
            yPercent: 0.270,
            isSelected: selectedMission == "글로컬",
            icon: GestureDetector(
              onTap: () => selectMission("글로컬", "여기에 미션"),
              child: Image.asset(
                buildings[3].isCleared ? buildings[3].pinkImage :
                buildings[3].isNearby ? buildings[3].redImage :
                buildings[3].greyImage,
                width: 40, height: 40,
              ),
            ),
          ),

          //멀관
          buildBuilding(
            xPercent: 0.302,
            yPercent: 0.310,
            isSelected: selectedMission == "멀관",
            icon: GestureDetector(
              onTap: () => selectMission("멀관", "여기에 미션"),
              child: Image.asset(
                buildings[4].isCleared ? buildings[4].pinkImage :
                buildings[4].isNearby ? buildings[4].redImage :
                buildings[4].greyImage,
                width: 40, height: 40,
              ),
            ),
          ),

          //생대
          buildBuilding(
            xPercent: 0.500,
            yPercent: 0.360,
            isSelected: selectedMission == "생대",
            icon: GestureDetector(
              onTap: () => selectMission("생대", "여기에 미션"),
              child: Image.asset(
                buildings[5].isCleared ? buildings[5].pinkImage :
                buildings[5].isNearby ? buildings[5].redImage :
                buildings[5].greyImage,
                width: 40, height: 40,
              ),
            ),
          ),

          //예대
          buildBuilding(
            xPercent: 0.780,
            yPercent: 0.430,
            isSelected: selectedMission == "예대",
            icon: GestureDetector(
              onTap: () => selectMission("예대", "여기에 미션"),
              child: Image.asset(
                buildings[6].isCleared ? buildings[6].pinkImage :
                buildings[6].isNearby ? buildings[6].redImage :
                buildings[6].greyImage,
                width: 45, height: 45,
              ),
            ),
          ),

          //중도
          buildBuilding(
            xPercent: 0.315,
            yPercent: 0.489,
            isSelected: selectedMission == "library",
            icon: GestureDetector(
              onTap: () {
                print("Mission Selected: library");
                print("Selected Mission: $selectedMission");
                print("Is Cleared: ${buildings[7].isCleared}");
                print("Is Nearby: ${buildings[7].isNearby}");
                print("Image Path: ${buildings[7].isCleared ? buildings[7].pinkImage :
                buildings[0].isNearby ? buildings[7].redImage : buildings[7].greyImage}");

                selectMission("library", "도서관을 배경으로 사진 찍기");
              },
              child: Image.asset(
                buildings[7].isCleared ? buildings[7].pinkImage :
                buildings[7].isNearby ? buildings[7].redImage :
                buildings[7].greyImage,
                width: 135, height: 135,
              ),
            ),
          ),

          //전정대
          buildBuilding(
            xPercent: 0.765,
            yPercent: 0.525,
            isSelected: selectedMission == "전정대",
            icon: GestureDetector(
              onTap: () => selectMission("전정대", "여기에 미션"),
              child: Image.asset(
                buildings[8].isCleared ? buildings[8].pinkImage :
                buildings[8].isNearby ? buildings[8].redImage :
                buildings[8].greyImage,
                width: 50, height: 50,
              ),
            ),
          ),

          //국제대
          buildBuilding(
            xPercent: 0.835,
            yPercent: 0.592,
            isSelected: selectedMission == "국제대",
            icon: GestureDetector(
              onTap: () => selectMission("국제대", "여기에 미션"),
              child: Image.asset(
                buildings[9].isCleared ? buildings[9].pinkImage :
                buildings[9].isNearby ? buildings[9].redImage :
                buildings[9].greyImage,
                width: 40, height: 40,
              ),
            ),
          ),

          //노천극장
          buildBuilding(
            xPercent: 0.635,
            yPercent: 0.695,
            isSelected: selectedMission == "peaceHall",
            icon: GestureDetector(
              onTap: () => selectMission("peaceHall", "여기에 미션"),
              child: Image.asset(
                buildings[10].isCleared ? buildings[10].pinkImage :
                buildings[10].isNearby ? buildings[10].redImage :
                buildings[10].greyImage,
                width: 130, height: 130,
              ),
            ),
          ),
          // 미션 정보 박스
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: selectedMission != null && isSelectedBuildingNearby() ? Colors.pink.shade200 : Colors.grey, width: 3),
                  borderRadius: BorderRadius.circular(21),
                  color: Colors.transparent,
                ),
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: (selectedMission != null && isSelectedBuildingNearby())
                        ? Colors.pink.shade200
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 260,
                        decoration: BoxDecoration(
                          color: Color(0x4DFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            selectedMission ?? "건물을 선택하세요",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff502929)),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 260,
                        decoration: BoxDecoration(
                          color: selectedMission != null ? Color(0x4DFFFFFF) : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          selectedMission != null ? "MISSION\n${missionDescription ?? ''}" : "",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: selectedMission != null ? Color(0x4DFFFFFF) : Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(23),
                          color: Colors.transparent,
                        ),
                        child: ElevatedButton(
                          onPressed: (selectedMission != null && isSelectedBuildingNearby())
                              ? () => completeMission(selectedMission!)
                              : null,
                          child: Text("START"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}







