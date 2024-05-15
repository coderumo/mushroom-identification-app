import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/home_screen/camera_page.dart';
import 'package:tez_front/pages/home_screen/feed_page.dart';
import 'package:tez_front/pages/home_screen/map_page.dart';
import 'package:tez_front/pages/home_screen/gallery_page.dart';
import 'package:tez_front/controller/camera_controller.dart'; // Kamera kontrolcüsünün import edilmesi

class HomeController extends GetxController {
  final List<Widget> pages = [
    CameraPage(),
    const MapPage(),
    const GalleryPage(),
    FeedPage()
  ];

  final CameraController _cameraController = Get.put(CameraController());

  void goToPage(int index) {
    if (index == 0) {
      _cameraController.openCamera();
    }
    Get.to(pages[index], transition: Transition.leftToRight);
  }
}
