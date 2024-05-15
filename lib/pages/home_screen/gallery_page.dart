import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/camera_controller.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraController>(
      init: CameraController(),
      builder: (controller) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Galeri otomatik olarak açılıyor
          controller.pickImageGallery();
          Get.back();
        });

        return Scaffold(
          body: Obx(
            () {
              print("Image value: ${controller.image.value}");
              return ListView(children: const [
                SizedBox(height: 50),
              ]);
            },
          ),
        );
      },
    );
  }
}
