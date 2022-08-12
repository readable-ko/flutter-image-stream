import 'package:flutter/material.dart';
import 'package:flutter_camera/camera_viewer.dart';



class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CameraViewer(),
      ],
    );
  }
}
