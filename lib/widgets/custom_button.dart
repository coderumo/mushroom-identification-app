import 'package:flutter/material.dart';
import 'package:tez_front/constants/color_constant.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll<Color>(ColorConstants.darkGreen),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
