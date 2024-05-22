import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/first_page.dart';

import 'constants/color_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'İlk Sayfa',
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
      home: const FirstPage(),
    );
  }
}
