import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:xpenses_v2/screens/expenses/expensesController.dart';
import 'package:xpenses_v2/screens/goals/goalsController.dart';
import 'package:xpenses_v2/screens/incomes/incomesScreenController.dart';
import 'package:xpenses_v2/screens/tapBar/tapBar.dart';

class SplashController extends GetxController {
  IncomesScreenController incomesController =
      Get.put(IncomesScreenController());
  ExpensesController expensesController = Get.put(ExpensesController());
  GoalsController goalsController = Get.put(GoalsController());
  // late StreamSubscription<bool> subs;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ensureInit();
  }

  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;
    try {
      if (isBiometricSupported && canCheckBiometrics) {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason: 'WHO ARE YOU MY FRIEND?',
          // biometricOnly: false,
          // useErrorDialogs: true
        );
      }
    } catch (e) {
      print(e);
    }

    return isAuthenticated;
  }

  ensureInit() async {
    bool auth = await authenticateWithBiometrics();
    if (auth) {
      if (incomesController.ready != null) {
        Get.off(() => MyTabBar());
        // subs.cancel();
      } else {
        Future.delayed(Duration(seconds: 1), () {
          ensureInit();
        });
      }
    } else {
      exit(0);
    }
  }
}
