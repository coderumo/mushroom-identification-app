import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/bottom_bar_controller.dart';
import 'package:tez_front/constants/color_constant.dart';

class AnimatedBar extends StatefulWidget {
  const AnimatedBar({Key? key}) : super(key: key);

  @override
  State<AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar> {
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    BottomBarController controller = Get.find();
    return CurvedNavigationBar(
      color: ColorConstants.darkGreen,
      index: controller.tabIndex.value,
      backgroundColor: color,
      items: [
        CurvedNavigationBarItem(
          labelStyle: TextStyle(color: color),
          child: Icon(
            Icons.home_sharp,
            color: color,
          ),
          label: 'Home',
        ),
        CurvedNavigationBarItem(
          labelStyle: TextStyle(color: color),
          child: Icon(
            Icons.newspaper,
            color: color,
          ),
          label: 'Feed',
        ),
        CurvedNavigationBarItem(
          labelStyle: TextStyle(color: color),
          child: Icon(
            Icons.perm_identity,
            color: color,
          ),
          label: 'Personal',
        ),
      ],
      onTap: (index) {
        controller.tabIndex.value = index;
      },
    );
  }
}
