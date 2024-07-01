import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tez_front/models/user_model.dart';
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/services/auth_service.dart';

class UserTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt tabIndex = 0.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null); // Kullanıcı bilgilerini tutmak için değişken
  final AuthService authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });

    // Kullanıcı bilgilerini al
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final user = await authService.fetchUserProfile();

      this.user.value = user;
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  Future<XFile?> pickImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
