import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:semoton_front/a_l/chat_yellow/picture_analyze.dart';
import '../../network/api_service.dart';

// 카메라 화면으로 이동하는 위젯
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final String missionTitle;
  const TakePictureScreen(this.missionTitle, {super.key, required this.camera});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('사진 촬영')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if (!context.mounted) return;

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(widget.missionTitle, imageFile: File(image.path)),
              ),
            );
          } catch (e) {
            print('❌ 촬영 중 오류: $e');
          }
        },
        child: const Icon(Icons.camera_alt, size: 40),
      ),
    );
  }
}

// 촬영한 사진을 보여주는 화면
class DisplayPictureScreen extends StatelessWidget {
  final File imageFile;
  final ApiService apiService = ApiService(); // 인스턴스 생성

  final String missionTitle;
  DisplayPictureScreen(this.missionTitle, {super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('촬영된 사진')),
      body: Center(child: Image.file(imageFile)),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('다시 찍으러 가기'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final result = await apiService.uploadImage(imageFile);
                    final uploadedUrl = result['uploadedUrl'];
                    print('✅ 업로드 성공: $uploadedUrl');

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PictureAnalyze(missionTitle, uploadedUrl), // 필요 시 uploadedUrl 넘겨주기
                      ),
                    );
                  } catch (e) {
                    print('❌ 업로드 실패: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('이미지 업로드에 실패했습니다')),
                    );
                  }
                },
                child: const Text(
                  '사진 분석하러 가기',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
