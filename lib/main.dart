import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/pages/first_page.dart';
import 'package:tez_front/pages/home_page.dart';
import 'package:tez_front/theme.dart';
import 'package:tez_front/utils/firebase_manager.dart';

Widget home = const FirstPage();
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database().init();
  await NotificationsManager().init();
  if (Database().isLogged()) {
    home = const HomePage();
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = "Mushroom App";
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: AppTheme.lightTheme,
      home: home,
    );
  }
}
