import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/controller/auth_snackbar_controller.dart';
import 'package:tez_front/controller/bottom_bar_controller.dart';
import 'package:tez_front/pages/navigation_tab/profile_tab.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_app_bar.dart';
import 'navigation_tab/home_tab.dart';
import 'share_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomBarController controller = Get.put(BottomBarController());
    final AuthController authController = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Obx(
          () {
            switch (controller.tabIndex.value) {
              case 0:
                return const HomeTab();
              case 1:
                return const UserTab();
              default:
                return const SizedBox();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 3,
          backgroundColor: ColorConstants.darkGreen,
          onPressed: () {
            if (authController.isGuest.value) {
              authController.snackBar();
            } else {
              Get.to(const ShareMushroom());
            }
          },
          child: const Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: const AnimatedBar(),
      ),
    );
  }
}
