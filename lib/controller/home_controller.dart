import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/home_screen/map_page.dart';
import 'package:tez_front/controller/photo_controller.dart';
import 'package:tez_front/pages/home_screen/feed_page.dart';
import 'package:tez_front/widgets/result_mushroom.dart'; // Kamera kontrolcüsünün import edilmesi

class HomeController extends GetxController {
  final PhotoController _photoController = Get.put(PhotoController());

  final List<Widget> pages = [
    const Placeholder(), //öylesine
    const MapPage(),
    const Placeholder(),
    const FeedTab()
  ];

  void goToPage(int index) {
    if (index == 0) {
      _photoController.openCamera().then(
          (value) => Get.to(ResultMushroom(photoController: _photoController)));
    } else if (index == 2) {
      _photoController.pickImageGallery().then(
          (value) => Get.to(ResultMushroom(photoController: _photoController)));
    } else {
      Get.to(pages[index], transition: Transition.leftToRight);
    }
  }
}
