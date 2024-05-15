import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tez_front/widgets/login_card.dart';
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
    final HomeController controller = Get.put(HomeController());
    return GestureDetector(
      onTap: () {
        controller.goToPage(pageIndex);
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: const LoginCard().decorationContainer(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
