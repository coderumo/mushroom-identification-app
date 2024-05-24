import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/pages/login_page.dart';
import 'package:tez_front/widgets/custom_button.dart';
import 'package:tez_front/widgets/login_card.dart';

import '../constants/project_paddings.dart';

class RegisterCard extends StatelessWidget {
  const RegisterCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;

    const buttonText = 'Kayıt Ol';
    const label = 'kullanıcı Adı';
    const labelMail = 'E-Mail';
    const labelPassword = 'Şifre';
    const labelPasswordAgain = 'Şifre Tekrar';

    return Container(
      padding: ProjectPaddings.cardInPadding,
      width: deviceWidth / 1.5,
      height: deviceHeight / 1.75,
      decoration: const LoginCard().decorationContainer(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: label,
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: labelMail,
            ),
            textInputAction: TextInputAction.next,
            autofillHints: [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
          ),
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.password),
              labelText: labelPassword,
            ),
            textInputAction: TextInputAction.next,
          ),
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.password),
              labelText: labelPasswordAgain,
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            buttonText: buttonText,
            onPressed: () {
              Get.to(
                const LoginPage(),
              );
            },
          )
        ],
      ),
    );
  }
}
