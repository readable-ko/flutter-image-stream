import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;


class ScanController extends GetxController {

  late List<CameraDescription> _cameras;
  late CameraController _cameraController;
  final RxBool _isInitialized = RxBool(false);
  CameraImage? _cameraImage;


  CameraController get cameraController => _cameraController;
  bool get isInitialized => _isInitialized.value;


  @override
  void dispose() {
    _isInitialized.value = false;
    _cameraController.dispose();
    super.dispose();
  }


  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.low,
        imageFormatGroup: ImageFormatGroup.bgra8888);
    _cameraController.initialize().then((_) {
      _isInitialized.value = true;
      //30 FPS print(DateTime.now().microsecondsSinceEpoch)
      _cameraController.startImageStream((image) => _cameraImage = image);
      _isInitialized.refresh();
    })
        .catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void onInit() {
    initCamera();
    super.onInit();
  }


  void capture() {
      img.Image image = img.Image.fromBytes(
          _cameraImage!.width, _cameraImage!.height,
          _cameraImage!.planes[0].bytes, format: img.Format.bgra);
      Uint8List jpeg = Uint8List.fromList(img.encodeJpg(image));
      print(jpeg.length);
      print("Image Captured");
  }
}


