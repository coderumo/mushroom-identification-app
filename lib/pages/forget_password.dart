import 'package:flutter/material.dart';
import 'package:tez_front/constants/padding_constant.dart';
import 'package:tez_front/widgets/custom_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  void sendResetLink() {
    String email = emailController.text;
    print('Şifre sıfırlama bağlantısı $email adresine gönderildi.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şifremi Unuttum'),
      ),
      body: Padding(
        padding: ProjectPaddings.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-posta adresiniz',
              ),
            ),
            const SizedBox(height: 20.0),
            CustomButton(
              onPressed: sendResetLink,
              buttonText: 'Şifremi Sıfırla',
            ),
          ],
        ),
      ),
    );
  }
}
