import 'package:flutter/material.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/constants/project_paddings.dart';

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
    return Padding(
      padding: ProjectPaddings.buttonOutPadding,
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll<Color>(ColorConstants.darkGreen),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
