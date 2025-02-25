import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/first_page.dart';
import '../controller/db_manager.dart';
import '../pages/notification_dialog.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
  });
  String projectLogo = 'assets/images/logo-g.png';
  String noNotification = 'assets/images/no-spam.png';

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;

    double logoSize = deviceHeight / 24;

    final List<String> notifications = [];
    const String notificationMessage = 'Bildirim yok';
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          projectLogo,
          height: logoSize,
        ),
        actions: [
          _AppBarIconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              _showNotificationDialog(
                context,
                notifications,
                noNotification,
                notificationMessage,
              );
            },
          ),
          IconButton(
            onPressed: () {
              Database.instance.logout();
              Get.offAll(const FirstPage());
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _showNotificationDialog(BuildContext context, List<String>? notifications, String noNotification, String notificationMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NotificationDialog(
          notifications: notifications,
          noNotificationImage: noNotification,
          notificationMessage: notificationMessage,
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

class NotificationModel {
  List<String>? notifications;
}
