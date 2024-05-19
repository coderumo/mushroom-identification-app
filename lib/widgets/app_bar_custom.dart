import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/pages/first_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Expanded(
            child: Image.asset(
          'assets/images/logo-g.png',
          height: 40,
        )),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: ColorConstants.darkGreen,
              )),
          IconButton(
              onPressed: () {
                Get.off(const FirstPage());
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
