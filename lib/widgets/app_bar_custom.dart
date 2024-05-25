import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/project_paddings.dart';
import 'package:tez_front/constants/sized_box_constant.dart';
import 'package:tez_front/pages/first_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String projectLogo = 'assets/images/logo-g.png';
    const double logoSize = 40;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Expanded(
            child: Image.asset(
          projectLogo,
          height: logoSize,
        )),
        actions: [
          _AppBarIconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              _showNotification(context);
            },
          ),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _showNotification(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: ProjectPaddings.paddingAll,
            child: SizedBox(
              width: SizedBoxConstant.width,
              height: SizedBoxConstant.heigth,
              child: ListView(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: ProjectPaddings.paddingAll,
                        child: Text(
                          '@sadfndfk Fotoğrafını beğendi',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  const _AppBarIconButton({
    required this.icon,
    required this.onPressed,
  });

  final Icon icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
    );
  }
}
