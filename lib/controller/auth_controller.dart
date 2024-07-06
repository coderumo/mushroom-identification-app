import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/models/user_model.dart';
import 'package:tez_front/pages/home_page.dart';
import 'package:tez_front/pages/login_page.dart';
import '../services/auth_service.dart';
import '../models/general_response.dart';

class AuthController extends GetxController {
  var isGuest = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void continueAsGuest() {
    isGuest.value = true;
  }

  void login() async {
    try {
      final email = emailController.text;
      final password = passwordController.text;
      GeneralResponse response = await _authService.login(email, password);

      if (response.success) {
        final token = ((response.data as Map<String, dynamic>)['token']);
        final user = ((response.data as Map<String, dynamic>)['user']);

        final userModel = UserModel.fromJson(user);
        Database().login(token, userModel);
        print("token: ${Database().tokenBox.get('token')}");
        Get.snackbar('Başarılı', 'Başarıyla giriş yapıldı');
        Get.offAll(const HomePage());
      } else {
        Get.snackbar('Hata', response.message);
      }
    } catch (e) {
      Get.snackbar('Hata', e.toString().split("Exception:").last);
    }
  }

  void register(
      String name, String userName, String email, String password) async {
    try {
      GeneralResponse response =
          await _authService.register(name, userName, email, password);

      if (response.success) {
        Get.snackbar('Başarılı', 'Kayıt başarılı');
        Get.offAll(LoginPage());
      } else {
        Get.snackbar('Hata', response.message);
      }
    } catch (e) {
      Get.snackbar('Hata', e.toString().split("Exception:").last);
    }
  }

  void snackBar() {
    print("jjjjjjjjjjj");
    Get.snackbar('Erişim Engellendi', 'Giriş yapmanız gerekmektedir');
  }
}
