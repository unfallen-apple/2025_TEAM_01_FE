import '../network/api_service.dart';
/////////////////////////////////////건물 클래스////////////////////////
class Building {
  final String name; // 건물 이름
  final String greyImage; // 기본 회색 이미지
  final String redImage; // 근처일 때 빨간색 이미지
  final String pinkImage; // 클리어하면 핑크색 이미지
  // final double latitude; // 건물의 위도
  // final double longitude; // 건물의 경도
  bool isNearby; // 사용자가 근처에 있을 때 true
  bool isCleared; // 미션 클리어하면 true
  int? score;
  String? grade;

  Building({
    required this.name,
    required this.greyImage,
    required this.redImage,
    required this.pinkImage,
    // required this.latitude,
    // required this.longitude,
    this.isNearby = false,
    this.isCleared = false,
    this.score,
    this.grade,
  });
}
//건물들 색깔 저장 리스트
List<Building> buildings = [
  Building(
    name: 'mainGate',
    greyImage: 'assets/building/grey/img_0.png',
    redImage: 'assets/building/red/img_0.png',
    pinkImage: 'assets/building/pink/img_0.png',
  ),

  Building(
    name: '공대',
    greyImage: 'assets/building/grey/img_1.png',
    redImage: 'assets/building/red/img_1.png',
    pinkImage: 'assets/building/pink/img_1.png',
  ),

  Building(
    name: '외대',
    greyImage: 'assets/building/grey/img_2.png',
    redImage: 'assets/building/red/img_2.png',
    pinkImage: 'assets/building/pink/img_2.png',
  ),

  Building(
    name: '글로컬',
    greyImage: 'assets/building/grey/img_3.png',
    redImage: 'assets/building/red/img_3.png',
    pinkImage: 'assets/building/pink/img_3.png',
  ),

  Building(
    name: '멀관',
    greyImage: 'assets/building/grey/img_4.png',
    redImage: 'assets/building/red/img_4.png',
    pinkImage: 'assets/building/pink/img_4.png',
  ),

  Building(
    name: '생대',
    greyImage: 'assets/building/grey/img_5.png',
    redImage: 'assets/building/red/img_5.png',
    pinkImage: 'assets/building/pink/img_5.png',
  ),

  Building(
    name: '예대',
    greyImage: 'assets/building/grey/img_6.png',
    redImage: 'assets/building/red/img_6.png',
    pinkImage: 'assets/building/pink/img_6.png',
  ),

  Building(
    name: 'library',
    greyImage: 'assets/building/grey/img_7.png',
    redImage: 'assets/building/red/img_7.png',
    pinkImage: 'assets/building/pink/img_7.png',
  ),

  Building(
    name: '전정대',
    greyImage: 'assets/building/grey/img_8.png',
    redImage: 'assets/building/red/img_8.png',
    pinkImage: 'assets/building/pink/img_8.png',
  ),

  Building(
    name: '국제대',
    greyImage: 'assets/building/grey/img_9.png',
    redImage: 'assets/building/red/img_9.png',
    pinkImage: 'assets/building/pink/img_9.png',
  ),

  Building(
    name: 'peaceHall',
    greyImage: 'assets/building/grey/img_10.png',
    redImage: 'assets/building/red/img_10.png',
    pinkImage: 'assets/building/pink/img_10.png',
  ),
];

//건물 클리어 처리 하는 함수
void clearBuildingByName(String name) {
  final building = buildings.firstWhere((b) => b.name == name, orElse: () => throw Exception('Building not found'));
  building.isCleared = true;
}

//건물이 근처에 있는지 판단하는 함수
void nearBuildingByName(String name) {
  final building = buildings.firstWhere((b) => b.name == name, orElse: () => throw Exception('Building not found'));
  building.isNearby = true;
}


//백엔드 정보 활용
void updateBuildingListFromApi(Map<String, dynamic> apiResponse) {
  final progressList = apiResponse['progressList'];
  final landmarkList = apiResponse['landmarkList'];

  for (final building in buildings) {
    // progressList에서 해당 건물 정보 찾기
    final progress = progressList.firstWhere(
          (item) => item['landmarkName'] == building.name,
      orElse: () => null,
    );
    print("2222222222");
    print("2222222222");
    if (progress != null) {
      building.isCleared = progress['cleared'];
      building.score = progress['score'];
      building.grade = progress['grade'];
      // 점수나 등급을 저장하려면 Building 클래스에 필드 추가 필요
    }else{
      building.isCleared = false;
    }

    // landmarkList에서 nearby 여부 설정
    final landmark = landmarkList.firstWhere(
          (item) => item['landmarkName'] == building.name,
      orElse: () => null,
    );
    if (landmark != null) {
      building.isNearby = landmark['nearby'];
    }
  }
}
