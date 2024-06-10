import 'package:flutter/material.dart';
import '../constants/color_constant.dart';

BoxDecoration decorationContainer() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        color: ColorConstants.grey,
        spreadRadius: 3,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  );
}
