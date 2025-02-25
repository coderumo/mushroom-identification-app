import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/home_controller.dart';
import '../../constants/color_constant.dart';
import '../../widgets/custom_card_home_page.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        AbsorbPointer(
          absorbing: homeController.loading.value,
          child: Center(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.only(top: 100),
                mainAxisSpacing: 50,
                crossAxisSpacing: 20,
                children: const [
                  CustomHomeIconButton(
                    label: 'Hızlı Tarama',
                    iconPath: 'assets/svg/camera.svg',
                    pageIndex: 0,
                  ),
                  CustomHomeIconButton(
                    label: 'Haritada Göster',
                    iconPath: 'assets/svg/map.svg',
                    pageIndex: 1,
                  ),
                  CustomHomeIconButton(
                    label: 'Galeriden Seç',
                    iconPath: 'assets/svg/gallery.svg',
                    pageIndex: 2,
                  ),
                  CustomHomeIconButton(
                    label: 'Mantar Keşfet',
                    iconPath: 'assets/svg/mushroom.svg',
                    pageIndex: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          if (homeController.loading.value) {
            return Center(
              child: Column(
                children: [
                  const SpinKitFadingCircle(
                    color: ColorConstants.darkGreen,
                    size: 50.0,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    homeController.state.value,
                    style: const TextStyle(
                      color: ColorConstants.darkGreen,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
      ],
    );
  }
}
