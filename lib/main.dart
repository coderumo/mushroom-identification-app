import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/first_page.dart';

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
      theme: ThemeData.light(), // constantlar gelecek
      home: const FirstPage(),
    );
  }
}
