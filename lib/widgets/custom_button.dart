import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/color_constant.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Widget nextPage;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll<Color>(ColorConstants.darkGreen),
        ),
        onPressed: () {
          Get.to(nextPage);
        },
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.black),
        ));
  }
}
