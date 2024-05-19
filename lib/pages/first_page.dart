import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/home_page.dart';
import 'package:tez_front/pages/register_page.dart';
import 'package:tez_front/widgets/login_card.dart';
import 'package:tez_front/constants/project_paddings.dart';
import '../widgets/custom_button.dart';
import 'login_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  final backgrounImage = './assets/images/mantar-bg.jpg';
  final logo = 'assets/images/logo-g.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgrounImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: ProjectPaddings.cardOutPadding,
              child: Container(
                decoration: const LoginCard().decorationContainer(),
                padding: ProjectPaddings.cardInPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      logo,
                      height: 50,
                    ),
                    const SizedBox(height: 50),
                    const CustomButton(
                        buttonText: 'Giriş Yap', nextPage: LoginPage()),
                    const CustomButton(
                      buttonText: 'Kayıt Ol',
                      nextPage: RegisterPage(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      child: const Text(
                        "Kayıt Olmadan Devam Et",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Get.to(const HomePage());
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
