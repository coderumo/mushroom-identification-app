import 'package:flutter/material.dart';

import '../widgets/login_card.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;

    const backgroundImage = './assets/images/mantar-bg.jpg';
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          backgroundImage,
          fit: BoxFit.cover,
          height: deviceHeight,
          width: deviceWidth,
        ),
        ListView(
          children: const [
            Center(
              child: LoginCard(),
            ),
          ],
        ),
      ]),
    );
  }
}
