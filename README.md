# semoton_front
  공동체와 화합을 주제로 세가지 단과대가 모여서 진행하는 '세모톤'이라는 경희대학교에서 진행한 해커톤에서, 플러터를 사용하여 개발한 프로젝트입니다.
  2명의 다지이너, 1명의 BE, 1명의 AI, 3명의 FE, 총 7명이서 팀을 이루어 진행하였고, 프론트 엔드 파트를 담당했습니다. 
  [세모톤 공식 홈페이지](https://github.com/semothon)
## 프로젝트 목적 
 경희대학교 신입생 혹은 재학생들을 대상으로 하며, 익숙하지 않은 건물을 미연시 게임의 형태로 소개시켜주는 것이 주 목적입니다. 같은 장소에서 같은 경험을 하며 학생들은 공동체와 화합을 느낄 수 있습니다.

## 프로젝트 개요
1. 회원가입과 로그인을 합니다.
2. 랭킹을 확인 후 지도 맵으로 이동합니다.
3. 지도에서 자신의 근처에 있는 건물을 누릅니다.
4. 캐릭터를 선택합니다.
5. 선택한 캐릭터가 사진을 찍어오라는 미션을 내립니다.
6. 사진을 찍으면 Ai가 분석하여 점수를 알려줍니다.
7. 미션을 성공하면, 지도에서 그 건물은 클리어됩니다.

## 기여도
전체 UI 화면 개발
 2. 'a_l/' 폴더의 모든 코드 작성
 3. 'b_l/' 폴더의 첫 화면, 랭킹 페이지, 회원가입 코드 작성
 4. 반응형 UI 조정 및 버그 수정
-디자이너와 협업하며 컴포넌트 구조화

## 사용 기술 & 도구
 1. Flutter
 2. Dart 언어
 3. 안드로이드 스튜디오
- 협업 툴: GitHub, Figma, 카카오톡, Notion

## State Transition Diagram
![image](https://github.com/user-attachments/assets/9b461f12-7e70-4631-b978-40d8f49a9a0e)

## 결과물 스크린 샷
![image](https://github.com/user-attachments/assets/9b4e8f2d-1f63-4c62-9504-333d64432387)
![image](https://github.com/user-attachments/assets/25cf5dba-0729-4112-8be3-60ecc048cc18)
![image](https://github.com/user-attachments/assets/2365ce24-8aa2-49f2-83b7-c2bb85f87f4f)
![image](https://github.com/user-attachments/assets/e6df0981-56a9-4979-9bd7-a850a0d54c10)

## 수상
 -세모톤 2025 인기상 수상

 ## 개발 회고 및 학습 노트
[FE 개발 회고 노션 페이지 보기](https://www.notion.so/2025-03-17-04-06-FE-af0cacacb45a4e02a20431625aa83a4d?pvs=4)

## 🚀 Getting Started

이 프로젝트는 Flutter로 개발된 모바일 애플리케이션으로, UI 흐름 및 사용자 경험 중심으로 구성되어 있습니다.  
현재 저장소에는 프론트엔드 코드만 포함되어 있으며, 일부 기능은 백엔드 서버 및 Firebase 연동이 필요합니다.

### 프로젝트 클론 및 실행 방법

```bash
# 저장소 클론
git clone https://github.com/your-username/semoton_front.git
cd semoton_front

# 패키지 설치
flutter pub get

# 에뮬레이터 또는 기기에서 앱 실행
flutter run

# 주의 사항
로그인, 회원가입, 랭킹 확인, AI 점수 분석 등의 기능은 실제 백엔드 서버/API가 없으면 동작하지 않습니다.

본 저장소는 프론트엔드 파트만 포함되어 있으며, UI와 화면 이동 흐름 중심의 데모 테스트가 가능합니다.

