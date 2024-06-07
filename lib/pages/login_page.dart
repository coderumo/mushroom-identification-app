import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/home_page.dart';
import '../constants/color_constant.dart';
import '../constants/project_paddings.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;

    const backgroundImage = './assets/images/mantar-bg.jpg';
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;

    const labelText = 'E - Mail';
    const labelTextPassword = 'Password';
    const buttonText = 'Giriş';
    const text = 'Şifremi Unuttum..';

    return Padding(
      padding: ProjectPaddings.cardOutPadding,
      child: Container(
        padding: ProjectPaddings.cardInPadding,
        width: deviceWidth / 1.5,
        height: deviceHeight / 2,
        decoration: decorationContainer(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: labelText,
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password),
                labelText: labelTextPassword,
              ),
              textInputAction: TextInputAction.next,
            ),
            CustomButton(
              buttonText: buttonText,
              onPressed: () {
                Get.to(const HomePage());
              },
            ),
            CustomTextButton(
              text: text,
              onPressed: () {
                Get.to(const HomePage());
              },
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration decorationContainer() => BoxDecoration(
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
