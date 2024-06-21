import 'package:get/get.dart';
import 'package:tez_front/controller/auth_controller.dart';

class BottomBarController extends GetxController {
  AuthController authController = Get.put(AuthController());
  var tabIndex = 0.obs;
}
