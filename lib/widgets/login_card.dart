import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/home_page.dart';
import 'package:tez_front/widgets/custom_button.dart';
import 'package:tez_front/constants/project_paddings.dart';

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
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: labelText,
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
            ),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                labelText: labelTextPassword,
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              buttonText: buttonText,
              onPressed: () {
                Get.to(const HomePage());
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                  text),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration decorationContainer() => BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      );
}
