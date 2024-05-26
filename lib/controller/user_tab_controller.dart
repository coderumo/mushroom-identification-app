import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/navigation_tab/user_tab.dart';

class UserTabController extends GetxController
    with SingleGetTickerProviderMixin {
  late TabController tabController;
  RxInt tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(vsync: this, length: MyTabViews.values.length);
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
