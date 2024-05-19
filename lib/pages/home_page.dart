import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/bottom_bar_controller.dart';
import 'package:tez_front/pages/navigation_tab/share_page.dart';
import 'package:tez_front/pages/navigation_tab/user_tab.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/app_bar_custom.dart';
import 'navigation_tab/home_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomBarController controller = Get.put(BottomBarController());
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Obx(() {
          switch (controller.tabIndex.value) {
            case 0:
              return const HomeTab();
            case 1:
              return ShareMushroom();
            case 2:
              return const UserTab();
            default:
              return const SizedBox();
          }
        }),
        bottomNavigationBar: const AnimatedBar(),
      ),
    );
  }
}
