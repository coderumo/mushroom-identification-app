import 'package:flutter/material.dart';
import 'package:tez_front/widgets/register_card.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "./assets/images/mantar-bg.jpg",
            fit: BoxFit.cover,
            height: deviceHeight,
          ),
          const Center(child: RegisterCard()),
        ],
      ),
    );
  }
}
