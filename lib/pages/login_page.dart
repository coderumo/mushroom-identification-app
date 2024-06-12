import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/background_image.dart';
import 'package:tez_front/pages/home_page.dart';
import '../constants/padding_constant.dart';
import '../widgets/box_decoration.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    BackgroundImage image = BackgroundImage();

    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Image.asset(
          image.backgroundImage,
          fit: BoxFit.cover,
          height: deviceHeight,
          width: deviceWidth,
        ),
        const Center(
          child: LoginCard(),
        ),
      ]),
    );
  }
}

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;

    const labelText = 'E-Mail';
    const labelTextPassword = 'Password';
    const buttonText = 'Giriş';
    const text = 'Şifremi Unuttum..';
    const email = 'E-mail gerekli';
    const errorEmail = 'Hatalı E-mail';
    const password = 'Şifre Gerekli';

    return Padding(
      padding: ProjectPaddings.cardOutPadding,
      child: Container(
        padding: ProjectPaddings.cardInPadding,
        width: deviceWidth / 1.5,
        height: deviceHeight / 2,
        decoration: decorationContainer(),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
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
                controller: _passwordController,
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
                  if (_formKey.currentState!.validate()) {
                    Get.to(const HomePage());
                  }
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
      ),
    );
  }
}
