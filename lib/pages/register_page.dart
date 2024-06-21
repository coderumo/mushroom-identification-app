import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/background_image.dart';
import 'package:tez_front/controller/auth_controller.dart';
import '../constants/padding_constant.dart';
import '../widgets/custom_button.dart';
import '../widgets/box_decoration.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;

    BackgroundImage image = BackgroundImage();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            image.backgroundImage,
            fit: BoxFit.cover,
            height: deviceHeight,
          ),
          const Center(child: RegisterCard()),
        ],
      ),
    );
  }
}

class RegisterCard extends StatefulWidget {
  const RegisterCard({Key? key}) : super(key: key);

  @override
  _RegisterCardState createState() => _RegisterCardState();
}

class _RegisterCardState extends State<RegisterCard> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordAgainController = TextEditingController();

  final AuthController authController = Get.find();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;

    const buttonText = 'Kayıt Ol';
    const labelName = 'İsim';
    const labelKullaniciAdi = 'Kullanıcı Adı';
    const labelMail = 'E-Mail';
    const labelPassword = 'Şifre';
    const labelPasswordAgain = 'Şifre Tekrar';
    const requiredName = 'İsim gerekli';
    const requiredUserName = 'Kullanıcı Adı Gerekli';
    const requiredEmail = 'E-mail Gerekli';
    const invalidEmail = 'Geçersiz Email';
    const requiredPassword = 'Şifre Gerekli';
    const againPassword = 'Şifre Tekrar';
    const errorPassword = 'Şifreler Uyuşmuyor';

    return Container(
      padding: ProjectPaddings.cardInPadding,
      width: deviceWidth / 1.5,
      height: deviceHeight / 1.75,
      decoration: decorationContainer(),
      child: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: labelName,
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return requiredName;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: labelKullaniciAdi,
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return requiredUserName;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: labelMail,
                  ),
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return requiredEmail;
                    } else if (!GetUtils.isEmail(value)) {
                      return invalidEmail;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    labelText: labelPassword,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return requiredPassword;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordAgainController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    labelText: labelPasswordAgain,
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return againPassword;
                    } else if (value != _passwordController.text) {
                      return errorPassword;
                    }
                    return null;
                  },
                ),
                CustomButton(
                  buttonText: buttonText,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authController.register(
                        _nameController.text,
                        _usernameController.text,
                        _emailController.text,
                        _passwordController.text,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
