import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpenses_v2/screens/splash/splashController.dart';

class SplashScreen extends StatelessWidget {
  SplashController controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) => Container(
        color: Colors.white,
        child: Image.asset('images/walletG.gif'),
      ),
    );
  }
}
