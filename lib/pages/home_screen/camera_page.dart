import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/camera_controller.dart';

class CameraPage extends StatelessWidget {
  final CameraController _cameraController = Get.put(CameraController());

  CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _cameraController.image.value == null
                  ? const Text('No image selected')
                  : Image.file(_cameraController.image.value!),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _cameraController.saveAndShareImage,
                    child: const Text('Save & Share'),
                  ),
                  ElevatedButton(
                    onPressed: _cameraController.saveImage,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
