import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/auth_controller.dart';
import 'package:tez_front/pages/home_page.dart';
import 'package:tez_front/pages/register_page.dart';
import 'package:tez_front/widgets/box_decoration.dart';
import 'package:tez_front/widgets/custom_text_button.dart';
import 'package:tez_front/constants/padding_constant.dart';
import '../controller/db_manager.dart';
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

    AuthController authController = Get.put(AuthController());

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
                decoration: decorationContainer(),
                padding: ProjectPaddings.cardInPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: ProjectPaddings.paddingAll,
                      child: Image.asset(
                        logo,
                        height: 50,
                      ),
                    ),
                    CustomButton(
                        buttonText: buttonText,
                        onPressed: () {
                          Get.to(
                            LoginPage(),
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
                    CustomTextButton(
                      text: textButton,
                      onPressed: () async {
                        await Database.instance.continueAsGuest();
                        Get.to(const HomePage());
                      },
                    ),
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
