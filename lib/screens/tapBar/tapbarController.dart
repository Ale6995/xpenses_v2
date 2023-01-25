import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabController extends GetxController with SingleGetTickerProviderMixin {
  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 3);
    controller.addListener(() {
      update();
    });
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
