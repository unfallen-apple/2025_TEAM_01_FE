// import 'package:flutter/material.dart';
// import 'mission_map.dart'; // 만든 지도 파일을 import
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: '경희대학교 지도',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: KyungheeMapScreen(),
//     );
//   }
// }
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   void _refreshMap() {
//     setState(() {
//       // 지도 데이터를 다시 불러오는 로직 (필요에 따라 변경)
//       print("🔄 지도 새로고침!");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("경희대 지도")),
//       body: Center(child: Text("지도 위젯 여기에 추가")),
//       floatingActionButton: RefreshButton(onRefresh: _refreshMap),
//     );
//   }
// }