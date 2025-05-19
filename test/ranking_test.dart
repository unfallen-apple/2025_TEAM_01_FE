import 'package:flutter_test/flutter_test.dart';
import 'package:codeflutter/b_l/ranking.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:codeflutter/network/api_service.dart';
import 'test.mocks.dart';

//Unittest할 함수 (기존 ranking에 해당 함수가 private라서 따로 작성)
String getGrade(double score) {
  if (score >= 90) return 'A+';
  if (score >= 85) return 'A';
  if (score >= 80) return 'A-';
  if (score >= 75) return 'B+';
  if (score >= 70) return 'B';
  if (score >= 65) return 'B-';
  if (score >= 60) return 'C+';
  if (score >= 55) return 'C';
  if (score >= 50) return 'C-';
  if (score >= 45) return 'D+';
  if (score >= 40) return 'D';
  if (score >= 35) return 'D-';
  return 'F';
}
@GenerateMocks([ApiService])
void main() {
  ////////////unittest/////////////
  test('점수에 따른 등급 테스트', () {
    expect(getGrade(92), 'A+');
    expect(getGrade(85), 'A');
    expect(getGrade(59), 'C+');
    expect(getGrade(20), 'F');
  });

  ////////////mock////////////////
  test('ApiService getRankings() mock 테스트', () async {
    // MockApiService 인스턴스 생성
    final mockApiService = MockApiService();

    // mock 데이터 정의
    final mockResponse = {
      'rankings': [
        {'nickname': 'user1', 'totalScore': 100},
        {'nickname': 'user2', 'totalScore': 80},
        {'nickname': 'user3', 'totalScore': 60},
        {'nickname': 'user4', 'totalScore': 40},
      ],
      'myNickName': 'mockUser',
      'myTotalScore': 75,
    };

    // getRankings 호출 시 mockResponse 반환하도록 설정
    when(mockApiService.getRankings()).thenAnswer((_) async => mockResponse);

    // 실제 호출
    final result = await mockApiService.getRankings();

    // 반환값 검증
    expect(result['myNickName'], 'mockUser');
    expect(result['rankings'].length, 4);
    expect(result['myTotalScore'], 75);
  });
}


