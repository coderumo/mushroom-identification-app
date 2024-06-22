import 'package:flutter/material.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/constants/padding_constant.dart';

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
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 130, height: 40),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.darkGreen,
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
