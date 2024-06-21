import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/background_image.dart';
import 'package:tez_front/controller/auth_controller.dart';
import 'package:tez_front/pages/forget_password.dart';
import 'package:tez_front/pages/home_page.dart'; // Assuming your HomePage is imported here
import '../constants/padding_constant.dart';
import '../widgets/box_decoration.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_button.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    const labelText = 'E-Mail';
    const labelTextPassword = 'Password';
    const buttonText = 'Giriş';
    const text = 'Şifremi Unuttum..';
    const email = 'E-mail gerekli';
    const errorEmail = 'Hatalı E-mail';
    const password = 'Şifre Gerekli';

    BackgroundImage image = BackgroundImage();

    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            image.backgroundImage,
            fit: BoxFit.cover,
            height: deviceHeight,
            width: deviceWidth,
          ),
          Center(
            child: Padding(
              padding: ProjectPaddings.cardOutPadding,
              child: Container(
                padding: ProjectPaddings.cardInPadding,
                width: deviceWidth / 1.5,
                height: deviceHeight / 2,
                decoration: decorationContainer(),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: labelText,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return email;
                          } else if (!GetUtils.isEmail(value)) {
                            return errorEmail;
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          labelText: labelTextPassword,
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return password;
                          }
                          return null;
                        },
                      ),
                      CustomButton(
                        buttonText: buttonText,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _authController.login(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                      ),
                      CustomTextButton(
                        text: text,
                        onPressed: () {
                          Get.to(ForgotPasswordPage());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
