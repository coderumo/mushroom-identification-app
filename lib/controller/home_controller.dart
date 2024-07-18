import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/home_screen/map_page.dart';
import 'package:tez_front/controller/photo_controller.dart';
import 'package:tez_front/pages/home_screen/feed_page.dart';
import 'package:tez_front/pages/home_screen/posts_map.dart';
import 'package:tez_front/pages/result_mushroom.dart';
import 'package:tez_front/services/auth_service.dart';
import 'package:tez_front/controller/db_manager.dart';

class HomeController extends GetxController {
  final PhotoController photoController = Get.put(PhotoController());
  var loading = false.obs;

  final List<Widget> pages = [
    const Placeholder(), //öylesine
    const PostMap(),
    const Placeholder(),
    const FeedList()
  ];

  void goToPage(int index) async {
    if (index == 0) {
      try {
        loading.value = true;
        final image = await photoController.openCamera();

        if (image == null) {
          loading.value = false;
          return;
        }
        AuthService authService = AuthService();
        final res = await authService.classifyImage(image);
        loading.value = false;

        Get.to(ResultMushroom(
          bodyText: res['chatgpt_data'],
          title: res['true_labels'],
          subTitle: res['canEat'] ? 'Yenebilir' : 'Yenmesi Tavsiye Edilmez',
          image: image,
        ));
      } catch (e) {
        print('$e');
      }
    } else if (index == 2) {
      loading.value = true;
      final image = await photoController.pickImageGallery();
      if (image == null) {
        loading.value = false;
        return;
      }
      AuthService authService = AuthService();
      final res = await authService.classifyImage(image);
      loading.value = false;
      Get.to(ResultMushroom(
        bodyText: res['chatgpt_data'],
        title: res['true_labels'],
        subTitle: res['canEat'] ? 'Yenebilir' : 'Yenmesi Tavsiye Edilmez',
        image: image,
      ));
    } else if (index == 3 && Database.instance.isGuest()) {
      Get.snackbar(
        'Erişim Engellendi',
        'Giriş yapmanız gerekmektedir',
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.to(pages[index], transition: Transition.leftToRight);
    }
  }
}
