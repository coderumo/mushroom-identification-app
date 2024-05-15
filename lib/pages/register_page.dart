import 'package:flutter/material.dart';
import 'package:tez_front/widgets/register_card.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          "./assets/images/mantar-bg.jpg",
          fit: BoxFit.cover,
          height: deviceHeight,
          width: deviceWidth,
        ),
        ListView(children: const [
          Column(
            children: <Widget>[
              SizedBox(
                height: 240,
              ),
              RegisterCard()
            ],
          ),
        ]),
      ]),
    );
  }
}
