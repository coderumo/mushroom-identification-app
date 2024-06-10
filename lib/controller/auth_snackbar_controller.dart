import 'package:get/get.dart';

class AuthController extends GetxController {
  var isGuest = false.obs;

  void continueAsGuest() {
    isGuest.value = true;
  }

  void login() {
    isGuest.value = false;
  }

  void snackBar() {
    Get.snackbar('Erişim Engellendi', 'Giriş yapmanız gerekemektedir');
  }
}
