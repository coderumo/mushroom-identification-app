import 'package:flutter/material.dart';
import 'package:tez_front/constants/project_paddings.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectPaddings.buttonOutPadding,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
            text),
      ),
    );
  }
}
