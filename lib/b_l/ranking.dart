import 'package:flutter/material.dart';
import '../network/api_service.dart';
import 'package:semoton_front/a_l/mission_map.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();

}

class _RankingState extends State<Ranking> {
  final ApiService apiService = ApiService(); // API 서비스 인스턴스
  List<dynamic> rankingData = [];
  String myNickName = '';
  double myTotalScore = 0;
  int currentUserId = 1; // 현재 로그인한 사용자 ID (예시)
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRankingData();
  }

  Future<void> _fetchRankingData() async {
    try {
      final response = await apiService.getRankings();
      setState(() {
        rankingData = response['rankings'];
        myNickName = response['myNickName'];
        myTotalScore = response['myTotalScore'].toDouble();
        isLoading = false;
      });
    } catch (e) {
      print('랭킹 데이터를 불러오는 데 실패했습니다: $e');
    }
  }

  String _getGrade(double score) {
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

  @override
  Widget build(BuildContext context) {
    String myGrade = _getGrade(myTotalScore);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink.shade200,
        elevation: 0,
        title: Row(
          children: [
            const SizedBox(width: 13),
            CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Text(
              myNickName,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            margin: const EdgeInsets.only(right: 25),
            decoration: BoxDecoration(
              color: const Color(0x4DFFFFFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "$myTotalScore ",
                    style: const TextStyle(
                        color: Color(0xff502929), fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "점 ($myGrade)",
                    style: const TextStyle(
                        color: Color(0xff9B4A4A), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Colors.pink.shade200, Colors.yellow.shade50],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildTopThree(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: rankingData.length - 3,
                itemBuilder: (context, index) {
                  return _buildRankingTile(index + 4);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.location_pin, color: Color(0xffED8E97), size: 35),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MissionMapScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopThree() {
    if (rankingData.length < 3) return Container();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildTopCard(rankingData[1], 2, height: 200),
          _buildTopCard(rankingData[0], 1, height: 220, isCenter: true),
          _buildTopCard(rankingData[2], 3, height: 200),
        ],
      ),
    );
  }

  Widget _buildTopCard(Map<String, dynamic> user, int rank,
      {double height = 160, bool isCenter = false}) {
    String grade = _getGrade(user['totalScore'].toDouble());
    return Container(
      width: isCenter ? 130 : 110,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            rank.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff9B4A4A)),
          ),
          const SizedBox(height: 5),
          CircleAvatar(
            radius: isCenter ? 30 : 25,
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.person, size: isCenter ? 45 : 30, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Container(
            width: 82,
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                user["nickname"],
                style: const TextStyle(color: Color(0xff502929), fontWeight: FontWeight.w900, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 80,
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.pink.shade100, width: 2),
              color: const Color(0xffED8E97),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                '${user["totalScore"]} ($grade)',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildRankingTile(int rank) {
    if (rank - 1 >= rankingData.length) return const SizedBox.shrink();

    final user = rankingData[rank - 1];
    double score = user["totalScore"].toDouble();
    String grade = _getGrade(score);

    return Card(
      color: const Color(0xFFFFF5F5),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 11.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 3,
      child: ListTile(
        leading: Text(
          rank.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xff9B4A4A)),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, size: 25, color: Colors.grey),
            ),
            const SizedBox(width: 9),
            Container(
              width: 111,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  user["nickname"],
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xff9B4A4A)),
                ),
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink.shade100, width: 2),
            color: const Color(0xffED8E97),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              '$score ($grade)',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}

// class Ranking extends StatefulWidget {
//   const Ranking({super.key});
//
//   @override
//   State<Ranking> createState() => _RankingState();
//
// }
//
// class _RankingState extends State<Ranking> {
//   final ApiService apiService = ApiService(); // API 서비스 인스턴스
//   List<dynamic> rankingData = [];
//   String myNickName = '';
//   double myTotalScore = 0;
//   int currentUserId = 1; // 현재 로그인한 사용자 ID (예시)
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchRankingData();
//   }
//
//   Future<void> _fetchRankingData() async {
//     try {
//       final response = await apiService.getRankings();
//       setState(() {
//         rankingData = response['rankings'];
//         myNickName = response['myNickName'];
//         myTotalScore = response['myTotalScore'].toDouble();
//         isLoading = false;
//       });
//     } catch (e) {
//       print('랭킹 데이터를 불러오는 데 실패했습니다: $e');
//     }
//   }
//
//   String _getGrade(double score) {
//     if (score >= 90) return 'A+';
//     if (score >= 85) return 'A';
//     if (score >= 80) return 'A-';
//     if (score >= 75) return 'B+';
//     if (score >= 70) return 'B';
//     if (score >= 65) return 'B-';
//     if (score >= 60) return 'C+';
//     if (score >= 55) return 'C';
//     if (score >= 50) return 'C-';
//     if (score >= 45) return 'D+';
//     if (score >= 40) return 'D';
//     if (score >= 35) return 'D-';
//     return 'F';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String myGrade = _getGrade(myTotalScore);
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.pink.shade200,
//         elevation: 0,
//         title: Row(
//           children: [
//             const SizedBox(width: 13),
//             CircleAvatar(
//               backgroundColor: Colors.grey.shade400,
//               child: const Icon(Icons.person, color: Colors.white),
//             ),
//             const SizedBox(width: 10),
//             Text(
//               myNickName,
//               style: const TextStyle(
//                   color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         actions: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//             margin: const EdgeInsets.only(right: 25),
//             decoration: BoxDecoration(
//               color: const Color(0x4DFFFFFF),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(
//                     text: "$myTotalScore ",
//                     style: const TextStyle(
//                         color: Color(0xff502929), fontWeight: FontWeight.bold),
//                   ),
//                   TextSpan(
//                     text: "점 ($myGrade)",
//                     style: const TextStyle(
//                         color: Color(0xff9B4A4A), fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.center,
//             colors: [Colors.pink.shade200, Colors.yellow.shade50],
//           ),
//         ),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             _buildTopThree(),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: rankingData.length - 3,
//                 itemBuilder: (context, index) {
//                   return _buildRankingTile(index + 4);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius:
//           BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
//           boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.location_pin, color: Color(0xffED8E97), size: 35),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => MissionMapScreen()),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTopThree() {
//     if (rankingData.length < 3) return Container();
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           _buildTopCard(rankingData[1], 2, height: 160),
//           _buildTopCard(rankingData[0], 1, height: 180, isCenter: true),
//           _buildTopCard(rankingData[2], 3, height: 160),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTopCard(Map<String, dynamic> user, int rank,
//       {double height = 160, bool isCenter = false}) {
//     String grade = _getGrade(user['totalScore'].toDouble());
//     return Container(
//       width: isCenter ? 130 : 110,
//       height: height,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2)],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             rank.toString(),
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff9B4A4A)),
//           ),
//           const SizedBox(height: 5),
//           CircleAvatar(
//             radius: isCenter ? 30 : 25,
//             backgroundColor: Colors.grey[200],
//             child: Icon(Icons.person, size: isCenter ? 45 : 30, color: Colors.grey),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             width: 82,
//             decoration: BoxDecoration(
//               color: Colors.pink.shade50,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Center(
//               child: Text(
//                 user["nickname"],
//                 style: const TextStyle(color: Color(0xff502929), fontWeight: FontWeight.w900, fontSize: 14),
//               ),
//             ),
//           ),
//           const SizedBox(height: 4),
//           Container(
//             width: 80,
//             margin: const EdgeInsets.only(top: 5),
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.pink.shade100, width: 2),
//               color: const Color(0xffED8E97),
//               borderRadius: BorderRadius.circular(25),
//             ),
//             child: Center(
//               child: Text(
//                 '${user["totalScore"]} ($grade)',
//                 style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//
//   Widget _buildRankingTile(int rank) {
//     if (rank - 1 >= rankingData.length) return const SizedBox.shrink();
//
//     final user = rankingData[rank - 1];
//     double score = user["totalScore"].toDouble();
//     String grade = _getGrade(score);
//
//     return Card(
//       color: const Color(0xFFFFF5F5),
//       margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 11.5),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//       elevation: 3,
//       child: ListTile(
//         leading: Text(
//           rank.toString(),
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xff9B4A4A)),
//         ),
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.grey[200],
//               child: const Icon(Icons.person, size: 25, color: Colors.grey),
//             ),
//             const SizedBox(width: 9),
//             Container(
//               width: 111,
//               height: 25,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: Center(
//                 child: Text(
//                   user["nickname"],
//                   style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xff9B4A4A)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         trailing: Container(
//           width: 80,
//           height: 30,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.pink.shade100, width: 2),
//             color: const Color(0xffED8E97),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           child: Center(
//             child: Text(
//               '$score ($grade)',
//               style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }