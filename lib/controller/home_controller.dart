import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/home_screen/map_page.dart';
import 'package:tez_front/controller/photo_controller.dart';
import 'package:tez_front/pages/home_screen/feed_page.dart';
import 'package:tez_front/pages/result_mushroom.dart';

class HomeController extends GetxController {
  final PhotoController photoController = Get.put(PhotoController());

  final List<Widget> pages = [
    const Placeholder(), //öylesine
    const MapPage(),
    const Placeholder(),
    const FeedTab()
  ];

  void goToPage(int index) {
    if (index == 0) {
      try {
        photoController
            .openCamera()
            .then((value) => Get.to(const ResultMushroom(
                // photoController: _photoController
                )));
      } catch (e) {
        print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      }
    } else if (index == 2) {
      photoController
          .pickImageGallery()
          .then((value) => Get.to(const ResultMushroom(
              //photoController: _photoController
              )));
    } else {
      Get.to(pages[index], transition: Transition.leftToRight);
    }
  }
}
