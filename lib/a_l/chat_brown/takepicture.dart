//chatbox4에서 사진 찍는다 누르면, 사진 찍으러 이동하는 화면 5페이지
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:semoton_front/a_l/chat_brown/picture_analyze.dart';
// 카메라 화면으로 이동하는 위젯
class TakePictureScreen extends StatefulWidget {
  final String missionTitle;
  final CameraDescription camera;

  const TakePictureScreen(this.missionTitle, this.camera,  {super.key});

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
                builder: (context) => DisplayPictureScreen(widget.missionTitle,image.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt,size: 40,),
      ),
    );
  }
}

// 촬영한 사진을 보여주는 화면
class DisplayPictureScreen extends StatelessWidget {
  final String missionTitle;
  final String imagePath;

  const DisplayPictureScreen(this.missionTitle, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('촬영된 사진')),
      body: Center(child: Image.file(File(imagePath))),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: (){ Navigator.pop(context);}, child: Text('다시 찍으러 가기'),),
              SizedBox(width: 10,),
              ElevatedButton(
                  child: Text(
                    '사진 분석하러 가기',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  PictureAnalyze(missionTitle, imagePath),
                    ),
                  );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
