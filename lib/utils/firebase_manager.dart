import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/services/auth_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print('notification action tapped with input: ${notificationResponse.input}');
  }
}

class NotificationsManager {
  static final NotificationsManager _instance = NotificationsManager._internal();
  NotificationsManager._internal();
  factory NotificationsManager() => _instance;
  late final NotificationSettings _notificationSettings;
  late final String? token;
  AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

  Future<void> init() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.requestPermission(provisional: true);
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');
    if (Database().tokenBox.get('token') != null) {
      final AuthService _authService = AuthService();
      await _authService.updateToken();
    }
    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(android: initializationSettingsAndroid),
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            break;
          case NotificationResponseType.selectedNotificationAction:
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification}');

      final String type = (message.data['type'] as String?) ?? '';
      final title = message.notification?.title ?? '';
      final body = message.notification?.body;
      final details = AndroidNotificationDetails(
        type,
        title,
        importance: Importance.max,
        priority: Priority.high,
      );
      final platformChannelSpecifics = NotificationDetails(android: details);
      FlutterLocalNotificationsPlugin().show(0, title, body, platformChannelSpecifics);
    });
  }
}
