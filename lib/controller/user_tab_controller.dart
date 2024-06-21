import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/navigation_tab/profile_tab.dart';

class UserTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
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
