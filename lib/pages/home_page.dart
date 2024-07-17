import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/controller/bottom_bar_controller.dart';
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/pages/first_page.dart';
import 'package:tez_front/pages/navigation_tab/home_tab.dart';
import 'package:tez_front/pages/navigation_tab/profile_tab.dart';
import 'package:tez_front/pages/share_page.dart';
import 'package:tez_front/widgets/custom_button.dart';
import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomBarController controller = Get.put(BottomBarController());

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Obx(
          () {
            switch (controller.tabIndex.value) {
              case 0:
                return const HomeTab();
              case 1:
                return deneme();
              default:
                return const SizedBox();
            }
          },
        ),
        floatingActionButton: Obx(
          () {
            if (controller.tabIndex.value == 1) {
              return const SizedBox.shrink();
            }
            return FloatingActionButton(
              elevation: 3,
              backgroundColor: ColorConstants.darkGreen,
              onPressed: () async {
                if (Database.instance.isGuest()) {
                  print(Database.instance.isGuest());
                  Get.snackbar(
                    'Erişim Engellendi',
                    'Giriş yapmanız gerekmektedir',
                    snackPosition: SnackPosition.TOP,
                  );
                } else {
                  Get.to(const SharePage());
                }
              },
              child: const Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: const AnimatedBar(),
      ),
    );
  }

  Widget deneme() {
    if (Database.instance.isGuest()) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bu sayfayı kullanabilmek için giriş yapmanız gerekmektedir.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.darkGreen),
                child: const Text(
                  'Giriş Yap/Kayıt oL',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Get.offAll(const FirstPage());
                }),
          ],
        ),
      );
    } else {
      return const ProfileTab();
    }
  }
}
