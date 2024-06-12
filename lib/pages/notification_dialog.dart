import 'package:flutter/material.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/constants/padding_constant.dart';
import 'package:tez_front/constants/sized_box_constant.dart';

class NotificationDialog extends StatelessWidget {
  final List<String>? notifications;
  final String noNotificationImage;
  final String notificationMessage;

  const NotificationDialog({
    Key? key,
    required this.notifications,
    required this.noNotificationImage,
    required this.notificationMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: ProjectPaddings.paddingAll,
        child: _DialogView(
          notifications: notifications,
          notificationMessage: notificationMessage,
          noNotificationImage: noNotificationImage,
        ),
      ),
    );
  }
}

class _DialogView extends StatelessWidget {
  const _DialogView({
    super.key,
    required this.notifications,
    required this.notificationMessage,
    required this.noNotificationImage,
  });

  final List<String>? notifications;
  final String notificationMessage;
  final String noNotificationImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizedBoxConstant.width,
      height: SizedBoxConstant.heigth,
      child: notifications == null || notifications!.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(notificationMessage, style: CustomTextStyle.style),
                Image.asset(
                  noNotificationImage,
                  height: 80,
                ),
              ],
            )
          : ListView.builder(
              itemCount: notifications!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: ProjectPaddings.paddingAll,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    notifications![index],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
            ),
    );
  }
}

class CustomTextStyle {
  static const TextStyle style = TextStyle(
      fontSize: 24,
      color: ColorConstants.darkGreen,
      fontWeight: FontWeight.bold,
      letterSpacing: 6);
}
