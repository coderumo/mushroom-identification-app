import 'package:flutter/material.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/pages/login_page.dart';
import 'package:tez_front/widgets/custom_button.dart';

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
      padding: _customPadding(),
      width: deviceWidth,
      height: deviceHeight / 1.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0), // Kenar yuvarlama ekleniyor
        boxShadow: [
          BoxShadow(
            color: ColorConstants.grey.withOpacity(0.5), // Gölge rengi
            spreadRadius: 3, // Gölgenin yayılma alanı
            blurRadius: 5, // Gölgelendirme miktarı
            offset: const Offset(0, 3), // Gölgenin konumu
          ),
        ],
      ),
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
          const CustomButton(buttonText: 'Kayıt Ol', nextPage: LoginPage())
        ],
      ),
    );
  }

  EdgeInsets _customPadding() => const EdgeInsets.only(left: 50, right: 50);
}
