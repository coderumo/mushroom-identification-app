import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/project_paddings.dart';
import 'package:tez_front/pages/login_page.dart';
import '../controller/home_controller.dart';

class CustomHomeIconButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final int pageIndex;

  const CustomHomeIconButton({
    Key? key,
    required this.label,
    required this.iconPath,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double iconSize = 50;

    final HomeController controller = Get.put(HomeController());
    return GestureDetector(
      onTap: () {
        controller.goToPage(pageIndex);
      },
      child: Padding(
        padding: ProjectPaddings.paddingAll,
        child: Container(
          decoration: const LoginCard().decorationContainer(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: ProjectPaddings.paddingAll,
                child: SvgPicture.asset(
                  iconPath,
                  width: iconSize,
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
