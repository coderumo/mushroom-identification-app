import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tez_front/constants/color_constant.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: "Roboto Condensed",
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actionsIconTheme: IconThemeData(
        color: ColorConstants.darkGreen,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
  );
}
// var theme = ThemeData.light().copyWith(
//   appBarTheme: const AppBarTheme(
//     systemOverlayStyle: SystemUiOverlayStyle.dark,
//     actionsIconTheme: IconThemeData(
//       color: ColorConstants.darkGreen,
//     ),
//     elevation: 0,
//     backgroundColor: Colors.transparent,
//   ),
// );