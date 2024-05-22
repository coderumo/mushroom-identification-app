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
    return Container(
      padding: ProjectPaddings.cardInPadding,
      width: deviceWidth / 1.5,
      height: deviceHeight / 1.5,
      decoration: const LoginCard().decorationContainer(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Kullanıcı Adı *',
            ),
            onSaved: (String? value) {},
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'E-mail *',
            ),
            onSaved: (String? value) {},
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.password_outlined),
              labelText: 'Şifre *',
            ),
            onSaved: (String? value) {},
            validator: (String? value) {
              return (value != null) ? 'Please enter your password.' : null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.password_outlined),
              labelText: 'Şifre Tekrar *',
            ),
            onSaved: (String? value) {},
            validator: (String? value) {
              return (value != null) ? 'Please enter your password.' : null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              buttonText: 'Kayıt Ol',
              onPressed: () {
                Get.to(const LoginPage());
              })
        ],
      ),
    );
  }
}
