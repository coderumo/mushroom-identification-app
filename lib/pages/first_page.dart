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

  final backgroundImage = './assets/images/mantar-bg.jpg';
  final logo = 'assets/images/logo-g.png';

  @override
  Widget build(BuildContext context) {
    const buttonText = 'Giriş Yap';
    const buttonText2 = 'Kayıt Ol';
    const textButton = 'Kayıt Olmadan Devam Et';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
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
                    CustomButton(
                        buttonText: buttonText,
                        onPressed: () {
                          Get.to(
                            const LoginPage(),
                          );
                        }),
                    CustomButton(
                      buttonText: buttonText2,
                      onPressed: () {
                        Get.to(
                          const RegisterPage(),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      child: const Text(
                        textButton,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Get.to(
                          const HomePage(),
                        );
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
