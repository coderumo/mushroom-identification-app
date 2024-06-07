import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/project_paddings.dart';
import '../widgets/custom_button.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
    const label = 'Kullanıcı Adı';
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
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: label,
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: labelMail,
            ),
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.password),
              labelText: labelPassword,
            ),
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.password),
              labelText: labelPasswordAgain,
            ),
            textInputAction: TextInputAction.next,
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
