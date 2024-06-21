import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/pages/first_page.dart';
import 'package:tez_front/pages/home_page.dart';
import 'constants/color_constant.dart';

Widget home = const FirstPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database().init();
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
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actionsIconTheme: IconThemeData(
            color: ColorConstants.darkGreen,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      home: home,
    );
  }
}
